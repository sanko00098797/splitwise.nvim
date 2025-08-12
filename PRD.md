# Splitwise PRD

This is a Neovim plugin written in Lua that facilitates easy creation, resizing and navigation among vertical
and horizontal window splits.

## Default keys

`<C-l>` for "right" movements
`<C-k>` for "up" movements
`<C-h>` for "left" movements
`<C-j>` for "down" movements

## Options

max_vertical_splits (default value of 1)
max_horizontal_splits (default value of 1)

## Scenarios

1. When "moving" to the right:
    - If the user is on the rightmost window and the `max_vertical_splits` option is greater than the
      current number of vertical splits, create a vertical split and move the cursor into the new window.
    - If the user is not on the rightmost window, move to the window immediately to the right.
    - If the user is on the rightmost window and the `max_vertical_splits` option is equal to the
      current number of vertical splits, slightly increase the size of the current window so it becomes wider.
      If the `max_vertical_splits` option is zero, do nothing.

1. When "moving" to the left:
    - If the user is on the leftmost window and the `max_vertical_splits` option is greater than the
      current number of vertical splits, create a vertical split and move the cursor into the new window.
    - If the user is not on the leftmost window, move to the window immediately to the left.
    - If the user is on the leftmost window and the `max_vertical_splits` option is equal to the
      current number of vertical splits, slightly increase the size of the current window so it becomes wider.
      If the `max_vertical_splits` option is zero, do nothing.

1. When "moving" up:
    - If the user is on the uppermost window and the `max_horizontal_splits` option is greater than the
      current number of horizontal splits, create a horizontal split and move the cursor into the new window.
    - If the user is not on the uppermost window, move to the window immediately above the current window.
    - If the user is on the uppermost window and the `max_horizontal_splits` option is equal to the
      current number of horizontal splits, slightly increase the size of the current window so it becomes taller.
      If the `max_horizontal_splits` option is zero, do nothing.

1. When "moving" down:
    - If the user is on the bottommost window and the `max_horizontal_splits` option is greater than the
      current number of horizontal splits, create a horizontal split and move the cursor into the new window.
    - If the user is not on the bottommost window, move to the window immediately below the current window.
    - If the user is on the bottommost window and the `max_horizontal_splits` option is equal to the
      current number of horizontal splits, slightly increase the size of the current window so it becomes taller.
      If the `max_horizontal_splits` option is zero, do nothing.
