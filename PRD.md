# Splitwise PRD

This Neovim plugin (Lua) provides smart navigation among window splits, with optional auto-creation of new splits at edges and edge-resizing when new splits are not allowed.

## Terminology and scope

- **Window**: A regular, non-floating Neovim window. Floating windows are ignored.
- **Column (vertical split count)**: The number of side-by-side vertical columns in the current tabpage. Example: performing one `:vsplit` yields 2 columns. Nested splits inside a single column (e.g., horizontal splits within that column) do not increase the overall column count.
- **Row (horizontal split count)**: The number of stacked horizontal rows in the current tabpage. Nested splits inside a row (e.g., vertical splits within that row) do not increase the overall row count.
- **Edge window**: The window in the active tabpage that is at the extreme left/right/top/bottom among regular windows.
- All behavior is scoped to the current tabpage only. The plugin never creates or closes tabpages.

Examples to clarify nested layouts:
- If you have 1 window and run `:vsplit`, you now have 2 columns. Running `:split` inside the left column creates two windows stacked within that left column, but the overall column count remains 2.
- If your top-level layout is a horizontal split (two rows), and inside the top row you `:vsplit`, that adds columns within the top row only. The overall column count for the tabpage remains determined by the top-level side-by-side arrangement, not by nested splits inside a row or column.

## Default keymaps

- `<C-l>`: move right
- `<C-k>`: move up
- `<C-h>`: move left
- `<C-j>`: move down

Notes:
- These default mappings apply only in normal mode, use `noremap` and `silent`, and override any existing mappings for these combinations.
- `<C-l>` normally redraws the screen in Vim/Neovim. Remapping it will shadow that default. Users who need redraw can disable default keymaps (see options) or bind redraw elsewhere.

## Configuration options

- **max_columns** (number, default: `2`): Maximum number of columns allowed to be auto-created on the current tabpage. Set to `1` to disable auto-creating columns. Resizing at edges remains enabled.
- **max_rows** (number, default: `2`): Maximum number of rows allowed to be auto-created on the current tabpage. Set to `1` to disable auto-creating rows. Resizing at edges remains enabled.
- **resize_step_cols** (number, default: `5`): Columns to widen when resizing at the left/right edge.
- **resize_step_rows** (number, default: `3`): Rows to heighten when resizing at the top/bottom edge.
- **create_default_keymaps** (boolean, default: `true`): Whether to register the default `<C-h/j/k/l>` mappings.
- **wrap_navigation** (boolean, default: `false`): If `true`, when at an edge and creation/resizing are not performed, focus wraps to the opposite edge.
- **ignore_filetypes** (string[]; default: `["help", "qf"]`): Windows showing these filetypes are skipped when determining edges and are not targeted for auto-creation.
- **ignore_buftypes** (string[]; default: `["nofile", "terminal", "prompt"]`): Same as above but for buffer types.
- **new_split_opens_blank_buffer** (boolean, default: `false`): If `true`, new splits open an empty buffer instead of duplicating the current buffer.

## Behavior

When a directional key is pressed, behavior is:

1) If there is a neighbor window in that direction, move focus to it (standard directional navigation).

2) If there is no neighbor (you are at that edge):
   - If the current number of columns/rows is less than the corresponding `max_columns`/`max_rows`, auto-create a split on that edge and move into it (contents duplicate the current buffer unless `new_split_opens_blank_buffer` is `true`):
     - Right edge: create a vertical split to the right (default `vsplit`).
     - Left edge: create a vertical split to the left (`leftabove vsplit`).
     - Top edge: create a horizontal split above (`aboveleft split`).
     - Bottom edge: create a horizontal split below (default `split`).
   - Else (at edge and at/over the max), attempt to resize the current window to favor that direction (resizing remains enabled even if auto-creation is disabled by `max_columns`/`max_rows`):
     - Right or left edge: widen the current window by `resize_step_cols` columns (equivalent to `:vertical resize +{N}`), subject to `winminwidth` constraints.
     - Top or bottom edge: increase the height of the current window by `resize_step_rows` rows (equivalent to `:resize +{N}`), subject to `winminheight` constraints.
     - If resizing is not possible due to constraints (including `winfixwidth`/`winfixheight`), do nothing unless `wrap_navigation` is `true`, in which case focus wraps to the opposite edge window.

### Direction-specific notes

- The placement of newly created splits is intentional so that the new window appears in the direction of travel.
- Resizing uses Neovim's native resize behavior; adjacent windows are reduced as Neovim determines. No equalize step is performed automatically.

## Edge cases and exclusions

- Floating windows are ignored when determining edges and are never targets for creation/movement.
- Windows matching `ignore_filetypes`/`ignore_buftypes` are skipped when determining neighbors/edges.
- If a tabpage layout mixes rows and columns (nested splits), column/row counts use only the top-level layout, not nested groups.
 - Windows with `winfixwidth`/`winfixheight` will not be resized; the action becomes a no-op (unless `wrap_navigation` is `true`).

## Defaults

- `max_columns=2`, `max_rows=2`
- `resize_step_cols=5`, `resize_step_rows=3`
- `create_default_keymaps=true` (normal mode only)
- `wrap_navigation=false`
- `new_split_opens_blank_buffer=false` (duplicates current buffer by default)
