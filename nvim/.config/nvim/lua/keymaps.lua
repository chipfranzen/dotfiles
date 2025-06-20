-- Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>")

-- Config files
vim.keymap.set("n", "<leader>ev", ":edit $MYVIMRC<cr>", { desc = "Edit Vim config" })
vim.keymap.set("n", "<leader>sv", ":source $MYVIMRC<cr>", { desc = "Source Vim config" })
-- vim.keymap.set('n', '<leader>ek', ':edit ~/.config/kitty/kitty.conf<cr>', {desc = 'Edit kitty config'})
vim.keymap.set("n", "<leader>ez", ":edit ~/.zshrc<cr>", { desc = "zsh config." })

-- display
vim.keymap.set("n", "<leader>l", ":redraw!<cr>:nohl<cr><esc>", { desc = "redraw" })
vim.keymap.set("n", "<leader>v", ":vsplit<cr><c-w>l", { desc = "create vertical split" })
vim.keymap.set("n", "<leader>h", ":split<cr><c-w>l", { desc = "create vertical split" })

-- Toggle diagnostics
-- -- Toggle diagnostics for the current buffer
local diagnostics_enabled = true

vim.keymap.set("n", "<leader>dd", function()
  diagnostics_enabled = not diagnostics_enabled
  if diagnostics_enabled then
    vim.diagnostic.enable(0)
    vim.notify("Diagnostics enabled", vim.log.levels.INFO)
  else
    vim.diagnostic.disable(0)
    vim.notify("Diagnostics disabled", vim.log.levels.WARN)
  end
end, { desc = "Toggle diagnostics for buffer" })

-- save and quit
vim.keymap.set("n", "<leader>w", ":write<cr>", { desc = "write current file" })
vim.keymap.set("n", "<leader>q", ":quit<cr>", { desc = "quit" })
vim.keymap.set("n", "<leader>Q", ":qa<cr>", { desc = "quit all" })
vim.keymap.set("n", "Y", "y$", { desc = "yank until end of line" })

vim.keymap.set("n", "<leader>j", ":%!python -m json.tool<cr>", { desc = "format json" })

vim.keymap.set("n", "<leader>cc", function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  print("Copied: " .. path)
end, { desc = "Copy full file path to clipboard" })

vim.keymap.set("n", "<leader>cb", 'gg"+yG', { desc = "Copy buffer to clipboard" })
