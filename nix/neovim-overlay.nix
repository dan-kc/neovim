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
    nvim-treesitter.withAllGrammars
    luasnip
    nvim-cmp
    cmp_luasnip
    lspkind-nvim
    cmp-nvim-lsp
    cmp-nvim-lsp-signature-help
    cmp-buffer
    cmp-path
    cmp-nvim-lua
    cmp-cmdline
    cmp-cmdline-history

    gitsigns-nvim
    lualine-nvim
    nvim-navic
    nvim-treesitter-textobjects
    nvim-ts-context-commentstring

    vim-unimpaired
    nvim-surround
    nvim-unception

    # Packages that are needed for other plugins
    statuscol-nvim
    sqlite-lua
    plenary-nvim
    nvim-web-devicons
    vim-repeat
    which-key-nvim

    # Stuff I added
    conform-nvim
    flash-nvim
    nvim-lspconfig
    treesj
    mini-base16
    base16-nvim
    transparent-nvim
    indent-blankline-nvim
    mini-indentscope
    dressing-nvim
    yazi-nvim
    resession-nvim
    grug-far-nvim
    fzf-lua
    stay-centered-nvim
  ];

  extraLuaPackages = p: [
    p.lyaml
  ];

  extraPackages = with pkgs; [
    # lua-language-server
    # stylua

    # nil
    # nixfmt-rfc-style

    # rust-analyzer
    # rustfmt

    # typescript-language-server
    # nodePackages.prettier

    # gopls
    # gofumpt

    # taplo # TOML LSP and formatter

    # pyright
    # black

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
