{ inputs }:
final: prev:
with final.pkgs.lib;
let
  pkgs = final;

  # Make sure we use the pinned nixpkgs instance for wrapNeovimUnstable,
  # otherwise it could have an incompatible signature when applying this overlay.
  pkgs-locked = inputs.nixpkgs.legacyPackages.${pkgs.system};

  # This is the helper function that builds the Neovim derivation.
  mkNeovim = pkgs.callPackage ./mkNeovim.nix {
    inherit (pkgs-locked) wrapNeovimUnstable neovimUtils;
  };

  # A plugin can either be a package or an attrset, such as
  # { plugin = <plugin>; # the package, e.g. pkgs.vimPlugins.nvim-cmp
  #   config = <config>; # String; a config that will be loaded with the plugin
  #   # Boolean; Whether to automatically load the plugin as a 'start' plugin,
  #   # or as an 'opt' plugin, that can be loaded with `:packadd!`
  #   optional = <true|false>; # Default: false
  #   ...
  # }
  all-plugins = with pkgs.vimPlugins; [
    # Important
    lze
    nvim-lspconfig
    base16-nvim

    nvim-treesitter.withAllGrammars
    nvim-treesitter-textobjects
    nvim-ts-context-commentstring

    # TODO: Replace with Blink
    luasnip
    nvim-cmp
    lspkind-nvim
    cmp_luasnip
    cmp-nvim-lsp
    cmp-nvim-lsp-signature-help
    cmp-buffer
    cmp-path
    cmp-nvim-lua
    cmp-cmdline
    cmp-cmdline-history

    # Needed for telescope
    nvim-web-devicons
    plenary-nvim
    sqlite-lua
    telescope-fzy-native-nvim # TODO: Find a way to lazy load this?

    lualine-nvim
    {
      plugin = gitsigns-nvim;
      optional = true;
    }
    {
      plugin = nvim-unception;
      optional = true;
    }
    {
      plugin = vim-repeat;
      optional = true;
    }
    {
      plugin = mini-pairs;
      optional = true;
    }
    {
      plugin = nvim-surround;
      optional = true;
    }
    {
      plugin = which-key-nvim;
      optional = true;
    }
    {
      plugin = telescope-nvim;
      optional = true;
    }
    {
      plugin = yazi-nvim;
      optional = true;
    }
    {
      plugin = stay-centered-nvim;
      optional = true;
    }
    {
      plugin = conform-nvim;
      optional = true;
    }
    {
      plugin = flash-nvim;
      optional = true;
    }
    {
      plugin = treesj;
      optional = true;
    }
    {
      plugin = mini-indentscope;
      optional = true;
    }
  ];

  extraLuaPackages = p: [
    p.lyaml
  ];

  extraPackages = with pkgs; [
    # lua-language-server
    stylua

    # nil
    # nixfmt-rfc-style

    # rust-analyzer
    # rustfmt

    # typescript-language-server
    nodePackages.prettier

    # gopls
    gofumpt

    # taplo # TOML LSP and formatter

    # pyright
    black

    # clang-tools
  ];
in
{
  nvim-pkg = mkNeovim {
    plugins = all-plugins;
    inherit extraPackages;
    inherit extraLuaPackages;
  };

  # This can be symlinked in the devShell's shellHook
  nvim-luarc-json = final.mk-luarc-json {
    plugins = all-plugins;
  };

  # You can add as many derivations as you like.
  # Use `ignoreConfigRegexes` to filter out config
  # files you would not like to include.
  #
  # For example:
  #
  # nvim-pkg-no-telescope = mkNeovim {
  #   plugins = [];
  #   ignoreConfigRegexes = [
  #     "^plugin/telescope.lua"
  #     "^ftplugin/.*.lua"
  #   ];
  #   inherit extraPackages;
  # };
}
