require("rgflow").setup({
  -- Set the default rip grep flags and options for when running a search via
  -- RgFlow. Once changed via the UI, the previous search flags are used for
  -- each subsequent search (until Neovim restarts).
  cmd_flags = "--smart-case --fixed-strings --ignore --max-columns 200",

  -- Mappings to trigger RgFlow functions
  default_trigger_mappings = true,
  -- These mappings are only active when the RgFlow UI (panel) is open
  default_ui_mappings = true,
  -- QuickFix window only mapping
  default_quickfix_mappings = true,
  mappings = {
      trigger = {
          -- Normal mode maps
          n = {
              ["<leader>rG"] = "open_blank",      -- Open UI - search pattern = blank
              ["<leader>rp"] = "open_paste",      -- Open UI - search pattern = First line of unnamed register as the search pattern
              ["<leader>rg"] = "open_cword",      -- Open UI - search pattern = <cword>
              ["<leader>rw"] = "open_cword_path", -- Open UI - search pattern = <cword> and path = current file's directory
              ["<leader>rs"] = "search",          -- Run a search with the current parameters
              ["<leader>ra"] = "open_again",      -- Open UI - search pattern = Previous search pattern
              ["<leader>rx"] = "abort",           -- Close UI / abort searching / abortadding results
              ["<leader>rc"] = "print_cmd",       -- Print a version of last run rip grep that can be pasted into a shell
              ["<leader>r?"] = "print_status",    -- Print info about the current state of rgflow (mostly useful for deving on rgflow)
          },
          -- Visual/select mode maps
          x = {
              ["<leader>rg"] = "open_visual", -- Open UI - search pattern = current visual selection
          },
      },
      -- Mappings that are local only to the RgFlow UI
      ui = {
          -- Normal mode maps
          n = {
              ["<CR>"]  = "start",         -- With the ui open, start a search with the current parameters
              ["<ESC>"] = "close",         -- With the ui open, discard and close the UI window
              ["?"]     = "show_rg_help",  -- Show the rg help in a floating window, which can be closed with q or <ESC> or the usual <C-W><C-C>
              ["<BS>"]  = "parent_path",   -- Change the path to parent directory
              ["-"]     = "parent_path",   -- Change the path to parent directory
              ["<C-^>"] = "edit_alt_file", -- Switch to the alternate file
              ["<C-6>"] = "edit_alt_file", -- Switch to the alternate file
              ["<C-^>"] = "nop",           -- No operation
              ["<C-6>"] = "nop",           -- No operation
          },
          -- Insert mode maps
          i = {
              ["<CR>"]  = "start",         -- With the ui open, start a search with the current parameters (from insert mode)
              ["<TAB>"] = "auto_complete", -- Start autocomplete if PUM not visible, if visible use own hotkeys to select an option
              ["<C-N>"] = "auto_complete", -- Start autocomplete if PUM not visible, if visible use own hotkeys to select an option
              ["<C-P>"] = "auto_complete", -- Start autocomplete if PUM not visible, if visible use own hotkeys to select an option
          },
      },
      -- Mapping that are local only to the QuickFix window
      quickfix = {
          -- Normal
          n = {
              ["d"] = "qf_delete",        -- QuickFix normal mode delete operator
              ["dd"] = "qf_delete_line",  -- QuickFix delete a line from quickfix
              ["<TAB>"] = "qf_mark",      -- QuickFix mark a line in the quickfix
              ["<S-TAB>"] = "qf_unmark",  -- QuickFix unmark a line in the quickfix window
              ["<BS>"]  = "nop", -- No operation
              ["<C-^>"] = "nop", -- No operation - Probably don't want to switch to a buffer in the little quickfix window
              ["<C-6>"] = "nop", -- No operation
          },
          -- Visual/select mode maps
          x = {
              ["d"] = "qf_delete_visual",       -- QuickFix visual mode delete operator
              ["<TAB>"] = "qf_mark_visual",     -- QuickFix visual mode mark operator
              ["<S-TAB>"] = "qf_unmark_visual", -- QuickFix visual mode unmark operator
          }
      },
  }
})
