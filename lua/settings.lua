

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.cmd[[set cpoptions+=x]]
vim.cmd[[set noswapfile]]

require('ayu').setup({
   mirage = false, -- Set to `true` to use `mirage` variant instead of `dark` for dark background.
   overrides = {}, -- A dictionary of group names, each associated with a dictionary of parameters (`bg`, `fg`, `sp` and `style`) and colors in hex.
})

vim.cmd("colorscheme darkblue")

--
-- vim.cmd('hi! Constant guibg=black  guifg=white')
-- vim.cmd('hi! String guibg=black  guifg=white')
-- vim.cmd('hi! Character guibg=black  guifg=white')
-- vim.cmd('hi! Number guibg=black  guifg=white')
-- vim.cmd('hi! Boolean guibg=black  guifg=white')
-- vim.cmd('hi! Float guibg=black  guifg=white')
--
-- vim.cmd('hi! Tag guibg=black  guifg=blue')
--
vim.cmd('hi! Normal guifg=yellow')
 vim.cmd('hi! Function guibg=NONE  guifg=yellow gui=bold')
-- vim.cmd('hi! Comment guibg=black guifg=lightgrey ')
 vim.cmd('hi! Identifier guibg=NONE guifg=white')
--
-- vim.cmd('hi! Type guibg=black guifg=white gui=bold')
-- vim.cmd('hi! StorageClass guibg=black guifg=white gui=bold')
-- vim.cmd('hi! Structure guibg=black guifg=white gui=bold')
-- vim.cmd('hi! Typedef guibg=black guifg=white gui=bold')
--
-- vim.cmd('hi! Repeat guibg=black guifg=#FF0058 ')
-- vim.cmd('hi! Condition guibg=black guifg=#FF0058 ')
-- vim.cmd('hi! Exception guibg=black guifg=#FF0058 ')
-- vim.cmd('hi! Statement guibg=black guifg=#FF7575 gui=NONE')
-- vim.cmd('hi! Operator guibg=black guifg=white ')
--
--
-- vim.cmd('hi! PrePro guibg=black guifg=#FF0058 ')
-- vim.cmd('hi! Include guibg=black guifg=#FF0058 ')
-- vim.cmd('hi! Define guibg=black guifg=#FF0058 ')
-- vim.cmd('hi! Macro guibg=black guifg=#FF0058  ')
-- vim.cmd('hi! PreCondit guibg=black guifg=#FF0058 ')
-- vim.cmd('hi! PreCondit guibg=black guifg=#FF0058 ')
--
--
-- vim.cmd('hi! Special guibg=black guifg=#FF0058 ')
-- vim.cmd('hi! SpecialChar guibg=black guifg=#FF0058 ')
-- vim.cmd('hi! Tag guibg=black guifg=#FF0058 ')
-- vim.cmd('hi! Delimiter guibg=black guifg=#FF0058 ')
-- vim.cmd('hi! SpecialComment guibg=black guifg=#FF0058 ')
-- vim.cmd('hi! Debug guibg=black guifg=#FF0058 ')
-- vim.cmd('hi! Underlined guibg=#251C25 guifg=#FF0058 ')
-- vim.cmd('hi! Ignore guibg=black guifg=#FF0058 ')
-- vim.cmd('hi! Error guibg=black guifg=#FF0058 ')
-- vim.cmd('hi! Todo guibg=black guifg=#FF0058 ')
--
-- COLOR START 
  vim.cmd('hi! TelescopeSelection guibg=#251C25 guifg=#11FF29 ')
  vim.cmd('hi! WhichKeyFloat guibg=black guifg=#11FF29 ')
  vim.cmd('hi! WhichKeyDesc guibg=black guifg=#11FF29 ')
  vim.cmd('hi! WhichKeyGroup guibg=black guifg=#11FF29 ')

  vim.cmd('hi! Visual guibg=white guifg=blue ')
 --
  vim.cmd('hi! Pmenu guibg=#252A58 guifg=white ')
   vim.cmd('hi! PmenuSel guibg=#2F377E guifg=yellow gui=bold')
   vim.cmd('hi! PmenuKind guibg=NONE guifg=white ')
   vim.cmd('hi! PmenuKindSel guibg=NONE guifg=white ')
   vim.cmd('hi! PmenuExtra guibg=NONE guifg=white ')
   vim.cmd('hi! PmenuExtraSel guibg=NONE guifg=white ')
   vim.cmd('hi! PmenuSbar guibg=NONE guifg=white ')
   vim.cmd('hi! PmenuThumb guibg=NONE guifg=white ')
   vim.cmd('hi! CmpItemMenu guibg=NONE guifg=white ')
   vim.cmd('hi! CmpItemMenuDefault guibg=NONE guifg=white ')
   vim.cmd('hi! CmpItemMenuKind guibg=NONE guifg=white ')

   vim.cmd('hi! NvimTreeCursorLine guibg=#0E1024 guifg=yellow ')
   vim.cmd('hi! NvimTreeCursorColumn guibg=NONE guifg=yellow ')
   vim.cmd('hi! NvimTreeFolderName guibg=NONE guifg=white ')
   vim.cmd('hi! NvimTreeOpenedFolderName guibg=NONE guifg=white ')
   vim.cmd('hi! NvimTreeSymlinkFolderName guibg=NONE guifg=white ')
 --
   vim.cmd('hi! SignColumn guibg=NONE guifg=NONE ')
 --
 --
   vim.cmd('hi! DapUIType guibg=NONE guifg=yellow gui=NONE')
   vim.cmd('hi! DapUIVariable guibg=#251C25 guifg=#11FF29 gui=NONE')
   vim.cmd('hi! DapUIValue guibg=NONE guifg=white gui=NONE')
   vim.cmd('hi! DapUINormal guibg=NONE guifg=white gui=NONE')
   vim.cmd('hi! DapUIModifiedValue guibg=NONE guifg=yellow gui=NONE')

   vim.cmd('hi! debugPC guibg=white guifg=blue ')

   vim.cmd('hi! QuickFixLine guibg=NONE guifg=white ')

-- -- COLOR END
--
--  --vim.cmd('hi! NonText guibg=NONE guifg=NONE ')
-- --
-- -- vim.cmd('hi! CmpItemMenu guibg=#251C25 guifg=#11FF29 ')
-- -- vim.cmd('hi! CmpMenu guibg=#251C25 guifg=#11FF29 ')
-- -- vim.cmd('hi! CmpItemMenuInfo guibg=#251C25 guifg=#11FF29 ')
-- -- vim.cmd('hi! CmpItemMenuInfo guibg=#251C25 guifg=#11FF29 ')
-- -- vim.cmd('hi! CmpNormal guibg=#251C25 guifg=#11FF29 ')
-- --
-- -- vim.cmd [[
-- --   hi CmpItemMenu guibg=NONE ctermbg=235
-- --   hi CmpItemAbbr guibg=NONE ctermbg=235
-- --   hi CmpItemKind guibg=NONE ctermbg=235
-- --   hi CmpItemMenuSeparator guibg=NONE ctermbg=235
-- --   hi CmpItemMenuInfo guibg=NONE ctermbg=235
-- --   hi CmpItemAbbrMatch guibg=NONE ctermbg=236
-- --   hi CmpItemAbbrMatchFuzzy guibg=NONE ctermbg=236
-- --   hi CmpItemAbbrDeprecated guibg=NONE ctermbg=235
-- --   hi CmpItemAbbrMatchDeprecated guibg=NONE ctermbg=235
-- --   hi CmpItemAbbrMatchFuzzyDeprecated guibg=NONE ctermbg=235
-- --   hi CmpMenu guibg=NONE ctermbg=235
-- --   hi CmpMenuSel guibg=NONE ctermbg=32
-- -- ]]
-- --
-- --    vim.cmd [[
-- -- highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6
-- -- highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#569CD6
-- -- highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0
-- -- highlight! CmpItemKindMethod guibg=NONE guifg=#C586C0
-- -- highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE
-- -- highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4
-- -- ]]
--
--                vim.cmd [[highlight! link CmpItemAbbrMatchFuzzy Aqua]]
--             vim.cmd [[highlight! link CmpItemKindText Fg]]
--             vim.cmd [[highlight! link CmpItemKindMethod Purple]]
--             vim.cmd [[highlight! link CmpItemKindFunction Purple]]
--             vim.cmd [[highlight! link CmpItemKindConstructor Green]]
--             vim.cmd [[highlight! link CmpItemKindField Aqua]]
--             vim.cmd [[highlight! link CmpItemKindVariable Blue]]
--             vim.cmd [[highlight! link CmpItemKindClass Green]]
--             vim.cmd [[highlight! link CmpItemKindInterface Green]]
--             vim.cmd [[highlight! link CmpItemKindValue Orange]]
--             vim.cmd [[highlight! link CmpItemKindKeyword Keyword]]
--             vim.cmd [[highlight! link CmpItemKindSnippet Red]]
--             vim.cmd [[highlight! link CmpItemKindFile Orange]]
--             vim.cmd [[highlight! link CmpItemKindFolder Orange]]

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
--vim.wo.number = true
-- vim.o.number = true
-- vim.o.relativenumber = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

