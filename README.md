# README

Adjust your Neovim colorscheme saturation and lightness on the fly.

# Features

- Dynamically modify colorscheme saturation
- Adjust lightness based on color value
- Step-based incremental adjustments

# Installation

Using [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
  "BartSte/nvim-saturate",
  config = function()
    require("saturate").setup({
      -- Your configuration here
    })
  end
}
```

# Configuration

The plugin provides the following defaults:

```lua
require("saturate").setup({
  after = function(palette) end,
  palette = {},
  saturation = 1.0,
  light_delta = 0.0,
  saturation_step = 0.2,
  light_delta_step = 0.02,
  log_level = vim.log.levels.INFO,
})
```

The available configuration options are explained in the table below:

| Option             | Default    | Description                                                             |
| ------------------ | ---------- | ----------------------------------------------------------------------- |
| `after`            | `function` | Callback that is called after the palette has been modified             |
| `palette`          | `{}`       | The palette to modify. Its modified version is passed to `after`.       |
| `saturation`       | `1.0`      | Initial saturation multiplier                                           |
| `light_delta`      | `0.0`      | Initial lightness adjustment (value added or subtracted from lightness) |
| `saturation_step`  | `0.2`      | Default step size for saturation commands                               |
| `light_delta_step` | `0.02`     | Default step size for lightness commands                                |
| `log_level`        | INFO       | Increase the level to get rid of saturation notifications               |

In practice, you will need to configure the `after` and the `palette` as a minimum. Here, the `palette` is provided by your specific colorscheme, and the `after` function is where apply the colorscheme, which is different for each colorscheme plugin. The example below is a configuration for the [kanagawa](https://github.com/rebelot/kanagawa.nvim) colorscheme. I like this scheme, but the colors are to dim for me, so I make the colors more vivid as follows:

```lua
require("saturate").setup({
    saturation = 3,
    light_delta = 0.08,
    palette = require("kanagawa.colors").setup({ theme = "dragon" }).palette,
    after = function(palette)
        require("kanagawa").setup({ colors = { palette = palette } })
        require("kanagawa").load()
    end
})
```

# Commands

For all commands below, the arguments are optional. If not provided, the values from the config are used.

| Command               | Arguments         | Description                                   |
| --------------------- | ----------------- | --------------------------------------------- |
| `Saturate`            | `[sat?] [light?]` | Set saturation/lightness values.              |
| `IncrementSaturation` | `[step?]`         | Increase saturation by step (default: 0.2)    |
| `DecrementSaturation` | `[step?]`         | Decrease saturation by step                   |
| `IncrementLightDelta` | `[step?]`         | Increase lightness adjustment (default: 0.02) |
| `DecrementLightDelta` | `[step?]`         | Decrease lightness adjustment                 |

Set saturation to 1.5x and lightness adjustment to 0.1:

```vim
:Saturate 1.5 0.1
```

Increase saturation by 0.3:

```vim
:IncrementSaturation 0.3
```

Decrease lightness adjustment using default step:

```vim
:DecrementLightDelta
```

# How It Works

The plugin:

1. Converts hex colors → RGB → HSL
2. Adjusts saturation by multiplication
3. Adjusts lightness conditionally:
   - Light colors (<0.5 lightness): subtract delta
   - Dark colors (≥0.5 lightness): add delta
4. Converts back: HSL → RGB → hex
5. Applies modified palette via your `after` callback

# Contributing

Your contributions are welcome. Read the [Contributing Guidelines](./CONTRIBUTING.md).

# License

[MIT License](./LICENCE)
