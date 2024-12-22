{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "yref-boop";
  home.homeDirectory = "/home/yref-boop";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/yref-boop/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.kitty = {
    enable = true;
    settings = {
      background_opacity = "0.8";
      font_family = "Maple Mono";
      font_size = "12.5";
      disable_ligatures = "never";
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {

      exec-once = "swww init && swww img ~/mídia/fundo.png";

      general = {
        gaps_in = "13";
        gaps_out = "26";
        border_size= "0";
      };

      misc = {
        force_default_wallpaper = "0";
        disable_hyprland_logo = "true";
      };

      decoration = {
        rounding = "20";
        blur = {
          enabled = "true";
          size = "3";
          passes = "1";
        };
        shadow = {
          enabled = "true";
          range = "7";
        };
      };

      animations = {
        enabled = "true";
      };

      input = {
        kb_layout = "us, pt";
        kb_options = "grp:win_space_toggle";
        follow_mouse = "1";
        touchpad.natural_scroll = "false";
      };

      # bindings
      "$mod" = "SUPER";

      bind = [
        "$mod, Q, exec,kitty"
        "$mod, C, killactive"
        "$mod, M, exit"
        "$mod, V, togglefloating"
        "$mod, R, exec, wofi --show drun"
        "$mod, P, pseudo"
        "$mod, T, togglesplit"

        "$mod, H, movefocus, l"
        "$mod, J, movefocus, d"
        "$mod, K, movefocus, u"
        "$mod, L, movefocus, r"
      ]
      ++ (
        # workspaces
        # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
        builtins.concatLists (builtins.genList (i:
            let ws = i + 1;
            in [
              "$mod, code:1${toString i}, workspace, ${toString ws}"
              "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
            ]
        )9)
      );
    };
  };


  programs.neovim = {
    enable = true;
    defaultEditor = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraLuaConfig = ''
      local opt = vim.opt

      -- controls
      vim.g.mapleader = " "
      opt.mouse = ""

      -- tabs & indent
      opt.tabstop = 2
      opt.shiftwidth = 2
      opt.softtabstop = 2
      opt.smartindent = true
      opt.breakindent = true
      opt.expandtab = true
      opt.autoindent = true

      -- search & clip
      opt.incsearch = false
      opt.smartcase = true
      opt.iskeyword:append("-")
      opt.clipboard:append("unnamedplus")

      -- appearance
      opt.number = true
      opt.showmode = true
      opt.relativenumber = true
      opt.termguicolors  = true
      opt.cmdheight = 1
      opt.completeopt = "menuone,noinsert,noselect"
      opt.list = true
      vim.cmd('hi Normal guibg=#00000000')
      opt.laststatus = 0

      -- blank indicators
      opt.listchars:append "space:⋅"
      vim.wo.fillchars ='eob: '
      opt.guicursor = ""

      -- behaviour
      opt.scrolloff = 10
      opt.hidden = true
      opt.errorbells = false
      opt.swapfile = false
      opt.backup = false
      opt.undofile = true
      opt.undodir = vim.fn.expand("~/.nvim/undodir")
      opt.backspace = "indent,eol,start"
    '';

    plugins = let
      nvim-treesitter-with-plugins = pkgs.vimPlugins.nvim-treesitter.withPlugins (treesitter-plugins: with treesitter-plugins; [
        c
        nix
        python
        latex
      ]);
    in
      with pkgs.vimPlugins; [
        {
          plugin = lualine-nvim;
          type = "lua";
          config = ''require('lualine').setup()'';
        }
        {
          plugin = gitsigns-nvim;
          type = "lua";
          config = ''require('gitsigns').setup()'';
        }
        {
          plugin = nvim-lspconfig;
          type = "lua";
          config = ''
            require'lspconfig'.pyright.setup{}
            require'lspconfig'.clangd.setup{}
            require'lspconfig'.texlab.setup{}
            require'lspconfig'.nil_ls.setup{}
          '';
        }
        {
          plugin = nvim-treesitter-with-plugins;
          type = "lua";
          config = ''require('nvim-treesitter').setup()'';
        }
        {
          plugin = telescope-nvim;
          type = "lua";
          config = ''require('telescope').setup()'';
        }
      ];

  };

}
