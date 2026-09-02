# spf color system — reference & decisions

> **STATUS (UI refactor in flight):** the UI reference tables below document the
> *currently-implemented* state. A **surfaces × roles grid** (designed, not yet
> coded) supersedes the `selection`/`current_line` structure — see **decision #24**
> for the full design, the `selection → selected` rename, the known ghost-contrast
> bug, and the open decisions. Treat `selection`/`current_line` in the tables as
> **not final**. `UI_REFACTOR.md` (repo root, temporary) holds only the operational
> resume aids (ordered next steps + verify loop) and can be deleted once this lands.
>
> Living reference for spf's color system: the principles, the role→color map,
> open color slots, and the reasoning behind each decision. A working file we
> keep — untracked, not gitignored, not shipped. Covers the **syntax** layer and
> the **UI / chrome** layer; diagnostics are partly folded in (severity rows
> below), and search-visual stays deliberately unsettled. Once every group is
> covered this is meant to graduate into real documentation.

## Principles

The model is **semantic**: every token maps to a *role* (what kind of thing it
is — control flow, type, identifier, word-operator, …), and color is a swappable
*presentation* of that role. Get the roles right and recoloring is mechanical;
the mental model — not the specific hues — is what makes code readable. Colors
can be reshuffled later at low cost as long as the role assignments stay coherent.

- **Color follows meaning.** When a representative group exists for a role, link
  to *it*, not a raw color — every control-flow capture links to `Statement`, so
  re-theming control flow is a one-line change. Leaf roles with no representative
  group (namespaces, word operators) link straight to a primitive — still a
  one-line recolor.
- **`{}` means inherit, don't restate.** `init.lua` skips empty specs, leaving the
  group at Neovim's default. Defaults link `@captures` through a fallback chain
  to the legacy syntax groups, so `groups/syntax.lua` is the backbone and
  `groups/treesitter.lua` only overrides deliberate deviations. A link that equals
  the default is noise.
- **One token, one look — across layers.** A token renders the same whether drawn
  by legacy syntax, treesitter, or LSP semantic tokens: mirror legacy↔treesitter,
  and never let an `@lsp.type.*` override diverge from its treesitter equivalent.
  No special rules for TS/JS.
- **Builtins follow their category.** A `*.builtin` capture is still a member of
  its role (`@type.builtin` is a type), so it takes that role's color, anchored
  to the parent — overriding Neovim's default of routing the whole `.builtin`
  family to `Special`/gold.
- **Italic marks a reference-from-elsewhere.** Function/method *calls* (vs
  definitions) and *parameters* (vs locals) are italic — a cue layered on the base
  color, never a separate role.

## Layering

`palette` (raw hex from xresources) → `primitives` (named styles, e.g.
`green = {fg=…}`) → `groups/*` (role → primitive, or → representative group).
`init.lua` merges every `groups/*.lua`, then applies concrete specs and links.

## Role / Anchor / Color

`Anchor` = the representative group a role links through (so its color lives in
one place); `—` = leaf role linked straight to a color primitive.

| Role (meaning) | Key captures / groups | Anchor | Color |
| --- | --- | --- | --- |
| Control flow | `@keyword.conditional/repeat/return/exception`, `Conditional`/`Repeat`/`Exception` | `Statement` | magenta |
| Keywords | `@keyword`, `@keyword.type`/`.modifier`, `StorageClass`/`Structure` | `Keyword` | blue |
| Preprocessor / import | `@keyword.import`, `Include`/`Define`/`Macro` | `PreProc` | blue |
| Types (names) | `@type`, `@type.definition`, `@constructor`, `Typedef` | `Type` | green |
| Namespaces (type-adjacent) | `@module`, `@lsp.type.namespace` | — | bright_green |
| Functions | `@function*`, `@lsp.type.function`/`method` | `Function` | yellow (calls + method calls italic; defs plain) |
| Strings / raw | `String`, `@markup.raw` | — | orange |
| Literals / constants | `Number`/`Boolean`/`Char`/`Float`, `@constant`, enum members | `Constant` | bright_cyan |
| Identifiers — vars, fields | `@variable`, `@variable.member`, `@property` | `Identifier` | white |
| Parameters | `@variable.parameter`, `@lsp.type.parameter` | — | white + **italic** |
| **Word operators** | `@keyword.operator` (`and`/`or`/`not`/`in`/`is`) | — | **rose** |
| Symbolic operators | `@operator` — `=` `+` `==` `&&` `!` etc. | `Operator` | white (neutral) |
| Labels / tags | `@label`, `@tag` (HTML/JSX) | `Label`/`Tag` | cyan |
| Errors / removed | `Error`, `Removed` | — | red |
| Special — escapes, special chars/punct | `Special*`, `@string.escape`/`.regexp`, `@character.special`, `@punctuation.special`, `@variable.parameter.builtin` (`_`/`it`) | `Special` | bright_gold |
| Comments | `Comment`, `@comment` | — | gray (bright_black) |
| Diagnostics | `DiagnosticError/Warn/Info/Hint/Ok` | — | red / yellow / blue / magenta / green |
| Comment-attention | `@comment.error/warning/note` → diagnostics; `Todo` → `DiagnosticHint` | (diagnostics) | red / yellow / blue / **magenta (todo)** |
| Checkbox states | `@markup.list.*` (native) + render-markdown custom states | (diagnostics) | done→Ok green, todo→Hint magenta, doing→Info blue, wait→Warn yellow, important→Error red, cancelled→Comment gray+struck |

Warm for data (strings/code), cool for control, neutral for identifiers.

`.builtin` variants are **not** a separate role: each follows its parent category
(`@type.builtin` green, `@function.builtin` yellow, `@constant.builtin` cyan,
`@module.builtin` bright_green, `@tag.builtin` cyan, `@variable.builtin` white,
`@attribute.builtin` blue), overriding Neovim's default of sending them all to
`Special`/gold. The lone exception is `@variable.parameter.builtin` (`_`/`it`) —
a genuine placeholder, left at Special.

## UI / chrome — the system

The UI is a separate model from syntax. Where syntax maps *tokens → roles → hue*,
chrome is built from a handful of **orthogonal axes**, each hue-agnostic, so the
colors are swappable while the structure holds.

### One principle: two planes

The editor is **content** (your text — owns *all* hue, via the syntax layer) and
**chrome** (everything spf draws around it — stays achromatic-warm). A UI group
wearing a syntax hue is a bug; that rule is what catches palette leaks (the old
`ModeMsg`-green, `Question`-cyan came from inheriting Neovim defaults).

### Two background vocabularies

Chrome backgrounds answer two different questions, and use two visually-distinct
families so they never blur:

- **Warm-brown ramp → "where am I / what surface is this"** (structure & depth)
- **Neutral-gray → "what have I picked"** (selection / current item)

One is chromatic-warm, one achromatic, so a gray selection reads as *selected* on
top of any brown surface.

### Separate domains: UI binds to UI concepts, not colors

Syntax and UI are **separate color domains**. Syntax says *what a token
means*; UI says *what a chrome element is*. They draw from one xresources
palette, but a UI group binds to a **UI concept** (`ghost`, `list`, `panel`…),
never to a raw tone or a syntax group — the concept owns which tone it borrows.
So `ghost`, `recede`, and `Comment` all resolving to `bright_black` today is
*coincidence, not coupling*: three concepts that can diverge the moment one
needs to. This is what lets the UI and syntax palettes be tuned independently
(standalone / light / cterm variants). Deliberate crossover is allowed but
explicit — a picker rendering `@keyword` for a query match is opting in,
visibly. spf itself stays coupled to nothing but xresources; these concepts are
application-agnostic (see "Panels & controls").

### The axes

| Axis | What it encodes | How it's expressed | Primitive(s) |
| --- | --- | --- | --- |
| **Elevation** | content vs surface (depth) | two planes, not a ramp: content (`Normal`) and **one dark warm surface** for all chrome. Surfaces never stack, so depth is read from the **border**, not brightness. A float that can host content (`NormalFloat`) stays on the content plane | `Normal` · `chrome_*` · `list` (both = `surface`) · `border` |
| **Focus** | active vs inactive window | **foreground** strength only (one shared surface bg, so focus never collides with elevation) | `chrome_active` / `chrome_inactive` |
| **Emphasis** | current / selected item | neutral-**gray** background, ladder by contrast: selection → strong | `selection` · `cursor_block` (strong/inverted) |
| **State** | severity / change | borrowed wholesale from the diagnostic & diff role families — chrome invents no status color | `Diagnostic*` · `dark_*` |
| **Recede** | meta / structural furniture | one dim foreground (a named concept, not the raw tone) | `recede` |
| **Text** | label / ghost / accent | prominence of text on a control (see "Panels & controls") | `label` (surface fg) · `ghost` · state hues |

The atom is a `{fg, bg}` pair; the axes just say where each half comes from —
elevation supplies bg, focus modulates fg, emphasis overlays a gray bg, recede
sets a dim fg, state pulls a borrowed hue.

**Display vs interactive chrome.** A *surface* is display chrome — you read it,
so it wears the muted `chrome_fg`. An **input field** is interactive chrome —
you author text into it — so it's its own role (`textbox`): content-bright fg
(your query is content) on a dedicated field bg, lit a touch above the surface.
Neovim has no core input group, so the role is realized through plugin groups.

**Current line is its own concept.** `CursorLine`/`CursorColumn`/`ColorColumn`
use a *faint warm lift of Normal* (`current_line`), deliberately **not** the
gray emphasis family: it lives only in content and must stay easy on the eyes,
unlike a selection that may sit far from the Normal bg.

### Role → anchor

| Role | Key groups | Anchor |
| --- | --- | --- |
| Active chrome | `StatusLine`, `WinBar`, `TabLineSel`, `StatusLineTerm` | `chrome_active` |
| Inactive chrome | `StatusLineNC`, `WinBarNC`, `TabLine`, `TabLineFill` | `chrome_inactive` |
| List (menu) | `Pmenu` | `list` |
| Float container (content) | `NormalFloat`, `FloatTitle`/`FloatFooter` | `Normal` |
| Textbox / field (interactive) | `SnacksPickerInput`, `vim.ui.input` (plugin-wired) | `textbox` |
| Current line | `CursorLine`, `CursorColumn`, `ColorColumn` | `current_line` |
| Selection / current item | `Visual`, `PmenuSel`, `QuickFixLine`, `WildMenu` | `selection` |
| Cursor block | `Cursor` | `cursor_block` |
| Float border | `FloatBorder` | `border` |
| Recede (meta) | `LineNr`, `NonText`, `Folded`, `Conceal`, `WinSeparator`(→`Comment`), `ModeMsg`, `MoreMsg` | `recede` |
| Diff backgrounds | `DiffAdd`/`Change`/`Delete`/`Text` | `dark_{green,yellow,red,blue}` |
| Messages — error/warn | `ErrorMsg`, `WarningMsg` | `DiagnosticError`/`Warn` |
| Match | `MatchParen` | `white_on_bright_black_bold` |
| Directory | `Directory` | blue |

Open / deliberately-unsettled: **Search/IncSearch/CurSearch** (chromatic, WIP —
an emphasis-strong family whose colors aren't chosen yet) and **Spell**
(`SpellBad` plain underline vs the colored `SpellCap`/`Rare`/`Local` — pick one
treatment).

## Panels & controls — composite UI

Above the role layer sits a small vocabulary of **composite UI concepts** — the
shapes that recur in every framed interface. They are deliberately
*application-agnostic*: a panel is a panel whether it's xmobar, the tmux status
bar, dmenu, or a snacks float. spf is **one realization** (mapping each concept
to Neovim highlight groups); tmux / dmenu / xmobar realize the same concepts
from the same xresources tones. Four concepts — not a sprawling design system.

A **panel** is a framed container that hosts **controls**:

| Concept | What it is (any app) | Paint |
| --- | --- | --- |
| **panel** | a framed container / bar (xmobar, tmux bar, dmenu shell, float frame) — its frame band + title fg | `panel` (`surface_border` bg + content fg) |
| **textbox** | an editable text input (dmenu prompt, `vim.ui.input`, picker query) | `textbox` (content fg / field bg) |
| **list** | a selectable item list (dmenu items, completion menu, picker results) — normal items **+ a selected item** | `list` (normal) + `selection` (selected) |
| **view** | an embedded content buffer (picker preview, hover) | the content plane (`Normal`) |

Text *on* a panel/control has a **prominence** — three bands, and keeping it to
three is the discipline:

| Band | What it's for | Examples | Paint |
| --- | --- | --- | --- |
| **label** | the legible default text — what a thing *is* / what you typed | panel title, field label, the typed value, item names | the surface's own fg (no role) |
| **ghost** | de-emphasized secondary text | placeholder, the match **count**, a dimmed dir, descriptions, hints | `ghost` (dim; borrows `bright_black`) |
| **accent** | text that genuinely *stands out* | a matched substring, severity, an active flag | the **state** hues (not a neutral band) |

`label` adds no color (it's the surface fg); `ghost` is the one new neutral text
role; `accent` reuses the state/hue roles. "Stands out" is deliberately *not* a
neutral text level — that keeps the ladder from sprawling.

The picker is the first consumer and speaks the vocabulary directly: the snacks
float is a `panel` hosting a `textbox` (query), a `list` (results; selected item
via `selection`), and a `view` (preview). The wiring lives in the plugin layer
(`picker.lua`); spf core only defines the concept primitives, so the theme stays
coupled to nothing but xresources.

The same decomposition fits the rest: completion menu = panel + list (+ view for
docs), which-key = panel + list, hover = panel + view, `vim.ui.input` = panel +
textbox. Status bars (statusline, tmux, xmobar) are panels too, currently realized
through the `chrome_*` roles; reconciling those — and naming the xresources keys
by concept — is a later pass once the Neovim UI settles.

## Available (unused) colors

Palette colors with no syntax/group assignment today (audited across every
`groups/*.lua`). Two tiers: some already have a usable primitive in
`primitives.lua`; the rest exist only in `palette.lua` and need a primitive added
(e.g. `bright_yellow = { fg = colors.bright_yellow }`) before a group can link.

| Color | Hex | Hue | Primitive? | Bright sibling of… |
| --- | --- | --- | --- | --- |
| `bright_red` | `#dea1a1` | 0° | ✅ ready | red (errors) — reads error-adjacent |
| `bright_blue` | `#a2b8eb` | 222° | ✅ ready | blue (keywords) |
| `bright_magenta` | `#ddaff4` | 280° | ✅ ready | magenta (control flow) |
| `bright_yellow` | `#d2d6a9` | 65° | ➕ add prim | yellow (functions) / green (types) |
| `bright_orange` | `#e5bd99` | 28° | ➕ add prim | orange (strings) |
| `bright_rose` | `#f5b8ce` | 338° | ➕ add prim | rose (word operators) — very pale |

Caveat: each is the *lighter variant of a hue already carrying a role*, so
assigning one visually associates the new role with that family (e.g. `bright_blue`
reads as "a kind of keyword"). That can be a feature (type-adjacent `bright_green`
for namespaces) or a muddle — choose with the parent hue in mind. The only truly
*independent* hues were rose/bright_rose; rose is now spent on word operators.

## Constraints (learned)

- **Treesitter can't subdivide some captures.** Type *names* are all `@type` (no
  struct-vs-class distinction); symbolic operators are all `@operator` (no
  logical-vs-arithmetic). Splitting needs bespoke per-grammar queries — declined
  as fragile. Color what the grammar actually distinguishes.
- **LSP semantic tokens override treesitter** (priority 128 > 100). An
  `@lsp.type.*` override only diverges when it's non-empty *and* a different color
  than the matching capture; empty groups pass through to the treesitter highlight.
- **render-markdown custom checkboxes** match a `shortcut_link` `raw` (e.g. `[/]`),
  need nvim ≥ 0.10, and their `rendered` icons must be `\u{}` escapes (literal
  glyphs get mangled to spaces). The state→color map lives in `markdown.lua`;
  colors come from spf's `Diagnostic*` groups.

---

## Decision history

Condensed record of each syntax and UI decision and its essential rationale, in
the order taken. Colors shown are the *final* state; superseded intermediates are
noted only where they explain the choice.

1. **`@keyword.operator` → `rose`** (word operators `and`/`or`/`not`/`in`/`is`).
   Identifier-shaped operators get their own hue so they read distinct from
   variables; symbolic `@operator` stays neutral white. (Tried magenta first; it
   overloaded magenta, so recolored to rose.)
2. **Declaration & modifier keywords → blue.** `StorageClass`, `Structure`,
   `@keyword.type`, `@keyword.modifier` → `Keyword`. The keyword (`struct`/`class`/
   `static`) is blue; the type *name* stays green. Struct-vs-class name tinting
   isn't possible (all type names are `@type`).
3. **Identifier family → `Identifier`.** `@property`, `@variable.member`,
   `@variable` → `Identifier` (white). Restores nvim's `@property` default, unifies
   the family, keeps green for types only.
4. **`Typedef` → green.** A typedef is a type. Freed `rose` (→ word operators).
5. **`Todo` → `DiagnosticHint` (magenta).** Comment-attention mirrors diagnostic
   severity (nvim already links `@comment.error/warning/note` →
   `Diagnostic{Error,Warn,Info}`); `Todo` has no severity, so it takes the leftover
   Hint. `@comment.*` left `{}` to inherit.
6. **Flow control → magenta; `import` → PreProc.** `@keyword.return`,
   `@keyword.exception`, legacy `Exception` (was red) → `Statement`.
   `@keyword.import` → `PreProc` (deliberate blue). All control-flow captures
   (incl. `conditional`/`repeat`) link to `Statement` — one source of truth for
   control-flow color.
7. **LSP / TS consistency.** `@lsp.type.property` → `{}` (was green) so TS/JS fields
   match treesitter `Identifier`. `@module` → `bright_green` (deliberate
   type-adjacent namespace color; propagates to `@lsp.type.namespace`). Rule: an
   `@lsp.type.*` override only diverges when non-empty *and* a different color than
   its capture.
8. **`@variable.parameter` → italic.** Mirrors `@lsp.type.parameter`; params read
   distinct from locals in every buffer.
9. **Builtins follow their category.** `*.builtin` anchored to the parent role
   (`@type.builtin → Type`, `@function.builtin → Function`, …), overriding nvim's
   `Special`/gold default — restores "type names are green" etc. and re-tightens
   gold to genuinely-special syntax. Also `@function.method.call → yellow_italic`
   (calls-are-italic reaches method calls).
10. **`@constructor` → `Type` (green).** A constructor name is a type reference;
    one color across declaration, annotation, and construction. Plain, not italic
    — it covers definitions too (not call-specific).
11. **Checkboxes (native) → diagnostic status.** `@markup.list.checked →
    DiagnosticOk` (green), `@markup.list.unchecked → DiagnosticHint` (magenta) —
    fixes the old unchecked-as-error red.
12. **Extended checkbox states → diagnostic status (render-markdown).** Each custom
    state maps to a `Diagnostic*` group (mapping in `markdown.lua`, colors from
    spf): `[/]`→Info, `[>]`→Warn, `[!]`→Error, `[?]`→Hint (same "open" family as
    to-do), `[-]`→Comment + `DiagnosticDeprecated` strikethrough.
13. **Messages follow diagnostics.** `ErrorMsg → DiagnosticError`,
    `WarningMsg → DiagnosticWarn` (were raw `red`/`yellow`). Same hue today, but
    the error/warn *role* now has a single home across the diagnostic and
    message layers — recoloring "error" is one edit. Same cross-layer rule as
    the syntax side.
14. **UI recast as orthogonal axes** (supersedes the first-pass "accent ramp"
    write-up). Chrome is no longer an ordinal `primary`/`secondary`/`tertiary`
    triple — that naming hid three *different* operations (the old tertiary was
    literally `invert(primary)`). Replaced with the axes in the "UI / chrome"
    section: **elevation** (warm-brown bg ramp `e0`→`e1`→`e2`), **focus**
    (active/inactive as fg strength on one shared surface), **emphasis** (gray
    bg for selection/current), **state** (borrowed from diagnostics/diff), and
    **recede** (one dim fg). Primitives renamed accordingly: `chrome_active`/
    `chrome_inactive`, `overlay`, `selection`, `current_line`, `cursor_block`.
    Colors kept near the old chrome; only `surface_overlay` (`#473b34`) is new.
15. **Focus is foreground, not background.** Active vs inactive window chrome now
    share one raised surface (`surface_raised`) and differ only by fg strength
    (`chrome_fg` vs dim `bright_black`). Fixes the old inversion where the inactive
    statusline was the *brighter* one, and frees the bg ramp to mean depth alone.
16. **Only menus reach the overlay surface; float containers stay content.**
    `Pmenu` → `overlay` (`e2`) — a menu never holds content, so the lift is
    safe. But `NormalFloat` stays `Normal`: Neovim funnels *content* floats
    (picker previews, terminals, lazygit) through the same group, and those must
    read as a buffer. A float is a container, not inherently chrome; the border
    delineates it. (First pass put `NormalFloat` on `overlay` and tinted every
    picker preview — snacks routes all picker windows back through
    `NormalFloat`.)
17. **Current line is its own concept.** `CursorLine`/`CursorColumn`/`ColorColumn`
    → `current_line`, a faint warm lift of `Normal` — deliberately *not* the gray
    emphasis family. It lives only in content and must stay easy on the eyes, where
    a selection may sit far from the Normal bg. Selection/current-item unified on
    `selection` (`Visual`, `PmenuSel`, `QuickFixLine`, `WildMenu`).
18. **Folds recede.** `Folded` → `bright_black` (was the active-chrome accent).
    A fold is collapsed *content*, not window furniture, so it dims rather than
    wearing a surface.
19. **Message leaks closed.** `ModeMsg`/`MoreMsg`/`Conceal` → `bright_black`,
    `Question` → `white` (were `{}`, inheriting Neovim's off-palette green/cyan/
    gray). `{}` is only safe when spf owns the fallback chain; these orphan UI
    groups didn't, so they leaked. Search/Spell left deliberately unsettled.
20. **Elevation ramp collapsed to one dark surface.** The `e0/e1/e2` brightness
    ramp is gone: chrome and overlays share one dark warm `surface` (`#221c19`,
    back near the original — easy on the eyes), and **depth is read from the
    `border`, not brightness**. Rationale: spf's surfaces never stack (a float
    sits over a buffer, not over the statusline), so ascending rungs bought
    nothing. Side effects fixed: the selected-item gray was *darker* than the old
    bright overlay (muddy) — lifted to `#3a3a3a` and now clearly above the dark
    surface; `FloatBorder` moved off the harsh `bright_black` (40% L) to a quiet
    warm `surface_border` (`#473b34`). Picker frame/preview separation now leans
    on the border, matching how the snacks frame opts into `overlay`.
    - **Open reconsideration (TBD — gradient):** collapsing the ramp removed the
      *gradient concept* entirely, but the lualine statusline is a real case
      where a graded A/B/C bar is legitimately useful and now reads flat. This
      reopens #20's premise — "surfaces never stack" holds for floats, yet a
      *bar* can want graded segments within one surface. Undecided whether to
      (a) treat lualine as a one-off plugin-layer gradient, or (b) promote
      "gradient" to a first-class, bounded UI concept (other UI may want it too).
      Noted, not decided — the earlier "restore the gradient" call is withdrawn
      back to open.
21. **Input is its own role, not a surface.** An editable field (picker query,
    `vim.ui.input`) is *interactive* chrome, distinct from *display* surfaces:
    `input` = content-bright fg (`white`) on its own field bg (`input_bg`
    `#382e29`, clearly lifted above surface so the lit field reads as the focus).
    No core nvim group exists for it, so the role is defined in spf and wired at
    the plugin layer (`SnacksPickerInput → input`). The snacks picker also uses
    solid (filled) borders: the input+list box and the preview get warm
    `surface_border` frames so each block is delineated from the dark backdrop,
    while inside, the input field (`input`) and list surface (`overlay`) separate
    by their own backgrounds — purely plugin-layer presentation reusing spf roles.
22. **Composite vocabulary: `panel` hosts `textbox`/`list`/`view`** (see
    "Panels & controls"). The picker surfaced recurring *shapes*, not new
    colors, so they're named as application-agnostic concepts (a tmux bar /
    xmobar / dmenu are panels too) — spf is one realization, others map the same
    concepts from xresources. Primitives renamed to the concept names:
    `input → textbox`, `overlay → list`, plus a new `panel` (`surface_border`
    band + content fg). `view` has no primitive — it's the content plane
    (`Normal`). The picker now links its windows straight to the vocabulary
    (`SnacksPicker → list`, `Input → textbox`, `Preview → Normal`, frame/titles
    → `panel`, selected item → `selection`), replacing the inline band
    computation. Kept to four concepts on purpose; `label` reserved. Status bars
    stay on `chrome_*` for now — a later reconcile.
23. **Syntax/UI are separate color domains; UI binds to UI concepts.** A UI group
    links to a UI concept, never a raw tone or a syntax group — the concept owns
    its tone, so domains can be tuned independently (standalone / light / cterm).
    Added the text-prominence bands: `label` (surface fg, no color), `ghost` (new
    dim text role), `accent` (state hues). Named two dim *concepts* that both
    borrow `bright_black` today but decouple it: `recede` (editor furniture —
    `LineNr`/`Folded`/`NonText`/`Conceal`/`ModeMsg`/`MoreMsg` retargeted off the
    raw tone) and `ghost` (control secondary text). Wired the picker's ghost text
    (`SnacksPickerTotals`/`Dir`/`PathHidden`/`Comment`/`Desc`) to `ghost`,
    decoupling it from `NonText` *and* the syntax `Comment` group it had
    borrowed. All visual no-ops today (everything resolves to `bright_black`) —
    the change is the binding, not the pixels.
24. **UI recast as a surfaces × roles grid** *(designed — not yet coded;
    supersedes how #17/#22 structure `selection`/`current_line`)*. The unit of
    the UI system becomes a **surface** = `{ bg, label, ghost, accent }` — a
    background plus the foregrounds guaranteed legible on it. `label` = primary
    text (a surface's own fg; titles = label **+ bold**, an orthogonal
    attribute, not a grid cell), `ghost` = muted secondary text, `accent` =
    stands-out-via-**hue** (matched substring, severity, active flag — the
    sanctioned *explicit* crossover where UI borrows syntax-palette hues). Only
    `bg + label + ghost` are contrast-sensitive; `ghost` is the fragile
    per-surface worker, `label`/`accent` are robust.
    - **States are surfaces** (the anti-sprawl move): a state that swaps the bg
      *is* a surface, and the text roles re-resolve against the new bg — so we
      never invent `selected-fg` / `matched-on-selected` cells. Rename
      `selection` → **`selected`** (name pending — see below): a *shared state*
      any selectable surface enters (a list's current row, a completion row, a
      buffer's `Visual` range all resolve onto it), modeled as **component +
      state**, not as a peer of `list`. `content` carries *two* states because
      there cursor ≠ selection: `current-line` (subtle warm) and `selected`
      (gray), which can stack; a `list` collapses both into just `selected`
      (cursor = selection — which is exactly why snacks maps a list's
      `CursorLine → Visual`).
    - **Inheritance, not bespoke sets:** role defaults + per-surface override
      through xresources fallback chains (`load("list.ghost") or
      load("text.ghost") or <default>`), never one hardcoded global (that would
      bake a "surfaces stay close in lightness" assumption into the schema — the
      coupling we're avoiding). The palette's existing `load(key) or fallback`
      already *is* this mechanism; the common case is one default everywhere, and
      a diverging surface overrides a single slot, reactively, the day its bg
      moves out of contrast range.
    - **Ghost contrast bug, fixed as part of this:** `ghost` (`#756157`) fails
      WCAG on most surfaces — measured 3.08 / 2.89 / 2.27 / 1.85 : 1 on content
      / list / textbox / panel band (floor ≈ 3:1). Default `#9a8578` clears 3:1
      everywhere (5.1 / 4.8 / 3.8 / 3.1) while staying ~40% of label contrast
      (clearly secondary); apply via the default+override shape above, not as a
      global.
    - **Open (confirm with user before coding):** the state name — `selected`
      (recommended) vs `current`; avoid `active` (collides with focus) — and the
      exact default `ghost` tone (`#9a8578` proposed; `#a8948a` brighter,
      `#8a7468` dips below the floor).
