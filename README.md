# Neovim

My Neovim configuration, packaged as a Nix flake. Nix supplies Neovim,
plugins, command-line tools, Lua dependencies, and the generated startup
wrapper; the editor configuration itself remains ordinary Lua under `nvim/`.

## Highlights

- Native Neovim LSP configuration, using `nvim-lspconfig` for server
  definitions and Blink for completion.
- Treesitter highlighting and text objects.
- Telescope search with persistent history, plus Yazi file navigation.
- Lualine, Gitsigns, Which Key, nvim-surround, LuaSnip, Conform, and
  mini.indentscope.
- Lazy loading through `lze` while Nix remains responsible for installing
  plugins.
- A Base16 theme loaded from `~/.config/theme.yaml`, with
  `base16-rose-pine` as the fallback.
- A packaged SQLite library path that works on Linux and macOS.

## Run or install

[Nix](https://nixos.org/) with flakes enabled is required. A Nerd Font is
recommended for the icons used by the configuration.

Run the checked-out configuration without installing it:

```console
nix run .#nvim
```

Run it directly from GitHub:

```console
nix run github:dan-kc/neovim#nvim
```

Install it into your Nix profile:

```console
nix profile install github:dan-kc/neovim#nvim
```

The flake exposes both `packages.<system>.default` and
`packages.<system>.nvim`. It also exposes an overlay whose package is named
`nvim-pkg`. Add the repository as a flake input:

```nix
{
  inputs.neovim.url = "github:dan-kc/neovim";
}
```

Then use the overlay in a NixOS module where `inputs` is available:

```nix
{ inputs, pkgs, ... }:
{
  nixpkgs.overlays = [ inputs.neovim.overlays.default ];
  environment.systemPackages = [ pkgs.nvim-pkg ];
}
```

With Home Manager, the package output can be consumed directly:

```nix
home.packages = [ inputs.neovim.packages.${pkgs.system}.default ];
```

Language servers that are not bundled by the flake should be supplied by the
project environment in which Neovim runs.

## Theme

If `~/.config/theme.yaml` exists, it must contain all sixteen Base16 values,
named `base00` through `base0F`. Values may be written with or without a
leading `#`. An incomplete or unreadable palette falls back to
`base16-rose-pine`.

```yaml
base00: "191724"
base01: "1f1d2e"
# ...
base0E: "c4a7e7"
base0F: "524f67"
```

## Repository layout

```text
.
├── flake.nix                  # Packages, overlay, and development shell
├── nix/
│   ├── mkNeovim.nix          # Builds and wraps Neovim
│   └── neovim-overlay.nix    # Plugins and runtime dependencies
└── nvim/
    ├── init.lua              # Core options and lazy-loading entry point
    ├── after/ftplugin/       # Filetype-local settings
    ├── lua/configs/          # lze plugin specifications
    ├── lua/user/             # Shared configuration modules
    └── plugin/               # Startup-time plugin and LSP configuration
```

Plugins and external tools are declared in `nix/neovim-overlay.nix`. Core
editor options live in `nvim/init.lua`; lazy-loaded plugin configuration lives
under `nvim/lua/configs/`.

## Development

Enter the development shell to get Lua and Nix tooling and generate
`.luarc.json` for lua-language-server:

```console
nix develop
```

Useful checks are:

```console
stylua --check nvim
luacheck --globals vim -- nvim
nixfmt --check flake.nix nix/*.nix
nix flake check --no-build
```

Test the wrapped configuration after making changes:

```console
nix run .#nvim
```

Nix flakes only include Git-tracked files. Stage newly created configuration
files before testing them through `nix run` or `nix flake check`.

Update pinned inputs with `nix flake update`, then review and commit the
resulting `flake.lock` changes.

## License

[GPL-2.0](./LICENSE)
