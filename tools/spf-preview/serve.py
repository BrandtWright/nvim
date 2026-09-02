#!/usr/bin/env python3
"""Local dev server for the spf design-system preview.

Serves index.html and a live /design.json built from the *source of truth*:

  * colors  -- resolved by running the real theme assembler under headless nvim
              (extract.lua), regenerated whenever any lua/spf/** (or the picker /
              statusline plugin) file changes on disk;
  * prose   -- the design decisions, next steps and open questions sliced live
              out of colors.md and UI_REFACTOR.md.

The page polls /design.json, so editing a source file and saving updates the
page within a couple of seconds -- no manual rebuild.

    python3 tools/spf-preview/serve.py [PORT]      # default 8765

Then open the printed http://127.0.0.1:PORT/ in a browser.
"""

from __future__ import annotations

import json
import os
import subprocess
import sys
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
from pathlib import Path

HERE = Path(__file__).resolve().parent
REPO = HERE.parents[1]  # tools/spf-preview -> repo root
COLORS_JSON = HERE / ".colors.json"
EXTRACT = HERE / "extract.lua"
INDEX = HERE / "index.html"

# Source files whose changes should re-resolve the palette (via nvim).
LUA_SOURCES = sorted((REPO / "lua" / "spf").rglob("*.lua")) + [
    REPO / "lua" / "plugins" / "picker.lua",
    REPO / "lua" / "plugins" / "statusline.lua",
]
# Prose sources (sliced in-process, no nvim needed).
DOC_SOURCES = [REPO / "colors.md", REPO / "UI_REFACTOR.md"]

# Which markdown sections to surface, keyed for the page. Values are matched
# against "## " headings by case-insensitive substring.
DOC_SECTIONS = {
    "principles": ("colors.md", "Principles"),
    "uiSystem": ("colors.md", "UI / chrome"),
    "panels": ("colors.md", "Panels & controls"),
    "decisions": ("colors.md", "Decision history"),
    "bigPicture": ("UI_REFACTOR.md", "big picture"),
    "designedNotCoded": ("UI_REFACTOR.md", "DESIGNED but NOT YET"),
    "knownBug": ("UI_REFACTOR.md", "KNOWN BUG"),
    "nextSteps": ("UI_REFACTOR.md", "next steps"),
    "openDecisions": ("UI_REFACTOR.md", "OPEN DECISIONS"),
}

_state = {"colors_mtime": 0.0, "docs_mtime": 0.0, "docs": {}}


def _max_mtime(paths) -> float:
    best = 0.0
    for p in paths:
        try:
            best = max(best, p.stat().st_mtime)
        except OSError:
            pass
    return best


def slice_sections(text: str):
    """Split markdown into (title, body) pairs on level-2 (## ) headings."""
    out, title, body = [], None, []
    for line in text.splitlines():
        if line.startswith("## "):
            if title is not None:
                out.append((title, "\n".join(body).strip()))
            title, body = line[3:].strip(), []
        elif title is not None:
            body.append(line)
    if title is not None:
        out.append((title, "\n".join(body).strip()))
    return out


def load_docs() -> dict:
    cache = {}
    for src in DOC_SOURCES:
        try:
            cache[src.name] = slice_sections(src.read_text(encoding="utf-8"))
        except OSError:
            cache[src.name] = []
    docs = {}
    for key, (fname, needle) in DOC_SECTIONS.items():
        body = ""
        for title, sect in cache.get(fname, []):
            if needle.lower() in title.lower():
                body = f"## {title}\n\n{sect}"
                break
        docs[key] = body
    return docs


def regenerate_colors() -> dict:
    """Run the headless-nvim extractor; return {} on failure with an error."""
    env = dict(os.environ, SPF_REPO=str(REPO), SPF_PREVIEW_OUT=str(COLORS_JSON))
    proc = subprocess.run(
        ["nvim", "--headless", "--clean", "-n",
         "-c", f"luafile {EXTRACT}", "-c", "qa!"],
        cwd=str(REPO), env=env, capture_output=True, text=True, timeout=60,
    )
    if proc.returncode != 0:
        return {"error": f"nvim extract failed (exit {proc.returncode}):\n{proc.stderr}"}
    try:
        return json.loads(COLORS_JSON.read_text(encoding="utf-8"))
    except (OSError, json.JSONDecodeError) as exc:
        return {"error": f"could not read generated colors: {exc}"}


def build_design() -> dict:
    lua_mtime = _max_mtime(LUA_SOURCES)
    if lua_mtime > _state["colors_mtime"] or not COLORS_JSON.exists():
        _state["colors"] = regenerate_colors()
        _state["colors_mtime"] = lua_mtime
    docs_mtime = _max_mtime(DOC_SOURCES)
    if docs_mtime > _state["docs_mtime"] or not _state["docs"]:
        _state["docs"] = load_docs()
        _state["docs_mtime"] = docs_mtime

    design = dict(_state.get("colors", {}))
    design["docs"] = _state["docs"]
    design["meta"] = {
        "repo": str(REPO),
        "coloredAt": lua_mtime,
        "sources": [p.name for p in LUA_SOURCES if p.exists()],
    }
    return design


class Handler(BaseHTTPRequestHandler):
    def _send(self, body: bytes, ctype: str, code: int = 200):
        self.send_response(code)
        self.send_header("Content-Type", ctype)
        self.send_header("Content-Length", str(len(body)))
        self.send_header("Cache-Control", "no-store")
        self.end_headers()
        self.wfile.write(body)

    def do_GET(self):
        path = self.path.split("?", 1)[0]
        if path in ("/", "/index.html"):
            try:
                self._send(INDEX.read_bytes(), "text/html; charset=utf-8")
            except OSError as exc:
                self._send(str(exc).encode(), "text/plain", 500)
        elif path == "/design.json":
            body = json.dumps(build_design()).encode("utf-8")
            self._send(body, "application/json")
        else:
            self._send(b"not found", "text/plain", 404)

    def log_message(self, *args):  # quiet: skip default per-request logging
        pass


def main():
    port = int(sys.argv[1]) if len(sys.argv) > 1 else int(os.environ.get("SPF_PREVIEW_PORT", 8765))
    httpd = ThreadingHTTPServer(("127.0.0.1", port), Handler)
    print(f"spf preview  ->  http://127.0.0.1:{port}/")
    print(f"repo: {REPO}")
    print("watching lua/spf/**, picker.lua, statusline.lua, colors.md, UI_REFACTOR.md")
    print("edit a source file and save; the page refreshes within ~2s. Ctrl-C to stop.")
    try:
        httpd.serve_forever()
    except KeyboardInterrupt:
        print("\nstopped.")


if __name__ == "__main__":
    main()
