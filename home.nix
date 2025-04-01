{ pkgs, ... }:

{
  # necessary info
  home.username = "yref-boop";
  home.homeDirectory = "/home/yref-boop";

  # first verison of NixOs installed, (!!) not to be changed (!!)
  home.stateVersion = "24.11";

  # package management
  home.packages = [ ];

  # plain file management
  home.file = { };

  # environment variables
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # home-manager auto-management
  programs.home-manager.enable = true;

  #
  # window manager
  #

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {

      exec-once = "swww init && swww img ~/mídia/fundo.png && hyprshade on mono";

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
        rounding = "25";
        blur = {
          enabled = "true";
          size = "15";
          passes = "2";
        };
        shadow = {
          enabled = "true";
          range = "10";
          ignore_window = "false";
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

      # standalone
      # input-field = {
      #   monitor=",1920x1080,auto,1,bitdepth,8";
      # };

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

        "$mod SHIFT, right, resizeactive, 20 0"
        "$mod SHIFT, left, resizeactive, -20 0"
        "$mod SHIFT, up, resizeactive, 0 -20"
        "$mod SHIFT, down, resizeactive, 0 20"

        "$mod SHIFT, mouse:272, movewindow"
        "$mod SHIFT, mouse:273, resizeactive"
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

  #
  # PROGRAMS
  #

  programs = {

    bash = {
      enable = true;
      initExtra = ''
        function y() {
          local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
          yazi "$@" --cwd-file="$tmp"
          if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
            builtin cd -- "$cwd"
          fi
          rm -f -- "$tmp"
        }
      '';
    };

    kitty = {
      enable = true;
      settings = {
        background_opacity = "0.8";
        font_family = "Maple Mono";
        font_size = "12.5";
        disable_ligatures = "never";
        window_padding_width = "4";
      };
    };

    starship= {
      enable = true;
      enableBashIntegration = true;
      # special characters  
      # [](bg:#000000 fg:#000000)\\

      # color_white = '#ffffff'
      # color_black = '#000000'
      # color_yellow = '#F18A31'
      # color_orange = '#E45743'
      # color_salmon = '#D43382'
      # color_pink = '#B315CD'
      # color_purple = '#BB65F0'
      # color_indigo = '#AA85F1'
      # color_blue = '#4166ED'

      settings = {
        add_newline = false;
        command_timeout = 5000;
        format = ''
          ╭╴\\
          [ ](bg:#000000 fg:#FFFFFF)\\
          $directory\\
          $git_branch\\
          $git_status\\
          $git_metrics\\
          ╰─ '';
        directory = {
          truncation_length = 1;
          truncate_to_repo = false;
          truncation_symbol = "…/";
          format = "[ $path ]($style)";
          style = "bg:#000000 fg:#FFFFFF";
        };
        git_branch = {
          format = "[ $symbol$branch(:$remote_branch) ]($style)";
          symbol = " ";
          style = "bg:#000000 fg:#FFFFFF";
        };
        git_status = {
          format = "[$all_status]($style)";
          style = "bg:#000000 fg:#FFFFFF";
        };
        git_metrics = {
          format = "([+$added]($added_style))[]($added_style)";
          added_style = "fg:#FFFFFF bg:#000000";
          deleted_style = "fg:FFFFFF bg:000000";
          disabled = false;
        };
        cmd_duration = {
          format = "[  $duration ]($style)";
          style = "bg:#000000 fg:#FFFFFF";
        };
      };
    };

    tmux = {
      enable = true;
      keyMode = "vi";
      customPaneNavigationAndResize = true;
      extraConfig = ''
        unbind r
        bind r source-file ~/.config/tmux/tmux.conf

        set-option -g status-position top

        set -g status-bg black

        set -g @prefix_highlight_output_prefix "#[fg=brightcyan]#[bg=black]#[nobold]#[noitalics]#[nounderscore]#[bg=brightcyan]#[fg=black]"
        set -g @prefix_highlight_output_suffix ""
        set -g @prefix_highlight_copy_mode_attr "fg=brightcyan,bg=black,bold"

        set -g status-left "#[fg=brightblack,bg=black]#[fg=white,bg=brightblack,bold] #S #[fg=brightblack,bg=black,nobold,noitalics,nounderscore]"
        set -g status-right "#{prefix_highlight}#[fg=brightblack,bg=black,nobold,noitalics,nounderscore]#[fg=white,bg=brightblack,nobold] #H #[fg=brightblack,bg=black,nobold]"

        set -g window-status-format "#[fg=brightblack,bg=black,nobold,noitalics,nounderscore]#[fg=white,bg=brightblack] #I#[fg=white,bg=brightblack,nobold,noitalics,nounderscore]: #W #[fg=brightblack,bg=black,nobold,noitalics,nounderscore]"

        set -g window-status-current-format "#[fg=#5e81ac,bg=black]#[fg=white,bg=#5e81ac,bold,noitalics,nounderscore] #I#[fg=white,bg=#5e81ac,bold,noitalics,nounderscore]: #W #[fg=#5e81ac,bg=black,nobold,noitalics,nounderscore]"
        set -g window-status-separator " "

        # center window list (*centre)
        set -g status-justify centre

        set -g pane-active-border-style "bg=default fg=blue"
      '';
    };


    zathura = {
      enable = true;
      options = {
        recolor = "true";
        recolor-keephue = "true";
        scroll-page-aware = "true";
        font = "Maple Mono 12";
      };
    };

    neovim = {
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
        opt.showmode = false

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

        -- telescope
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
        vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
      '';

      plugins = let
        nvim-treesitter-with-plugins = pkgs.vimPlugins.nvim-treesitter.withPlugins (treesitter-plugins: with treesitter-plugins; [
          c
          nix
          python
          latex
          java
        ]);
      in
        with pkgs.vimPlugins; [
          {
            plugin = lualine-nvim;
            type = "lua";
            config = ''
              local theme = require'lualine.themes.auto'
              theme.inactive.c.bg = '#00000000'
              theme.visual.c.bg = '#00000000'
              theme.replace.c.bg = '#00000000'
              theme.normal.c.bg = '#00000000'
              theme.insert.c.bg = '#00000000'
              theme.command.c.bg = '#00000000'
              require('lualine').setup{
                options = {
                  icons_enabled = true,
                  theme = theme,
                  component_separators = '|',
                  section_separators = { left = '', right = '' },
                  disabled_filetypes = {},
                  globalstatus = false,
                },
                sections = {
                  lualine_a = {{
                    'mode',
                    separator = { left = '', right = ''},
                  }},
                  lualine_b = {'filename'},
                  lualine_c = {{
                    'diff',
                    color = {bg = '#00000000'}
                  }},
                  lualine_x = {{
                    'diagnostics',
                    color = {bg = '#00000000'}
                  }},
                  lualine_y = {'progress'},
                  lualine_z = {{
                    'location',
                    separator = { left = '', right = ''},
                  }}
                },
                tabline = {},
                extensions = {}
                }
            '';
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
              require'lspconfig'.jdtls.setup{}
              require'lspconfig'.gleam.setup{}
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
          {
            plugin = vimtex;
            type = "lua";
            config = ''
                  vim.g.vimtex_view_method = "zathura"
            '';
          }
        ];
      };

    };

}
