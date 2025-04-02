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

  #                #
  # window manager #
  #                #
  # @https://github.com/YaLTeR/niri/wiki
  programs.niri = {
    enable = true;

    # home-manager settings:
    # @https://github.com/sodiboo/niri-flake/blob/main/docs.md#homemodulesconfig
    settings = {

      input = {
        keyboard = {
          # repeat-delay = 600;
          # repeat-rate = 25;
          # track-layout = "window";
          xkb = {
            # layout = "us, pt";
            # options = "grp:win_space_toggle";
          };
        };
        touchpad = {
          # off = true
          # tap = false
          # dwt = true
          # dwtp = true
          # natural-scroll
          # accel-speed 0.2
          # accel-profile "flat"
          # scroll-method "two-finger"
          # disabled-on-external-mouse
        };
        mouse = {
          # off = true
          # natural-scroll = true
          # accel-speed = 0.2
          # accel-profile = "flat"
          # scroll-method = "no-scroll"
        };
        trackpoint = {
          # off
          # natural-scroll
          # accel-speed 0.2
          # accel-profile "flat"
          # scroll-method "on-button-down"
          # scroll-button 273
          # middle-emulation
        };
        focus-follows-mouse.enable = true;
        warp-mouse-to-focus = true;
        # workspace-auto-back-and-forth = true;
      };

      outputs = {
        "HDMI-A-1" = {
          # off = true;
          mode = {
            width = 3440;
            height = 1440;
            refresh = 99.992;
          };
          # scale = 1;
          # transform = flipped;
          # position = {
          #   x = 0;
          #   y = 0;
          #};
        };
        "eDP-1" = {
          # off = true;
          mode = {
            width = 1920;
            height = 1080;
            refresh = 120.003;
          };
          # scale = 1;
          # transform = flipped;
          # position = {
          #   x = 0;
          #   y = 0;
          #};
        };
      };

      layout = {
        gaps = 20;
        # center-focused-column = "on-overflow";
        preset-column-widths = [
          {proportion = 1.0 / 3.0;}
          {proportion = 1.0 / 2.0;}
          {proportion = 2.0 / 3.0;}
          {proportion = 1.0;}
        ];

        # preset-window-heights = [{proportion = ...;}]

        default-column-width = {};

        # focused window
        focus-ring = {
          enable = false;
          width = 4;
          active.color = "#000000";
          inactive.color = "#000000";
          # active.gradient = {
          #  from = "#000000";
          #  to = "#000000";
          #  angle = 0;
          #};
          # inactive.gradient = {
          #  from = "#000000";
          #  to = "#000000";
          #  angle = 0;
          #};
        };

        border = {
          enable = false;
          width = 4;
          active.color = "#000000";
          inactive.color = "#000000";
          # active.gradient = {
          #  from = "#000000";
          #  to = "#000000";
          #  angle = 0;
          #};
          # inactive.gradient = {
          #  from = "#000000";
          #  to = "#000000";
          #  angle = 0;
          #};
        };

        shadow = {
          enable = false;
          # draw-behind-window = true;
          softness = 30;
          spread = 5;
          offset = {
            x = 0;
            y = 0;
          };
          color = "#000000";
        };

        # outer gaps
        struts = {
          left = 60;
          right = 60;
          top = 60;
          bottom = 60;
        };

      };

      spawn-at-startup = [ ];

      screenshot-path = "~/mídia/capturas/%Y-%m-%d-%H-%M-%S.png";

      animations = {
        # slowdown = 3.0;
        shaders.window-resize = ''
          vec4 resize_color(vec3 coords_curr_geo, vec3 size_curr_geo) {
            vec3 coords_next_geo = niri_curr_geo_to_next_geo * coords_curr_geo;

            vec3 coords_stretch = niri_geo_to_tex_next * coords_curr_geo;
            vec3 coords_crop = niri_geo_to_tex_next * coords_next_geo;

            // We can crop if the current window size is smaller than the next window
            // size. One way to tell is by comparing to 1.0 the X and Y scaling
            // coefficients in the current-to-next transformation matrix.
            bool can_crop_by_x = niri_curr_geo_to_next_geo[0][0] <= 1.0;
            bool can_crop_by_y = niri_curr_geo_to_next_geo[1][1] <= 1.0;

            vec3 coords = coords_stretch;
            if (can_crop_by_x)
                coords.x = coords_crop.x;
            if (can_crop_by_y)
                coords.y = coords_crop.y;

            vec4 color = texture2D(niri_tex_next, coords.st);

            // However, when we crop, we also want to crop out anything outside the
            // current geometry. This is because the area of the shader is unspecified
            // and usually bigger than the current geometry, so if we don't fill pixels
            // outside with transparency, the texture will leak out.
            //
            // When stretching, this is not an issue because the area outside will
            // correspond to client-side decoration shadows, which are already supposed
            // to be outside.
            if (can_crop_by_x && (coords_curr_geo.x < 0.0 || 1.0 < coords_curr_geo.x))
                color = vec4(0.0);
            if (can_crop_by_y && (coords_curr_geo.y < 0.0 || 1.0 < coords_curr_geo.y))
                color = vec4(0.0);

            return color;
          }
        '';
      };

      window-rules = [
        {
          # rounded corners
          geometry-corner-radius = {
            bottom-left = 18.0;
            bottom-right = 18.0;
            top-left = 18.0;
            top-right = 18.0;
          };
          clip-to-geometry = true;
        }
      ];

    };
  };

  #          #
  # programs #
  #          #
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
          gleam
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
