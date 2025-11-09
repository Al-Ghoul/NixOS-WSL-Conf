{pkgs, ...}: {
  programs = {
    nixvim = {
      enable = true;
      clipboard.providers.wl-copy.enable = true;
      performance = {
        byteCompileLua = {
          enable = true;
          configs = true;
          initLua = true;
          luaLib = true;
          nvimRuntime = true;
          plugins = true;
        };
      };
      lsp = {
        inlayHints.enable = true;
        servers = {
          nixd.enable = true;
          clangd = {
            enable = true;
            settings = {
              cmd = [
                "clangd"
                "--background-index"
              ];
              filetypes = [
                "c"
                "cpp"
              ];
              root_markers = [
                "compile_commands.json"
                "compile_flags.txt"
              ];
            };
          };
          cmake.enable = true;
          jsonls.enable = true;
          marksman.enable = true;
          nginx_language_server.enable = true;
          zls.enable = true;
          eslint.enable = true;
          glsl_analyzer.enable = true;
        };
      };
      extraConfigLua = ''
        -- resizing splits
        vim.keymap.set('n', '<A-h>', require('smart-splits').resize_left)
        vim.keymap.set('n', '<A-j>', require('smart-splits').resize_down)
        vim.keymap.set('n', '<A-k>', require('smart-splits').resize_up)
        vim.keymap.set('n', '<A-l>', require('smart-splits').resize_right)
        -- moving between splits
        vim.keymap.set('n', '<C-h>', require('smart-splits').move_cursor_left)
        vim.keymap.set('n', '<C-j>', require('smart-splits').move_cursor_down)
        vim.keymap.set('n', '<C-k>', require('smart-splits').move_cursor_up)
        vim.keymap.set('n', '<C-l>', require('smart-splits').move_cursor_right)

        local harpoon = require("harpoon")
        harpoon:setup()

        vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
        vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
        vim.keymap.set("n", "<leader>pp", function() harpoon:list():prev() end)
        vim.keymap.set("n", "<leader>nn", function() harpoon:list():next() end)

        vim.keymap.set("n", "<space>f", vim.lsp.buf.format, {})

        -- fixes glsl_analyzer\'s filetype detection (filetypes attr doesn\'t seem to work for some reason)
        vim.filetype.add({
          extension = {
            ["vert"] = "glsl",
            ["tesc"] = "glsl",
            ["tese"] = "glsl",
            ["frag"] = "glsl",
            ["geom"] = "glsl",
            ["comp"] = "glsl",
            ["vs"] = "glsl",
            ["fs"] = "glsl",
          },
        })
      '';
      globals = {mapleader = ",";};
      keymaps = [
        {
          action = ":Navbuddy<CR>";
          key = "<leader>b";
          mode = "n";
          options = {
            silent = true;
            desc = "Open up navbuddy";
          };
        }

        {
          action = ":LazyGit<CR>";
          key = "<leader>lg";
          mode = "n";
          options = {
            silent = true;
            desc = "Open up lazygit";
          };
        }

        {
          action = ":noh<CR>";
          key = "<esc>";
          mode = "n";
          options = {
            silent = true;
            desc = "Turns off search highlighting";
          };
        }

        {
          action = ":Lspsaga code_action<CR>";
          key = "<leader>ca";
          mode = "n";
          options = {
            silent = true;
            desc = "Opens up Lspsaga's code actions";
          };
        }

        {
          action = ":Lspsaga peek_definition<CR>";
          key = "<leader>gd";
          mode = "n";
          options = {
            silent = true;
            desc = "Peek symbol's definition";
          };
        }

        {
          action = ":Lspsaga goto_definition<CR>";
          key = "<leader>gD";
          mode = "n";
          options = {
            silent = true;
            desc = "Goto symbol's definition";
          };
        }

        {
          action = ":Lspsaga finder<CR>";
          key = "<leader>fd";
          mode = "n";
          options = {
            silent = true;
            desc = "Find symbol's definition in current buffer";
          };
        }

        {
          action = ":Lspsaga rename<CR>";
          key = "<leader>rn";
          mode = "n";
          options = {
            silent = true;
            desc = "Rename all occurrences for the current symbol";
          };
        }
        {
          action = ":Lspsaga show_line_diagnostics<CR>";
          key = "<leader>D";
          mode = "n";
          options = {
            silent = true;
            desc = "Show diagnostics for the current line";
          };
        }

        {
          action = ":Lspsaga show_cursor_diagnostics<CR>";
          key = "<leader>d";
          mode = "n";
          options = {
            silent = true;
            desc = "Show diagnostics for the symbol under the cursor";
          };
        }

        {
          action = ":Lspsaga diagnostic_jump_prev<CR>";
          key = "<leader>pd";
          mode = "n";
          options = {
            silent = true;
            desc = "Jump to previous diagnostic in current buffer";
          };
        }

        {
          action = ":Lspsaga diagnostic_jump_next<CR>";
          key = "<leader>nd";
          mode = "n";
          options = {
            silent = true;
            desc = "Jump to next diagnostic in current buffer";
          };
        }

        {
          action = ":Lspsaga hover_doc<CR>";
          key = "K";
          mode = "n";
          options = {
            silent = true;
            desc = "Show documentation for the symbol under the cursor";
          };
        }

        {
          action = "<gv";
          key = "<";
          mode = "v";
          options = {
            silent = true;
            desc = "Shift indentation to the left";
          };
        }

        {
          action = ">gv";
          key = ">";
          mode = "v";
          options = {
            silent = true;
            desc = "Shift indentation to the right";
          };
        }
      ];

      opts = {
        # Tabs / Indentation
        tabstop = 2;
        shiftwidth = 2;
        softtabstop = 2;
        expandtab = true;
        smartindent = true;
        wrap = false;

        # Search
        incsearch = true;
        ignorecase = true;
        smartcase = true;
        hlsearch = true;

        # Appearance
        number = true;
        relativenumber = true;
        termguicolors = true;
        signcolumn = "yes";
        cmdheight = 1;
        scrolloff = 10;
        completeopt = "menu,preview,menuone,noselect";

        # Behavior
        hidden = true;
        errorbells = false;
        swapfile = false;
        backup = false;
        undofile = true;
        backspace = "indent,eol,start";
        splitright = true;
        splitbelow = true;
        autochdir = false;
        modifiable = true;
        encoding = "UTF-8";
      };

      colorschemes.nightfox = {
        enable = true;
        flavor = "terafox";
        settings.options.transparent = true;
      };

      plugins = {
        startup = {
          enable = true;
          settings = {
            parts = ["header" "body"];
            body = {
              align = "center";
              content = [
                [" Find File" "FzfLua files" "<leader>ff"]
                [" Find Word" "FzfLua live_grep" "<leader>fg"]
                [" Recent Files" "FzfLua oldfiles" "<leader>of"]
                [" Colorschemes" "FzfLua colorschemes" "<leader>cs"]
                [" New File" "lua require'startup'.new_file()" "<leader>nf"]
              ];
              defaultColor = "";
              foldSection = false;
              highlight = "Statement";
              margin = 5;
              oldfilesAmount = 3;
              title = "Basic Commands";
              type = "mapping";
            };
            header = {
              align = "center";
              content = {__raw = "require('startup.headers').hydra_header";};
              defaultColor = "#8BAFE0";
              foldSection = false;
              highlight = "Statement";
              margin = 5;
              oldfilesAmount = 0;
              title = "Header";
              type = "text";
            };
          };
        };
        oil.enable = true;
        nix.enable = true;
        fzf-lua = {
          enable = true;
          keymaps = {
            "<leader>fg" = "live_grep";
            "<leader>ff" = "files";
            "<leader>fk" = "keymaps";
            "<leader>fb" = "buffers";
          };
        };
        which-key.enable = true;
        comment.enable = true;
        lastplace.enable = true;
        markdown-preview.enable = true;
        navbuddy = {
          enable = true;
          settings = {
            lsp.auto_attach = true;
          };
        };
        noice.enable = true;
        fidget.enable = true;
        illuminate.enable = true;
        ccc = {
          enable = true;
          settings = {
            highlighter.auto_enable = true;
          };
        };

        csvview.enable = true;
        emmet.enable = true;
        vim-surround.enable = true;
        todo-comments.enable = true;
        treesitter = {
          enable = true;
          nixvimInjections = true;
          settings = {
            highlight.enable = true;
            indent.enable = true;
          };
        };
        rainbow-delimiters.enable = true;
        wilder = {
          enable = true;
          settings.modes = ["/" "?" ":"];
        };

        lspsaga.enable = true;
        web-devicons.enable = true;

        lint.enable = true;

        none-ls = {
          enable = true;
          sources = {
            code_actions = {
              statix.enable = true;
            };
            diagnostics = {
              deadnix.enable = true;
              statix.enable = true;
              actionlint.enable = true;
              golangci_lint.enable = true;
            };
            formatting = {
              treefmt.enable = true;
            };
          };
        };

        ts-autotag.enable = true;

        friendly-snippets.enable = true;
        luasnip = {
          enable = true;
          fromVscode = [{}];
        };

        cmp = {
          enable = true;
          settings = {
            sources = [
              {name = "nvim_lsp";}
              {name = "buffer";}
              {name = "path";}
              {name = "luasnip";}
            ];
            mapping = {
              "<C-Space>" = "cmp.mapping.complete()";
              "<C-d>" = "cmp.mapping.scroll_docs(-4)";
              "<C-e>" = "cmp.mapping.close()";
              "<C-f>" = "cmp.mapping.scroll_docs(4)";
              "<CR>" = "cmp.mapping.confirm({ select = false })";
              "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
              "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
            };
          };
        };
        smart-splits = {
          enable = true;
          settings = {
            ignored_events = ["BufEnter" "WinEnter"];
            resize_mode = {
              quit_key = "<ESC>";
              resize_keys = ["h" "j" "k" "l"];
              silent = true;
            };
          };
        };

        windsurf-vim = let
          codeiumPkg = pkgs.codeium.overrideAttrs (prevAttrs: rec {
            version = "1.46.0";
            plat = "linux_x64";
            src = pkgs.fetchurl {
              name = "${prevAttrs.pname}-${version}.gz";
              url = "https://github.com/Exafunction/codeium/releases/download/language-server-v${version}/language_server_${plat}.gz";
              hash = "sha256-wZl6wlR+K53rGeQ75ZVzmzKpiBnp6/UCTNx/iOHscug=";
            };
          });
        in {
          enable = true;
          package = pkgs.vimPlugins.windsurf-vim.overrideAttrs (_: _: {
            version = "git";
            src = pkgs.fetchFromGitHub {
              owner = "Exafunction";
              repo = "codeium.vim";
              rev = "272c6e2755e8faa90e26bcdcd9fde6b9e61751ea";
              sha256 = "sha256-V3ePeEysQFvYO7cVlNsbs5WURo15kJrxWIvx5KkGXTQ=";
            };
          });
          settings = {bin = "${codeiumPkg}/bin/codeium_language_server";};
        };

        undotree.enable = true;
        transparent = {
          enable = true;
          settings.extra_groups = ["Folded" "WhichKeyFloat" "NormalFloat"];
        };
        neoscroll.enable = true;
        lazygit.enable = true;
        mark-radar.enable = true;
        marks.enable = true;
        codesnap = {
          enable = true;
          settings = {watermark = "AlGhoul";};
        };

        flash.enable = true;
        hop.enable = true;
        cloak.enable = true;
        harpoon.enable = true;
        hardtime.enable = true;
        precognition.enable = true;
      };

      extraPlugins = with pkgs.vimPlugins; [
        vim-highlightedyank
        vim-airline-themes
      ];

      nixpkgs = {
        config = {
          allowUnfree = true;
        };
      };
    };

    ripgrep.enable = true;
    lazygit = {
      enable = true;
      settings = {
        gui.theme = {lightTheme = false;};
      };
    };
  };
}
