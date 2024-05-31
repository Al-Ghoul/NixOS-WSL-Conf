{ pkgs, nixvim, ... }: {
  programs = {
    nixvim = {
      enable = true;
      autoCmd = [{
        event = [ "FileType" ];
        pattern = [
          "startup"
          "dapui_watches"
          "dap-repl"
          "dapui_console"
          "dapui_stacks"
          "dapui_breakpoints"
          "dapui_scopes"
          "help"
        ];
        callback = {
          __raw =
            "function() require('ufo').detach() vim.opt_local.foldenable = false end";
        };
      }];
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
      '';
      globals = { mapleader = ","; };
      keymaps = [
        {
          action = ":Format<CR>";
          key = "<space>f";
          mode = "n";
          options = {
            silent = true;
            desc = "Format current buffer";
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
        completeopt = "menu,menuone,noselect";

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
      colorschemes.melange = { enable = true; };
      plugins = {
        startup = {
          enable = true;
          parts = [ "header" "body" ];
          sections = {
            body = {
              align = "center";
              content = [
                [ " Find File" "FzfLua files" "<leader>ff" ]
                [ "󰍉 Find Word" "FzfLua live_grep" "<leader>fg" ]
                [ " Recent Files" "FzfLua oldfiles" "<leader>of" ]
                [ " Colorschemes" "FzfLua colorschemes" "<leader>cs" ]
                [ " New File" "lua require'startup'.new_file()" "<leader>nf" ]
              ];
              defaultColor = "";
              foldSection = false;
              highlight = "String";
              margin = 5;
              oldfilesAmount = 3;
              title = "Basic Commands";
              type = "mapping";
            };
            header = {
              align = "center";
              content = { __raw = "require('startup.headers').hydra_header"; };
              defaultColor = "";
              foldSection = false;
              highlight = "Statement";
              margin = 5;
              oldfilesAmount = 0;
              title = "Header";
              type = "text";
            };
          };
        };
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
        harpoon = {
          enable = true;
          keymaps = {
            addFile = "<leader>a";
            toggleQuickMenu = "<leader>e";
            navNext = "<leader>pp";
            navPrev = "<leader>nn";
          };
        };
        airline = {
          enable = true;
          settings.theme = "transparent";
        };
        which-key.enable = true;
        better-escape.enable = true;
        comment.enable = true;
        lastplace.enable = true;
        markdown-preview.enable = true;
        noice.enable = true;
        fidget.enable = true;
        illuminate.enable = true;
        nvim-ufo.enable = true;
        nvim-colorizer.enable = true;
        spider = {
          enable = true;
          keymaps = {
            motions = {
              b = "b";
              e = "e";
              ge = "ge";
              w = "w";
            };
          };
        };
        surround.enable = true;
        rainbow-delimiters.enable = true;
        vim-matchup.enable = true;
        wilder = {
          enable = true;
          modes = [ "/" "?" ":" ];
        };

        treesitter.enable = true;
        treesitter-context.enable = true;
        navbuddy = {
          enable = true;
          useDefaultMapping = true;
          lsp.autoAttach = true;
        };
        lspsaga.enable = true;

        lsp = {
          enable = true;
          servers = {
            nixd.enable = true;
            clangd = {
              enable = true;
              cmd = [ "clangd" "--offset-encoding=utf-16" ];
            };
            cmake.enable = true;
            tsserver.enable = true;
          };
        };
        lint.enable = true;

        luasnip = {
          enable = true;
          fromVscode = [ { } ];
        };

        cmp = {
          enable = true;
          settings = {
            snippet.expand =
              "function(args) require('luasnip').lsp_expand(args.body) end";
            sources = [
              { name = "nvim_lsp"; }
              { name = "luasnip"; }
              { name = "path"; }
              { name = "buffer"; }
              { name = "codeium"; }
            ];
            mapping = {
              "<C-Space>" = "cmp.mapping.complete()";
              "<C-d>" = "cmp.mapping.scroll_docs(-4)";
              "<C-e>" = "cmp.mapping.close()";
              "<C-f>" = "cmp.mapping.scroll_docs(4)";
              "<CR>" = "cmp.mapping.confirm({ select = true })";
              "<S-Tab>" =
                "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
              "<Tab>" =
                "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
            };
          };
        };

        lsp-format.enable = true;

        none-ls = {
          enable = true;
          enableLspFormat = true;
          sources = {
            diagnostics = {
              deadnix.enable = true;
              statix.enable = true;
              markdownlint.enable = true;
            };
            formatting = {
              black.enable = true;
              nixfmt.enable = true;
              markdownlint.enable = true;
            };
          };
        };

        smart-splits = {
          enable = true;
          settings = {
            ignored_events = [ "BufEnter" "WinEnter" ];
            resize_mode = {
              quit_key = "<ESC>";
              resize_keys = [ "h" "j" "k" "l" ];
              silent = true;
            };
          };
        };

        codeium-nvim.enable = true;

        undotree.enable = true;
        tmux-navigator.enable = true;
        friendly-snippets.enable = true;
        transparent = {
          enable = true;
          settings.extra_groups = [ "Folded" "WhichKeyFloat" "NormalFloat" ];
        };
      };
      extraPlugins = with pkgs.vimPlugins; [
        lazygit-nvim
        vim-highlightedyank
        vim-visual-multi
        vim-airline-themes
      ];
    };

    ripgrep.enable = true;
    lazygit = {
      enable = true;
      settings = {
        gui.theme = { lightTheme = false; };
        customCommands = [{
          key = "C";
          command = "git cz";
          description = "commit with commitizen";
          context = "files";
          loadingText = "opening commitizen commit tool";
          subprocess = true;
        }];
      };
    };

  };

}
