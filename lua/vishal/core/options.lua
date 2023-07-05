local opt = vim.opt -- for conciseness

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

opt.listchars = "eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:."
opt.list = true

-- Disable readonly mode for vimdiff
opt.ro = false

-- fast update
-- opt.updatetime = 50
