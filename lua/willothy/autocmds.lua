local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
  group = augroup("resize_splits"),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup("last_loc"),
  callback = function(event)
    local exclude = { "gitcommit" }
    local buf = event.buf
    if
      vim.tbl_contains(exclude, vim.bo[buf].filetype)
      or vim.b[buf].lazyvim_last_loc
    then
      return
    end
    vim.b[buf].lazyvim_last_loc = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("close_with_q"),
  pattern = {
    "PlenaryTestPopup",
    "help",
    "lspinfo",
    "notify",
    "qf",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "neotest-output",
    "checkhealth",
    "neotest-summary",
    "neotest-output-panel",
    "dbout",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set(
      "n",
      "q",
      "<cmd>close<cr>",
      { buffer = event.buf, silent = true }
    )
  end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = augroup("auto_create_dir"),
  callback = function(event)
    if event.match:match("^%w%w+:[\\/][\\/]") then
      return
    end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

-- Hyprlang LSP
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = { "*.hl", "hypr*.conf" },
  callback = function(event)
    print(string.format("starting hyprls for %s", vim.inspect(event)))
    vim.lsp.start({
      name = "hyprlang",
      cmd = { "hyprls" },
      root_dir = vim.fn.getcwd(),
    })
  end,
})

local autocmd = vim.api.nvim_create_autocmd

local group =
  vim.api.nvim_create_augroup("willothy.autocmds", { clear = true })

local autocmds = {
  {
    "LspAttach",
    callback = function(args)
      local bufnr = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)

      if not client then
        return
      end

      if client.supports_method("textDocument/documentHighlight") then
        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
          buffer = bufnr,
          group = group,
          callback = vim.lsp.buf.document_highlight,
        })

        vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
          buffer = bufnr,
          group = group,
          callback = vim.lsp.buf.clear_references,
        })
      end

      if
        vim.lsp.inlay_hint
        and client.supports_method("textDocument/inlayHint")
      then
        vim.lsp.inlay_hint.enable(true, {
          bufnr = bufnr,
        })
      end
    end,
  },
  {
    "BufWritePost",
    callback = function(ev)
      if vim.bo[ev.buf].modifiable and vim.bo[ev.buf].buftype == "" then
        require("mini.trailspace").trim()
      end
    end,
  },
  {
    "FileType",
    callback = function(ev)
      if vim.bo[ev.buf].buftype ~= "" then
        vim.api.nvim_buf_call(ev.buf, require("mini.trailspace").unhighlight)
      end
      if vim.bo[ev.buf].buftype ~= "" then
        return
      end
      local parsers = require("nvim-treesitter.parsers")
      local ft = vim.bo[ev.buf].filetype
      local lang = parsers.ft_to_lang(ft)
      if not lang then
        vim.notify_once(
          "No language config for filetype '" .. ft .. "'",
          vim.log.levels.WARN,
          {}
        )
        return
      end
      if parsers.has_parser(lang) then
        vim.treesitter.start(ev.buf, lang)
      end
    end,
  },
  {
    { "BufRead", "BufNewFile" },
    pattern = { "*.rasi" },
    callback = function(ev)
      local buf = ev.buf
      vim.bo[buf].filetype = "rasi"
    end,
  },
  {
    "FileChangedShellPost",
    callback = function()
      vim.cmd("checktime")
    end,
  },
  {
    { "BufLeave", "BufWinLeave" },
    callback = function(ev)
      if vim.bo[ev.buf].filetype == "lazy" then
        require("lazy.view").view:close({})
      elseif vim.bo[ev.buf].filetype == "TelescopePrompt" then
        vim.api.nvim_exec2("silent! stopinsert!", {})
      end
    end,
  },
  {
    "InsertLeave",
    callback = function()
      if vim.snippet.active() then
        vim.snippet.stop()
      end
      local cmp = require("cmp")
      if cmp.visible() then
        cmp.close()
      end
    end,
  },
}

return {
  setup = function()
    for _, v in ipairs(autocmds) do
      local event = v[1]
      v[1] = nil
      v.group = group
      autocmd(event, v)
    end
  end,
}
