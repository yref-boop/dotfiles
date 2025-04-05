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
            layout = "us, pt";
            options = "grp:win_space_toggle";
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
          # off = true
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

      spawn-at-startup = [
         { command = ["swww-daemon"]; }
      ];

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

      environment = {
        CLUTTER_BACKEND = "wayland";
        DISPLAY = ":0";
        GDK_BACKEND = "wayland,x11";
        MOZ_ENABLE_WAYLAND = "1";
        NIXOS_OZONE_WL = "1";
        QT_QPA_PLATFORM = "wayland;xcb";
        QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
        SDL_VIDEODRIVER = "wayland";
        TERM = "kitty";
        TERMINAL = "kitty";
      };
      cursor = {
        size = 5;
      };

      prefer-no-csd = true;
      hotkey-overlay.skip-at-startup = true;

      binds = {
        "Mod+Shift+Slash".action.show-hotkey-overlay = { };

        "Mod+Slash".action.show-hotkey-overlay = { };

        "Mod+T".action.spawn = "kitty";
        "Mod+D".action.spawn = ["wofi" "--show" "run"];

        "Mod+Q".action.close-window = [];


        # audio
        "XF86AudioRaiseVolume" = {
          allow-when-locked = true;
          action.spawn = [
            "wpctl"
            "set-volume"
            "@DEFAULT_AUDIO_SINK@"
            "0.1+"
          ];
        };
        "XF86AudioLowerVolume" = {
          allow-when-locked = true;
          action.spawn = [
            "wpctl"
            "set-volume"
            "@DEFAULT_AUDIO_SINK@"
            "0.1-"
          ];
        };
        "XF86AudioMute" = {
          allow-when-locked = true;
          action.spawn = [
            "wpctl"
            "set-mute"
            "@DEFAULT_AUDIO_SINK@"
            "toggle"
          ];
        };
        "XF86AudioMicMute" = {
          allow-when-locked = true;
          action.spawn = [
            "wpctl"
            "set-mute"
            "@DEFAULT_AUDIO_SOURCE@"
            "toggle"
          ];
        };


        # window controls
        "Mod+H".action.focus-column-left = { };
        "Mod+J".action.focus-window-down = { };
        "Mod+K".action.focus-window-up = { };
        "Mod+L".action.focus-column-right = { };

        "Mod+Ctrl+H".action.move-column-left = { };
        "Mod+Ctrl+J".action.move-window-down = { };
        "Mod+Ctrl+K".action.move-window-up = { };
        "Mod+Ctrl+L".action.move-column-right = { };

        "Mod+Ctrl+Home".action.move-column-to-first = { };
        "Mod+Ctrl+End".action.move-column-to-last = { };

        "Mod+Shift+H".action.focus-column-left = { };
        "Mod+Shift+J".action.focus-window-down = { };
        "Mod+Shift+K".action.focus-window-up = { };
        "Mod+Shift+L".action.focus-column-right = { };

        "Mod+Shift+Home".action.focus-column-first = { };
        "Mod+Shift+End".action.focus-column-last = { };

        "Mod+Shift+Ctrl+H".action.move-column-to-monitor-left = { };
        "Mod+Shift+Ctrl+J".action.move-column-to-monitor-down = { };
        "Mod+Shift+Ctrl+K".action.move-column-to-monitor-up = { };
        "Mod+Shift+Ctrl+L".action.move-column-to-monitor-right = { };


        # workspace controls
        "Mod+U".action.focus-workspace-down = { };
        "Mod+I".action.focus-workspace-up = { };

        "Mod+Ctrl+U".action.move-column-to-workspace-down = { };
        "Mod+Ctrl+I".action.move-column-to-workspace-up = { };

        "Mod+Shift+U".action.move-workspace-down = { };
        "Mod+Shift+I".action.move-workspace-up = { };

        "Mod+1".action.focus-workspace = 1;
        "Mod+2".action.focus-workspace = 2;
        "Mod+3".action.focus-workspace = 3;
        "Mod+4".action.focus-workspace = 4;
        "Mod+5".action.focus-workspace = 5;
        "Mod+6".action.focus-workspace = 6;
        "Mod+7".action.focus-workspace = 7;
        "Mod+8".action.focus-workspace = 8;
        "Mod+9".action.focus-workspace = 9;

        "Mod+Ctrl+1".action.move-column-to-workspace = 1;
        "Mod+Ctrl+2".action.move-column-to-workspace = 2;
        "Mod+Ctrl+3".action.move-column-to-workspace = 3;
        "Mod+Ctrl+4".action.move-column-to-workspace = 4;
        "Mod+Ctrl+5".action.move-column-to-workspace = 5;
        "Mod+Ctrl+6".action.move-column-to-workspace = 6;
        "Mod+Ctrl+7".action.move-column-to-workspace = 7;
        "Mod+Ctrl+8".action.move-column-to-workspace = 8;
        "Mod+Ctrl+9".action.move-column-to-workspace = 9;

        "Mod+Comma".action.consume-window-into-column = { };
        "Mod+Period".action.expel-window-from-column = { };

        "Mod+BracketLeft".action.consume-or-expel-window-left = { };
        "Mod+BracketRight".action.consume-or-expel-window-right = { };

        "Mod+R".action.switch-preset-column-width = { };
        "Mod+Shift+R".action.reset-window-height = { };

        "Mod+F".action.maximize-column = { };
        "Mod+Shift+F".action.fullscreen-window = { };

        "Mod+C".action.center-window = { };

        "Mod+Minus".action.set-column-width = "-10%";
        "Mod+Plus".action.set-column-width = "+10%";
        "Mod+Shift+Minus".action.set-window-height = "-10%";
        "Mod+Shift+Plus".action.set-window-height = "+10%";

        "Mod+V".action.toggle-window-floating = { };
        "Mod+Shift+V".action.switch-focus-between-floating-and-tiling = { };
        "Mod+W".action.toggle-column-tabbed-display = { };

        "Print".action.screenshot-screen = {write-to-disk = true;};
        "Ctrl+Print".action.screenshot-screen = { };
        "Alt+Print".action.screenshot-window = { };

        "Mod+Shift+E".action.quit = { };
        "Mod+Ctrl+Shift+E".action.quit = { skip-confirmation=true; };
        "Mod+Shift+P".action.power-off-monitors = { };
      };

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

        -- telescope keybinds
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
          haskell
          ocaml
        ]);
      in
        with pkgs.vimPlugins; [
          {
            plugin = nvim-web-devicons;
            type = "lua";
          }
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
                  lualine_b = {{
                    'filename',
                    color = {bg = '#00000000'},
                  }},
                  lualine_c = {{
                    'diff',
                    color = {bg = '#00000000'}
                  }},
                  lualine_x = {{
                    'diagnostics',
                    color = {bg = '#00000000'}
                  }},
                  lualine_y = {{
                    'progress',
                    color = {bg = '#00000000'},
                  }},
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
            config = ''require('gitsigns').setup({
              on_attach = function(bufnr)
                local gitsigns = require('gitsigns')

                local function map(mode, l, r, opts)
                  opts = opts or {}
                  opts.buffer = bufnr
                  vim.keymap.set(mode, l, r, opts)
                end

                -- Navigation
                map('n', ']c', function()
                  if vim.wo.diff then
                    vim.cmd.normal({']c', bang = true})
                  else
                    gitsigns.nav_hunk('next')
                  end
                end)

                map('n', '[c', function()
                  if vim.wo.diff then
                    vim.cmd.normal({'[c', bang = true})
                  else
                    gitsigns.nav_hunk('prev')
                  end
                end)

                -- Actions
                map('n', '<leader>hs', gitsigns.stage_hunk)
                map('n', '<leader>hr', gitsigns.reset_hunk)

                map('v', '<leader>hs', function()
                  gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
                end)

                map('v', '<leader>hr', function()
                  gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
                end)

                map('n', '<leader>hS', gitsigns.stage_buffer)
                map('n', '<leader>hR', gitsigns.reset_buffer)
                map('n', '<leader>hp', gitsigns.preview_hunk)
                map('n', '<leader>hi', gitsigns.preview_hunk_inline)

                map('n', '<leader>hb', function()
                  gitsigns.blame_line({ full = true })
                end)

                map('n', '<leader>hd', gitsigns.diffthis)

                map('n', '<leader>hD', function()
                  gitsigns.diffthis('~')
                end)

                map('n', '<leader>hQ', function() gitsigns.setqflist('all') end)
                map('n', '<leader>hq', gitsigns.setqflist)

                -- Toggles
                map('n', '<leader>tb', gitsigns.toggle_current_line_blame)
                map('n', '<leader>td', gitsigns.toggle_deleted)
                map('n', '<leader>tw', gitsigns.toggle_word_diff)

                -- Text object
                map({'o', 'x'}, 'ih', gitsigns.select_hunk)
              end
            })'';
          }
          {
            plugin = catppuccin-nvim;
            type = "lua";
            config = ''
              require('catppuccin').setup({
                transparent_background = true,
                color_overrides = {
                  mocha = {
                    text = "#ffffff",
                  },
                },
              })

              vim.cmd[[colorscheme catppuccin]]
              vim.cmd('hi Normal guibg=#00000000')

              vim.cmd [[
                hi DiagnosticUnderlineError gui=undercurl
                hi DiagnosticUnderlineWarn gui=undercurl
                hi DiagnosticUnderlineHint gui=undercurl
                hi DiagnosticUnderlineInfo gui=undercurl
              ]]
            '';
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
              require'lspconfig'.hls.setup{}
              require'lspconfig'.ocamllsp.setup{}

              -- lsp keybinds
              vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('UserLspConfig', {}),
                callback = function(ev)
                  -- Enable completion triggered by <c-x><c-o>
                  vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

                  -- Buffer local mappings.
                  -- See `:help vim.lsp.*` for documentation on any of the below functions
                  local opts = { buffer = ev.buf }
                  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
                  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
                  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
                  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
                  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
                  vim.keymap.set('n', '<space>wl', function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                  end, opts)
                  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
                  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
                  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
                  vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
                  vim.keymap.set('n', '<space>f', function()
                    vim.lsp.buf.format { async = true }
                  end, opts)
                end,
              })

              vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
              vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
              vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
              vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

            '';
          }
          {
            plugin = nvim-treesitter-with-plugins;
            type = "lua";
            config = ''require('nvim-treesitter.configs').setup({

              highlight = { enable = true, },

              incremental_selection = {
                enable = true,
                keymaps = {
                  init_selection = "gnn",
                  node_incremental = "grn",
                  scope_incremental = "grc",
                  node_decremental = "grm",
                },
              },
            })
          '';

          }
          {
            plugin = telescope-nvim;
            type = "lua";
            config = ''require('telescope').setup({
              vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' }),
              vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' }),
              vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' }),
              vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' }),
                  })
            '';
          }
          {
            plugin = vimtex;
            type = "lua";
            config = '' vim.g.vimtex_view_method = "zathura" '';
          }
        ];
      };

    };

}
