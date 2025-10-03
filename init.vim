" ===========================
" init.vim
" ===========================

call plug#begin('~/.local/share/nvim/plugged')

" Plugins
" Status Line
Plug 'nvim-lualine/lualine.nvim'
" File Explorer
Plug 'nvim-tree/nvim-tree.lua'
" Icons
Plug 'nvim-tree/nvim-web-devicons'
" Highlighter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
" Themes
Plug 'navarasu/onedark.nvim'
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }

call plug#end()

" ===========================
" Settings
" ===========================

" Enable line numbers and relative line numbers
set number
set relativenumber

" Enable syntax highlighting
syntax on

" Better searching
set ignorecase
set smartcase

" Tabs & indentation
set tabstop=4
set shiftwidth=4
set expandtab
set smartindent

" Enable mouse
set mouse=a

" ===========================
" Colorscheme
" ===========================
colorscheme onedark 

" ===========================
" Treesitter setup (Lua block)
" ===========================
lua << EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "cpp", "lua", "python" },
  highlight = {
    enable = true, 
    additional_vim_regex_highlighting = false,
  },
}
EOF

" ===========================
" Lualine setup (Lua block)
" ===========================
lua << EOF
require('lualine').setup {
  options = {
    theme = 'auto'
  }
}
EOF

" ===========================
" Nvim Tree 
" ===========================
lua << EOF
require("nvim-tree").setup()
vim.api.nvim_set_keymap('n', '<C-b>', ':NvimTreeOpen<CR>', { noremap = true, silent = true })
EOF

" ===========================
" LspConfig Setup
" ===========================
lua << EOF
local cmp = require'cmp'

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
    { name = 'path' }
  })
})
EOF

" =============================
" Pyright && Clangd
" =============================
lua << EOF
local capabilities = require('cmp_nvim_lsp').default_capabilities()
vim.lsp.enable('pyright', { capabilities = capabilities })
vim.lsp.enable('clangd', { capabilities = capabilities })
EOF
