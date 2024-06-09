local opt = vim.opt

-- Enable fuzzy finder to search from current directory recursively
vim.cmd(" set path+=**")

-- Enable filetype plugin
vim.cmd(" filetype plugin on")

-- line numbers
opt.relativenumber = true
opt.number = true

-- tabs & indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

-- recommended row size indicator
opt.colorcolumn = "100"

-- line wrapping
opt.wrap = true
opt.scrolloff = 4
opt.sidescrolloff = 4

-- search settings
opt.ignorecase = true
opt.smartcase = true

-- cursor line
opt.cursorline = true

-- appearance
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

-- backspace
opt.backspace = "indent,eol,start"

-- clipboard
opt.clipboard:append("unnamedplus")

-- split windows
opt.splitright = true
opt.splitbelow = true

-- consider hyphenated words as single word
opt.iskeyword:append("-")

opt.listchars = "eol:¬,tab:->,trail:~,extends:>,precedes:<,space:."
opt.list = true

-- Disable readonly mode for vimdiff
opt.ro = false

-- fast update
opt.updatetime = 50

opt.timeout = true
opt.timeoutlen = 500

-- turn off swap file
opt.swapfile = false
