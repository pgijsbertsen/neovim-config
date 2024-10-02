-- highlight when yanking text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Set python3_host_prog to the correct python3 interpreter
vim.api.nvim_create_autocmd("VimEnter", {
  pattern = "*",
  callback = function()
    local venv = os.getenv("VIRTUAL_ENV")
    if venv then
      vim.g.python3_host_prog = venv .. "/bin/python"
    else
      vim.g.python3_host_prog = "/usr/bin/python3"
    end
  end
})

-- Set filetype to ansible-yaml for yaml files in ansible directorie
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.yaml", "*.yml" },
  callback = function()
    local current_file = vim.fn.expand("%:p")
    local homedir = vim.fn.expand("$HOME")
    if string.match(current_file, homedir .. "/Development/ansible/") then
      vim.bo.filetype = "yaml.ansible"
    end
  end,
})