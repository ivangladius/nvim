--[[

=====================================================================
==================== READ THIS BEFORE CONTINUING ====================
=====================================================================

Kickstart.nvim is *not* a distribution.

Kickstart.nvim is a template for your own configuration.
  The goal is that you can read every line of code, top-to-bottom, understand
  what your configuration is doing, and modify it to suit your needs.

  Once you've done that, you should start exploring, configuring and tinkering to
  explore Neovim!

  If you don't know anything about Lua, I recommend taking some time to read through
  a guide. One possible example:
  - https://learnxinyminutes.com/docs/lua/


  And then you can explore or search through `:help lua-guide`
  - https://neovim.io/doc/user/lua-guide.html


Kickstart Guide:

I have left several `:help X` comments throughout the init.lua
You should run that command and read that help section for more information.

In addition, I have some `NOTE:` items throughout the file.
These are for you, the reader to help understand what is happening. Feel free to delete
them once you know what you're doing, but they should serve as a guide for when you
are first encountering a few different constructs in your nvim config.

I hope you enjoy your Neovim journey,
- TJ

P.S. You can delete this when you're done too. It's your config now :)
--]]

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)


-- [[ Install `lazy.nvim` plugin manager ]]
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- [[ Configure plugins ]]
-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
require('lazy').setup({
  -- NOTE: First, some plugins that don't require any configuration
  --
  -- {
  --   "folke/noice.nvim",
  --   event = "VeryLazy",
  --   opts = {
  --     -- add any options here
  --   },
  --   dependencies = {
  --     -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
  --     "MunifTanjim/nui.nvim",
  --     -- OPTIONAL:
  --     --   `nvim-notify` is only needed, if you want to use the notification view.
  --     --   If not available, we use `mini` as the fallback
  --     "rcarriga/nvim-notify",
  --   }
  -- },
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
      'nvim-tree/nvim-web-devicons'
    },
    {
      'Shatur/neovim-ayu'
    },
  },
  {
    "phaazon/hop.nvim",
    event = "BufRead",
    config = function()
      require("hop").setup()
      vim.api.nvim_set_keymap("n", "s", ":HopChar1MW<cr>", { silent = true })
      vim.api.nvim_set_keymap("n", "S", ":HopWord<cr>", { silent = true })
      vim.api.nvim_set_keymap("n", "9", ":IvanSnipeCopyWord<cr>", { silent = true })
      vim.api.nvim_set_keymap("n", "<leader>9", ":IvanSnipeCopyWholeWord<cr>", { silent = true })
      vim.api.nvim_set_keymap("n", "<leader>0", ":IvanSnipeCopyLine<cr>", { silent = true })
    end,
  },
  { 'nvim-telescope/telescope-dap.nvim' },
  {
    'nvim-pack/nvim-spectre',
    dependencies = {
      'nvim-lua/plenary.nvim'
    },
  },
  {'stevearc/oil.nvim'},
  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },
  },

  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',

      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',
    },
  },

  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim', opts = {} },
  -- {
  --   -- Adds git related signs to the gutter, as well as utilities for managing changes
  --   'lewis6991/gitsigns.nvim',
  --   opts = {
  --     -- See `:help gitsigns.txt`
  --     signs = {
  --       add = { text = '+' },
  --       change = { text = '~' },
  --       delete = { text = '_' },
  --       topdelete = { text = '‾' },
  --       changedelete = { text = '~' },
  --     },
  --     on_attach = function(bufnr)
  --       vim.keymap.set('n', '<leader>hp', require('gitsigns').preview_hunk, { buffer = bufnr, desc = 'Preview git hunk' })
  --
  --       -- don't override the built-in and fugitive keymaps
  --       local gs = package.loaded.gitsigns
  --       vim.keymap.set({ 'n', 'v' }, ']c', function()
  --         if vim.wo.diff then
  --           return ']c'
  --         end
  --         vim.schedule(function()
  --           gs.next_hunk()
  --         end)
  --         return '<Ignore>'
  --       end, { expr = true, buffer = bufnr, desc = 'Jump to next hunk' })
  --       vim.keymap.set({ 'n', 'v' }, '[c', function()
  --         if vim.wo.diff then
  --           return '[c'
  --         end
  --         vim.schedule(function()
  --           gs.prev_hunk()
  --         end)
  --         return '<Ignore>'
  --       end, { expr = true, buffer = bufnr, desc = 'Jump to previous hunk' })
  --     end,
  --   },
  -- },
  --
   -- {
   --   -- Theme inspired by Atom
   --   'navarasu/onedark.nvim',
   --   priority = 1000,
   --   config = function()
   --     vim.cmd.colorscheme 'onedark'
   --   end,
   -- },

  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = false,
        theme = 'ayu',
        component_separators = '|',
        section_separators = '',
      },
    },
  },

  -- {
  --   -- Add indentation guides even on blank lines
  --   'lukas-reineke/indent-blankline.nvim',
  --   -- Enable `lukas-reineke/indent-blankline.nvim`
  --   -- See `:help ibl`
  --   main = 'ibl',
  --   opts = {},
  -- },
  --
  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      -- Fuzzy Finder Algorithm which requires local dependencies to be built.
      -- Only load if `make` is available. Make sure you have the system
      -- requirements installed.
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        -- NOTE: If you are having trouble with this installation,
        --       refer to the README for telescope-fzf-native for more instructions.
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
  },

  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "theHamsta/nvim-dap-virtual-text",
      "rcarriga/nvim-dap-ui",
      "leoluz/nvim-dap-go"
    },
  },

  -- NEO TREE
  -- {
  --   "nvim-neo-tree/neo-tree.nvim",
  --   version = "*",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
  --     "MunifTanjim/nui.nvim",
  --   },
  --   config = function ()
  --     require('neo-tree').setup {
  --     }
  --   end,
  -- },
  { "anuvyklack/windows.nvim",
    dependencies = {
      "anuvyklack/middleclass",
      "anuvyklack/animation.nvim"
    },
    config = function()
      vim.o.winwidth = 10
      vim.o.winminwidth = 10
      vim.o.equalalways = false
      require('windows').setup({
        duration = 300,
        autowidth = {
          enable = false,
          winwidth = 5,
          filetype = {
            help = 2,
          },
        },

      })
    end
  },

{'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons',
  config = function ()
      require('bufferline').setup {}
    end,
},
{ 'rktjmp/lush.nvim' },




vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

  -- NOTE: Next Step on Your Neovim Journey: Add/Configure additional "plugins" for kickstart
  --
  --       These are some example plugins that I've included in the kickstart repository.
  --       Uncomment any of the lines below to enable them.
  -- require 'kickstart.plugins.autoformat',
  -- require 'kickstart.plugins.debug',

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    You can use this folder to prevent any conflicts with this init.lua if you're interested in keeping
  --    up-to-date with whatever is in the kickstart repo.
  --    Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  --
  --    For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
  -- { import = 'custom.plugins' },
}, {})
-- Keymaps for better default experience
-- See `:help vim.keymap.set()`


require("settings")
-- NVIM WEB DEVICONS
require("nvim-web-devicons").setup({
  -- Exclude Git-related icons
  global_exclude = {
    ".*%.git.*",
    ".*%.gitignore.*",
    ".*%.gitmodules.*",
    ".*%.gitattributes.*",
  },
})

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true


-- vim.g.nvim_tree_show_icons = {
--   git = 0,
-- }

-- vim.g.nvim_tree_icons = {
--   default = '',
-- }
--
--
--


 -- vim.keymap.set('n', '<C-l>', "<C-w>2> ", { desc = 'Resize to left' })
 --  vim.keymap.set('n', '<C-h>', "<C-w>2<", { desc = 'Resize to right' })
 --  vim.keymap.set('n', '<C-k>', "<C-w>2+", { desc = 'Resize to up' })
 --  vim.keymap.set('n', '<C-j>', "<C-w>2-", { desc = 'Resize to down' })
 --
-- NVIM TREE
require("nvim-tree").setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 20,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
  git = {
    enable = false,
  }
})

vim.keymap.set('n', '<C-h>', "<C-w>2< ", { desc = 'Resize to left' })
vim.keymap.set('n', '<C-l>', "<C-w>2>", { desc = 'Resize to right' })
vim.keymap.set('n', '<C-k>', "<C-w>2+", { desc = 'Resize to up' })
vim.keymap.set('n', '<C-j>', "<C-w>2-", { desc = 'Resize to down' })

vim.keymap.set('n', '<M-b>', ":NvimTreeToggle<cr>", {})
vim.keymap.set('n', '<C-n>', ":NvimTreeResize -1 <cr>", {})
vim.keymap.set('n', '<C-m>', ":NvimTreeResize +1 <cr>", {})

vim.api.nvim_create_user_command('IvanSnipeCopyWord',
function()
  vim.cmd.HopChar1MW()
  vim.cmd('normal! yiw')
  vim.cmd.execute [["normal \<c-o>"]]
end, {}
)

vim.api.nvim_create_user_command('IvanSnipeCopyWholeWord',
function()
  vim.cmd.HopChar1MW()
  vim.cmd('normal! yiW')
  vim.cmd.execute [["normal \<c-o>"]]
end, {}
)

vim.api.nvim_create_user_command('IvanSnipeCopyLine',
function()
  vim.cmd.HopLine()
  vim.cmd('normal! yy')
  vim.cmd.execute [["normal \<c-o>"]]
end, {}
)


require("oil-nvim")
--require("noice-nvim")

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })


vim.keymap.set('n', '<leader>1', ":only<CR>", {})
vim.keymap.set('n', '<leader>2', ":sp<CR><C-w>w", {})
vim.keymap.set('n', '<leader>3', ":vsp<CR><C-w>w", {})
vim.keymap.set('n', '<leader>4', "<C-w>=", {})



vim.keymap.set('n', '<M-n>', ":bprevious<CR>", { desc = 'goto previous buffer' })
vim.keymap.set('n', '<M-p>', ":bnext<CR>", { desc = 'goto next buffer' })


vim.keymap.set('n', '<M-h>', ":wincmd h<CR>", {})
vim.keymap.set('n', '<M-j>', ":wincmd j<CR>", {})
vim.keymap.set('n', '<M-k>', ":wincmd k<CR>", {})
vim.keymap.set('n', '<M-l>', ":wincmd l<CR>", {})

vim.keymap.set('n', '<M-q>', ":q!<CR>", {})
vim.keymap.set('n', '<M-w>', ":w!<CR>", {})

vim.keymap.set('n', '<M-.>', "<C-d>", {})
vim.keymap.set('n', '<M-,>', "<C-u>", {})

vim.keymap.set('n', '<M-o>', "<C-o>", {})
vim.keymap.set('n', '<M-i>', "<C-u>", {})

vim.keymap.set('n', '<leader>j', ':Oil<CR>', {})
vim.keymap.set('n', '<leader>k', ':bd<CR>', {})

vim.keymap.set('n', '<M-f>', ':WindowsMaximize<CR>', {})

vim.keymap.set('n', '<leader>bn', ':enew<CR>', {})
vim.keymap.set('n', '<leader>bd', ':bd<CR>', {})

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

vim.keymap.set('n', '<leader>fc', ":cd %:p:h<CR>", { desc = 'cd int current file directory' })



-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- Telescope live_grep in git root
-- Function to find the git root directory based on the current buffer's path
local function find_git_root()
  -- Use the current buffer's path as the starting point for the git search
  local current_file = vim.api.nvim_buf_get_name(0)
  local current_dir
  local cwd = vim.fn.getcwd()
  -- If the buffer is not associated with a file, return nil
  if current_file == "" then
    current_dir = cwd
  else
    -- Extract the directory from the current file's path
    current_dir = vim.fn.fnamemodify(current_file, ":h")
  end

  -- Find the Git root directory from the current file's path
  local git_root = vim.fn.systemlist("git -C " .. vim.fn.escape(current_dir, " ") .. " rev-parse --show-toplevel")[1]
  if vim.v.shell_error ~= 0 then
    print("Not a git repository. Searching on current working directory")
    return cwd
  end
  return git_root
end

-- Custom live_grep function to search in git root
local function live_grep_git_root()
  local git_root = find_git_root()
  if git_root then
    require('telescope.builtin').live_grep({
      search_dirs = {git_root},
    })
  end
end

vim.api.nvim_create_user_command('LiveGrepGitRoot', live_grep_git_root, {})

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>ir', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader>if', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

vim.keymap.set('n', '<leader>iw', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>ie', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>iE', ":IvanFindFileFromHome<CR>", { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>ih', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>is', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>ia', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>iA', ':LiveGrepGitRoot<cr>', { desc = '[S]earch by [G]rep on Git Root' })
vim.keymap.set('n', '<leader>id', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>ic', require('telescope.builtin').commands, { desc = '[S]earch [C]ommands' })
vim.keymap.set('n', '<leader>im', require('telescope.builtin').man_pages, { desc = '[S]earch [C]ommands' })
vim.keymap.set('n', '<leader>iq', require('telescope.builtin').registers, { desc = '[S]earch [R]egisters' })
vim.keymap.set('n', '<leader>gs', require('telescope.builtin').git_status, { desc = '[S]earch [R]egisters' })
vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })

vim.keymap.set('n', '<leader>ws', "<C-w>x", { desc = '[S]wap Windows' })



-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
-- Defer Treesitter setup after first render to improve startup time of 'nvim {filename}'
vim.defer_fn(function()
  require('nvim-treesitter.configs').setup {
    -- Add languages to be installed here that you want installed for treesitter
    ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'javascript', 'typescript', 'vimdoc', 'vim', 'bash' },

    -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
    auto_install = false,

    highlight = { enable = true },
    indent = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<c-space>',
        node_incremental = '<c-space>',
        scope_incremental = '<c-s>',
        node_decremental = '<M-space>',
      },
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ['aa'] = '@parameter.outer',
          ['ia'] = '@parameter.inner',
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['ac'] = '@class.outer',
          ['ic'] = '@class.inner',
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          [']m'] = '@function.outer',
          [']]'] = '@class.outer',
        },
        goto_next_end = {
          [']M'] = '@function.outer',
          [']['] = '@class.outer',
        },
        goto_previous_start = {
          ['[m'] = '@function.outer',
          ['[['] = '@class.outer',
        },
        goto_previous_end = {
          ['[M'] = '@function.outer',
          ['[]'] = '@class.outer',
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ['<leader>a'] = '@parameter.inner',
        },
        swap_previous = {
          ['<leader>A'] = '@parameter.inner',
        },
      },
    },
  }
end, 0)

-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  --
  -- vim.api.nvim_buf_set_option(bufnr, 'show_virtual_text', false)
  -- if _.name == 'mason' then
  --   -- Disable virtual text for Mason language server
  --   _.resolved_capabilities.show_virtual_text = false
  -- end


  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>lr', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>la', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

  nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
  nmap('<leader>ls', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>lS', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
-- nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

-- DAP UI
--require("dapui").setup()
vim.api.nvim_set_keymap("n", "<leader>di", ":lua require('dapui').toggle()<CR>", { noremap = true, silent = true })

local custom_layout = {
  {
    relative = "editor",
    style = "minimal",
    height = 15,
    width = 120,
    row = 0,
    col = 0,
  },
}

-- DAP TELESCOPE
require('telescope').load_extension('dap')

vim.keymap.set('n', '<leader>dc', ":lua require'telescope'.extensions.dap.commands{}<cr>", {})
vim.keymap.set('n', '<leader>df', ":lua require'telescope'.extensions.dap.frames{}<cr>", {})
vim.keymap.set('n', '<leader>db', ":lua require'telescope'.extensions.dap.list_breakpoints{}<cr>", {})

 require("dapui").setup(
{
    controls = {
      element = "repl",
      enabled = true,
      icons = {
        disconnect = "",
        pause = "",
        play = "",
        run_last = "",
        step_back = "",
        step_into = "",
        step_out = "",
        step_over = "",
        terminate = ""
      }
    },
    element_mappings = {},
    expand_lines = true,
    floating = {
      border = "single",
      mappings = {
        close = { "q", "<Esc>" }
      }
    },
    force_buffers = true,
    icons = {
      collapsed = "",
      current_frame = "",
      expanded = ""
    },
    layouts = { {
        elements = { {
            id = "scopes",
            size = 1 
          },
          -- {
          --   id = "breakpoints",
          --   size = 0.25
          -- }, {
          --   id = "stacks",
          --   size = 0.25
          -- }, {
          --   id = "watches",
          --   size = 0.25
          -- }
        },
        position = "bottom",
        size = 10
      },
       {
         elements = {
           {
           id = "stacks",
           size = 1 
         },
           --   id = "repl",
           --   size = 0.5
           -- }, {
           --   id = "console",
           --   size = 0.5
            },
         position = "right",
         size = 60
       }
    },
    mappings = {
      edit = "e",
      -- expand = { "<CR>", "<2-LeftMouse>" },
      expand = { "<CR>", "<LeftRelease>", "<TAB>" },
      open = "o",
      remove = "d",
      repl = "r",
      toggle = "t"
    },
    render = {
      indent = 1,
      max_value_lines = 100
    }
 })

require("dap").adapters.lldb = {
	type = "executable",
	command = "/usr/bin/lldb-vscode", -- adjust as needed
	name = "lldb",
}

local lldb = {
	name = "Launch lldb",
	type = "lldb", -- matches the adapter
	request = "launch", -- could also attach to a currently running process
	program = function()
		return vim.fn.input(
			"Path to executable: ",
			vim.fn.getcwd() .. "/",
			"file"
		)
	end,
	cwd = "${workspaceFolder}",
	stopOnEntry = false,
	args = {},
	runInTerminal = false,
}

-- require("dapui").setup({
--   icons = { expanded = "▾", collapsed = "▸" },
--   mappings = {
--     -- You can customize key mappings here
--   },
--   sidebar = {
--     open_on_start = true,
--     elements = {
--       -- Configure only the locals window
--       { id = "scopes", size = 0.25 },
--     },
--     width = 30,
--   },
--   tray = {
--     open_on_start = true,
--     elements = { "repl" },
--     size = 10,
--   },
--   floating = { max_height = nil, max_width = nil },
--   windows = custom_layout,
-- })
--
-- DAP VIRTUAL TEXT
require("nvim-dap-virtual-text").setup {
    enabled = true,                        -- enable this plugin (the default)
    enabled_commands = true,               -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
    highlight_changed_variables = true,    -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
    highlight_new_as_changed = false,      -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
    show_stop_reason = true,               -- show stop reason when stopped for exceptions
    commented = true,                     -- prefix virtual text with comment string
    only_first_definition = true,          -- only show virtual text at first definition (if there are multiple)
    all_references = false,                -- show virtual text on all all references of the variable (not only definitions)
    clear_on_continue = false,             -- clear virtual text on "continue" (might cause flickering when stepping)
    --- A callback that determines how a variable is displayed or whether it should be omitted
    --- @param variable Variable https://microsoft.github.io/debug-adapter-protocol/specification#Types_Variable
    --- @param buf number
    --- @param stackframe dap.StackFrame https://microsoft.github.io/debug-adapter-protocol/specification#Types_StackFrame
    --- @param node userdata tree-sitter node identified as variable definition of reference (see `:h tsnode`)
    --- @param options nvim_dap_virtual_text_options Current options for nvim-dap-virtual-text
    --- @return string|nil A text how the virtual text should be displayed or nil, if this variable shouldn't be displayed
    display_callback = function(variable, buf, stackframe, node, options)
      if options.virt_text_pos == 'inline' then
        return ' = ' .. variable.value
      else
        return variable.name .. ' = ' .. variable.value
      end
    end,
    -- position of virtual text, see `:h nvim_buf_set_extmark()`, default tries to inline the virtual text. Use 'eol' to set to end of line
    virt_text_pos = vim.fn.has 'nvim-0.10' == 1 and 'inline' or 'eol',

    -- experimental features:
    all_frames = false,                    -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
    virt_lines = false,                    -- show virtual lines instead of virtual text (will flicker!)
    virt_text_win_col = nil                -- position the virtual text at a fixed window column (starting from the first text column) ,
                                           -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
}

-- DAP GO
require('dap-go').setup {
  -- Additional dap configurations can be added.
  -- dap_configurations accepts a list of tables where each entry
  -- represents a dap configuration. For more details do:
  -- :help dap-configuration
  dap_configurations = {
    {
      -- Must be "go" or it will be ignored by the plugin
      type = "go",
      name = "Attach remote",
      mode = "remote",
      request = "attach",
    },
  },
  -- delve configurations
  delve = {
    -- the path to the executable dlv which will be used for debugging.
    -- by default, this is the "dlv" executable on your PATH.
    path = "dlv",
    -- time to wait for delve to initialize the debug session.
    -- default to 20 seconds
    initialize_timeout_sec = 20,
    -- a string that defines the port to start delve debugger.
    -- default to string "${port}" which instructs nvim-dap
    -- to start the process in a random available port
    port = "${port}",
    -- additional args to pass to dlv
    args = {},
    -- the build flags that are passed to delve.
    -- defaults to empty string, but can be used to provide flags
    -- such as "-tags=unit" to make sure the test suite is
    -- compiled during debugging, for example.
    -- passing build flags using args is ineffective, as those are
    -- ignored by delve in dap mode.
    build_flags = "",
  },
}

vim.keymap.set('n', '<M-]>', ":DapToggleBreakpoint <cr>", {})
vim.keymap.set('n', '<M-9>', ":DapStepOut <cr>", {})
vim.keymap.set('n', '<M-0>', ":DapStepOver <cr>", {})
vim.keymap.set('n', '<M-->', ":DapStepIn <cr>", {})
vim.keymap.set('n', '<M-=>', ":DapContinue <cr>", {})
vim.keymap.set('n', '<M-+>', ":DapTerminate <cr>", {})

-- document existing key chains
require('which-key').register {
  ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
  ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
  ['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore' },
  ['<leader>h'] = { name = 'More git', _ = 'which_key_ignore' },
  ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
  ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
  ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
  ['<leader>l'] = { name = '[L]SP', _ = 'which_key_ignore' },
}

-- mason-lspconfig requires that these setup functions are called in this order
-- before setting up the servers.
require('mason').setup()
require('mason-lspconfig').setup()

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
--
--  If you want to override the default filetypes that your language server will attach to you can
--  define the property 'filetypes' to the map in question.
--


local servers = {
   clangd = {},
   gopls = {},
   pyright = {},
   rust_analyzer = {},
  -- tsserver = {},
  -- html = { filetypes = { 'html', 'twig', 'hbs'} },

  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
      -- NOTE: toggle below to ignore Lua_LS's noisy `missing-fields` warnings
      -- diagnostics = { disable = { 'missing-fields' } },
    },
  },
}

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
      filetypes = (servers[server_name] or {}).filetypes,
    }
  end,
}

-- [[ Configure nvim-cmp ]]
-- See `:help cmp`
local cmp = require 'cmp'
local luasnip = require 'luasnip'
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  completion = {
    completeopt = 'menu,menuone,noinsert'
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<Tab>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    },
    -- ['<CR>'] = cmp.mapping.confirm {
    --   behavior = cmp.ConfirmBehavior.Replace,
    --   select = false,
    -- },
    -- ['<Tab>'] = cmp.mapping(function(fallback)
    --   if cmp.visible() then
    --     cmp.select_next_item()
    --   elseif luasnip.expand_or_locally_jumpable() then
    --     luasnip.expand_or_jump()
    --   else
    --     fallback()
    --   end
    -- end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}






vim.api.nvim_create_user_command('IvanFindFileFromHome',
function()
  require('telescope.builtin').find_files({
      prompt_title = 'Find Files',
      cwd = vim.fn.expand('$HOME'),
      no_ignore = true,
      hidden = true
  })
  -- vim.cmd.HopLine()
  -- vim.cmd('normal! yy')
  -- vim.cmd.execute [["normal \<c-o>"]]
end, {}
)


-- vim.diagnostic.config({
--   virtual_text = false,
-- })
-- VIMM
-- vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
--   pattern = {"*.lua"},
--   command = "echo 'Entering a C or C++ file'",
-- })
-- LUA
--
--  vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
--   pattern = {"*.lua"},
--   callback = function()
--     for i=1,10 do print(i) end
--   end,
-- })
