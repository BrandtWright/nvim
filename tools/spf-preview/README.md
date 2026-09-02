# spf preview

An interactive, live-updating visual document of the spf UI/color design
system. Every color is resolved by running the real theme assembler
(`spf/init.lua`) under headless nvim, so the page shows exactly what the
colorscheme computes — not a hand-copied snapshot. Prose (decisions, next
steps, open questions) is sliced live from `colors.md` and `UI_REFACTOR.md`.

## Run it

```sh
make preview                 # from the repo root
# or:
python3 tools/spf-preview/serve.py [PORT]   # default 8765
```

Then open the printed <http://127.0.0.1:8765/> in a browser. Edit any
`lua/spf/**` source (or `picker.lua` / `statusline.lua` / the `.md` docs) and
save — the page refreshes within ~2s. The green dot in the header shows the live
connection.

## What it shows

- **Palette** — raw hex swatches (with HSL), grouped by role; the chrome/UI keys
  the refactor added are called out separately.
- **The concept system** — the "panel hosts controls" vocabulary rendered as a
  live widget, the orthogonal axes, and the label/ghost/accent text bands (with
  the ghost-contrast bug visible per surface).
- **Primitives** — each named style rendered, UI concepts first.
- **Live mockups** — statusline, snacks picker, Pmenu, diagnostics/diff, and a
  syntax-highlighted buffer, all from resolved highlight groups.
- **Group → concept map** — every semantic group and the concept it binds to,
  filterable.
- **Decisions** — the decision history from `colors.md`.
- **What's left** — a status board and "where more clarity is needed" callouts.

## How it works

- `extract.lua` — headless-nvim script; `require("spf").apply()` then dumps
  palette + primitives + links + resolved colors to `$SPF_PREVIEW_OUT`.
- `serve.py` — serves `index.html` and `/design.json`; re-runs the extractor
  when any watched `.lua` source changes (mtime), slices the markdown docs, and
  serves the combined JSON with no-cache headers.
- `index.html` — self-contained page; fetches `/design.json`, polls every 2s,
  and themes itself from spf's own resolved colors.

Colors resolve with xrdb absent (headless), so you see the baked-in fallbacks —
the same values the theme uses without xresources present.

This is a working aid for the in-flight UI refactor, not shipped config.
