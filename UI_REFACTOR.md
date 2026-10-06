# spf UI Refactor — work-in-flight summary

> Temporary working doc to reorient after a break — "where were we." Tracked on
> the `feat/spf-ui-concept-layer` branch. Delete (or fold into `colors.md`) when
> the refactor lands. The durable design record lives in `colors.md`.

## The big picture / why

We groomed spf's **syntax** layer earlier (roles → colors, documented in
`colors.md`). This effort does the same for the **UI / chrome** layer: turn an
ad-hoc pile of highlight links into a small **system of named concepts** whose
colors are swappable without disturbing structure — the same discipline as
syntax.

Three load-bearing principles guiding everything:

1. **Concepts, not colors.** A group binds to a *concept* (`panel`, `list`,
   `ghost`, …), never a raw tone. Colors are swappable presentation.
2. **Syntax and UI are separate color domains.** A UI group must not bind to a
   syntax group (or vice versa). They share the xresources palette but stay
   decoupled, so the UI palette and syntax palette can be tuned independently
   (this matters for the planned standalone / light / cterm variants).
   Deliberate crossover (e.g. a picker match rendering a syntax hue) is allowed
   but *explicit*.
3. **Concepts are application-agnostic.** A "panel" is a panel in tmux, xmobar,
   dmenu, or a Neovim float. spf is *one realization*; all pull from the shared
   **xresources** DB. spf stays coupled to nothing but xresources. (So the
   mapping of concept→Neovim-component is not necessarily 1:1 with other apps.)

## Baseline / branch state

- Branch: `feat/spf-ui-concept-layer`, cut from `main` at `820a1a4`
  ("feat(spf): messages follow diagnostic error/warn role").
- **All implementation work below is committed** on the branch; nothing is
  pending in the working tree. Branch commits (oldest first):

  ```text
  a73fd0f refactor(spf): recast UI chrome as a named concept system
          palette.lua, primitives.lua, groups/ui.lua, groups/filetypes.lua
  ce48d59 feat(picker): speak the spf UI concept vocabulary
          lua/plugins/picker.lua
  780a0b5 docs(spf): record the UI/chrome concept system and decisions
          colors.md (now tracked: decisions #17–#24)
  c886b19 chore(tools): add live spf design-system preview
          tools/spf-preview/*, Makefile `preview` target
  711b99e docs(spf): reopen the gradient/statusline question as TBD
          colors.md #20 + preview status board
  ```

  Plus the commit that tracks this file.
- Diff vs `main`: 12 files, ~1600 insertions (mostly `colors.md` and the
  preview tool).
- No-AI-attribution rule applies to commits in this repo.
- Checked 2026-10-06: `luacheck lua/spf/ lua/plugins/picker.lua` clean (0/0);
  `make test FILE=tests/spf_spec.lua` 6/6 pass.

## Where things are documented

- **`colors.md`** (tracked) — durable design record: principles, UI axes,
  Panels & controls vocabulary, decision history (#17–#24; #24 = the
  surfaces × roles grid, designed not coded; #20 carries the gradient TBD).
- **`tools/spf-preview/`** — live visual of the system (see below); its page
  has a hardcoded done/WIP status board (`index.html`, `BOARD`) that should be
  kept in sync with this file.
- **This file** — the only place holding the ordered next steps, the full
  deferred list, and the verify loop. Decide later what moves to `colors.md`.

## What's IMPLEMENTED (committed; luacheck-clean, 6/6 spf specs pass)

### Palette (`lua/spf/palette.lua`)

Old ordinal accents (`primary/secondary/tertiary_accent*`) replaced with
semantic keys, all still `load("screen_glasses.ui.<key>") or <fallback>`:

- `chrome_fg` `#a8948a` — muted chrome foreground
- `surface` `#221c19` — the one dark warm surface (chrome bands + list bg)
- `surface_border` `#473b34` — warm float/panel border/band
- `textbox_bg` `#382e29` — editable-field well, lifted above surface
- `cursorline` `#221c19` — faint current-line lift
- `visual_selection` `#3a3a3a` — neutral-gray selected-item bg
- (added `surface_overlay` earlier, then removed when the elevation ramp
  collapsed)

### Primitives (`lua/spf/primitives.lua`) — the concept layer

- **Chrome axes:** `chrome_active` (chrome_fg on surface), `chrome_inactive`
  (bright_black fg on same surface — focus is a *foreground* change, not a bg
  step).
- **Emphasis:** `selection` (gray bg), `cursor_block` (inverted).
- **Structure:** `current_line` (faint warm lift, deliberately NOT the gray
  emphasis family — must blend with Normal, easy on the eyes).
- **Recede:** `recede` = dim editor furniture (borrows `bright_black`, named as
  a concept so it can diverge).
- **Composite vocabulary (panel hosts controls):**
  - `panel` = frame band + title fg (white on surface_border)
  - `textbox` = editable input (white on textbox_bg)
  - `list` = selectable list (white on surface)
  - `view` = embedded content buffer = `Normal` (no primitive; content plane)
  - `border` = line-style panel edge (FloatBorder)
- **Text prominence:** `ghost` = muted secondary text (borrows `bright_black`).
  `label` is NOT a primitive — it's just the surface's own fg.

### Core UI groups (`lua/spf/groups/ui.lua`)

- `NormalFloat = Normal` (a float is a *container*; content floats like picker
  previews must read as a buffer — a `view`). `FloatTitle/Footer` follow it.
- `Pmenu = list`, `PmenuSel = selection` (completion menu is a list).
- `Visual/QuickFixLine/WildMenu = selection`; `Cursor = cursor_block`.
- `CursorLine/CursorColumn/ColorColumn = current_line`.
- `StatusLine/WinBar/TabLineSel = chrome_active`; `*NC/TabLine/TabLineFill =
  chrome_inactive`.
- `FloatBorder = border`.
- **Recede concept** applied: `LineNr/Folded/NonText/Conceal/ModeMsg/MoreMsg =
  recede` (no UI group binds raw `bright_black` anymore). `Folded` now *recedes*
  (was chrome accent). `Question = white`. These also closed earlier palette
  *leaks* where `{}` groups inherited off-palette Neovim defaults.

### Elevation collapsed to two planes

Earlier we had a 3-rung brightness ramp (`e0/e1/e2`). Collapsed to **content vs
one dark surface** — spf surfaces never stack, so depth is read from the
**border**, not brightness. This is why chrome went back to the dark `#221c19`
(easy on the eyes) and the border became the delineator.

### Picker (`lua/plugins/picker.lua`) — first consumer, speaks the vocabulary

All in the existing `highlights.on_colorscheme("SnacksHighlights", …)` block +
a `default` layout override. spf core stays plugin-agnostic; this wiring is
plugin-layer only.

- `SnacksPicker -> list`, `SnacksPickerInput -> textbox`,
  `SnacksPickerPreview -> Normal` (view),
  `SnacksPickerListCursorline -> selection`.
- **Solid borders** (filled bands, no line glyphs): `default` layout uses
  `border = "solid"`, inner input/list borders `"none"` (no divider line).
- Frames + titles painted as `panel`: `SnacksPickerBoxBorder`,
  `SnacksPickerPreviewBorder`, `SnacksTitle`, `SnacksPickerPreviewTitle`.
  - **Gotcha (verified via headless probe):** the box/line-picker title's text
    is tagged `FloatTitle`, and the box window's `winhighlight` merge drops the
    picker prefix → it resolves to the *shared* `SnacksTitle`, not
    `SnacksPickerBoxTitle`. So we paint `SnacksTitle`. Safe: notifier and
    snacks-input use their own title groups; only picker/scratch titles are
    affected.
- **Ghost text wired:** `SnacksPickerTotals/Dir/PathHidden/Comment/Desc ->
  ghost`. Notably `Comment`/`Desc` had bound to the *syntax* `Comment` group —
  this is the concrete decoupling of picker chrome from a syntax color. Visual
  no-op today.

### Live preview tool (`tools/spf-preview/`, `make preview`)

`make preview` (`PORT=8765` default) runs `serve.py`, which re-runs
`extract.lua` under headless nvim (the real `spf/init.lua` assembler) whenever a
`lua/spf/**` source, `picker.lua`/`statusline.lua`, or the `.md` docs change,
and slices design docs from `colors.md` and this file. The page polls and shows:
palette, primitives, concept vocabulary, axes, label/ghost/accent text bands
(ghost-contrast failure visible per surface), live mockups (statusline, picker,
Pmenu, diagnostics/diff), group→concept map, decision history, and a status
board. Port must be published to the host to view it from outside the sandbox.

## DESIGNED but NOT YET IMPLEMENTED — pick up HERE

The last stretch of conversation was pure design (no code written). We converged
on a **surfaces × roles grid** model that *supersedes* how
`selection`/`current_line` are currently structured in the primitives. Nothing
below is in the code yet. It is captured durably in `colors.md`
(**decision #24**); this section is the working restatement.

### The grid model

The unit of the system is a **surface** = a background plus the foregrounds
guaranteed legible on it:

```text
surface = { bg, label, ghost, accent }
```

- **label** = normal/primary text (a surface's "fg" IS its label).
  Titles/"stand-out" = label **+ bold** (bold is an orthogonal *attribute*, not
  a grid cell).
- **ghost** = muted secondary text.
- **accent** = stands-out-via-HUE (matched substring, flag, severity). This is
  the sanctioned explicit crossover where UI borrows the shared palette hues
  (`SnacksPickerMatch` ≈ gold/Special). Accent is a color, not a weight.

Roles ranked by contrast-fragility (drives how often a per-surface override is
needed): **ghost = fragile (the real per-surface worker) · label = robust ·
accent = most robust.** Only `bg + label + ghost` are the contrast-sensitive
work.

### States are surfaces (the key anti-sprawl move)

A state that swaps the background *is itself a surface*; the same text roles
re-resolve against the new bg. So we do NOT invent `selected-fg`,
`matched-on-selected`, etc. — they're cells of the state-surface.

**Naming fix we agreed on but haven't applied:** current code has `list`
(component) and `selection` (state) as *peers* — wrong altitude. Model instead
as **component + state**:

- Surfaces (components): `content`, `list`, `textbox`, `panel`.
- **`selected`** (rename from `selection`) is a *shared state* any selectable
  surface enters (a list's current row, a completion row, a buffer's Visual
  range all resolve onto the same `selected` surface).
- **`content` carries TWO states** because in a buffer cursor ≠ selection:
  - `current-line` (subtle warm — the cursorline) and
  - `selected` (gray — Visual). They can stack.
  - A `list` collapses both into just `selected` (cursor = selection). This is
    exactly why snacks maps list `CursorLine -> Visual`.

### Inheritance = the generalization (avoid per-surface bespoke sets)

Do NOT give each surface a fully unique property set, and do NOT hardcode one
global ghost either (that bakes a "surfaces stay close in lightness" assumption
into the schema — the very coupling we're avoiding). Instead: **role defaults +
per-surface override, resolved through xresources fallback chains**, e.g.
`load("list.ghost") or load("text.ghost") or <default>`. Common case = one
default everywhere; a diverging surface overrides *one slot* only, reactively,
the day its bg moves out of contrast range. Palette's existing
`load(key) or fallback` already IS this mechanism.

## KNOWN BUG to fix when resuming

**`ghost` (#756157) fails WCAG on most surfaces.** Measured contrast: content
3.08:1, list 2.89, textbox 2.27, panel band 1.85 (floor ≈ 3:1). It's genuinely
too faint right now. Candidate single default `#9a8578` clears 3:1 on every
current surface (5.1 / 4.8 / 3.8 / 3.1) while staying ~40% of label contrast
(clearly secondary). `label` (white) is fine everywhere (8–13:1). Apply as the
default `ghost`, but implement via the default+override shape above, not as a
hardcoded global.

## Suggested next steps (rough order)

1. **Restructure primitives to the grid**: make `selection`→`selected` a
   first-class state-surface; add `current-line` as a content-only state
   sibling; express `{bg, label, ghost, accent}` per surface via role-default +
   per-surface override (xresources fallback chains). Keep all per-surface keys
   *defined with fallback* but pointing at the shared default for now.
2. **Fix ghost contrast** (default `#9a8578`) as part of step 1.
3. **Re-wire the picker** so match/selected/ghost all resolve through the grid —
   makes selected-row text legibility (label/ghost/match ON the selection bg)
   explicit rather than accidental.
4. **Rename `selection`→`selected`** everywhere (primitives + ui.lua groups +
   picker) — confirm the name with the user first (`selected` vs `current`;
   avoid `active`, which collides with focus).
5. Update `colors.md` to match (axes table, Panels & controls, decision
   history).
6. Keep the preview's status board (`tools/spf-preview/index.html`, `BOARD`)
   and this file in sync as items land.
7. Later / deferred:
   - Statusline-as-panel reconcile: status bars (statusline, tmux, xmobar)
     still use `chrome_*`, not the panel vocabulary. Tied to the gradient TBD
     below.
   - Rename the xresources keys (`screen_glasses.ui.*`) to concept names.
   - Apply the vocabulary to the other consumers `colors.md` sketches:
     completion menu = panel + list (+ view for docs), which-key = panel +
     list, hover = panel + view, `vim.ui.input` = panel + textbox.
   - `vim.ui.input` and the `vscode` picker layout still use old line borders.
   - Search/IncSearch/CurSearch and Spell colors are deliberately unsettled
     (WIP) — leave alone unless asked.

## OPEN DECISIONS awaiting the user

- **State name:** `selected` (recommended) vs `current` vs `active`.
- Exact **default `ghost` tone** (`#9a8578` proposed; user may want to eyeball
  the ramp — `#a8948a` brighter, `#8a7468` dimmer-but-dips-below-floor).
- Whether to pre-author any per-surface ghost overrides now (recommendation: no
  — let them appear reactively in xresources).
- **Statusline gradient — and the gradient concept itself (TBD).** lualine's
  A/B/C tiers flattened when #20 removed the primary/secondary/tertiary ramp. A
  statusline legitimately wants a gradient, so this is open — and it reopens a
  deeper question: was removing the gradient concept wholesale the wrong call?
  Options: keep it removed (lualine = one-off plugin-layer gradient) vs promote
  "gradient" to a bounded first-class UI concept. The earlier "restore the
  gradient" decision is withdrawn back to open. Noted, not decided; think it
  through later — other UI may benefit from a gradient too.

## Verify loop (how we've been checking)

- `luacheck lua/spf/ lua/plugins/picker.lua`
- `make test FILE=tests/spf_spec.lua` (6 specs; the coverage spec is a ratchet
  on load-bearing groups).
- Headless resolve check pattern:
  `nvim --clean --headless --cmd 'set rtp+=<repo>' -c 'lua require("spf").apply();
  vim.cmd("colorscheme spf"); <inspect vim.api.nvim_get_hl(0,{name=..,link=false})>'`
- For snacks group wiring, a headless probe opening a real picker and dumping
  each window's `winhighlight` was what revealed the `SnacksTitle` gotcha. NOTE:
  loading the *full* config headless via `-u init.lua` doesn't load spf (lazy
  can't import specs headless → falls back to default scheme), so use the
  `--cmd 'set rtp+='` + `require("spf").apply()` simulation for color values; use
  the full-config probe only for structural `winhighlight` facts.
- Visual check: `make preview` (see the preview tool section).
- `make lint-types` needs lua_ls (not in sandbox); luacheck is the available
  linter.
