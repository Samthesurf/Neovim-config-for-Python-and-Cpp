vim.o.splitbelow = true
vim.o.splitright = true
vim.o.incsearch = true
vim.api.nvim_set_var('mapleader', ' ')
vim.api.nvim_set_keymap('t','<Esc>','<C-\\><C-n>',{noremap = true})
vim.o.completeopt = "menuone,noselect"
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim" 
if not vim.loop.fs_stat(lazypath) then 
vim.fn.system({ "git",
 "clone", 
"--filter=blob:none", 
"https://github.com/folke/lazy.nvim.git", 
"--branch=stable", 
-- latest stable release 
lazypath,} )
end
vim.opt.rtp:prepend(lazypath)
local powershell_options = {
  shell = vim.fn.executable "pwsh.exe -NoLogo" == 1 and "pwsh.exe -NoLogo" or "powershell.exe -NoLogo",
  shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;",
  shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait",
  shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode",
  shellquote = "",
  shellxquote = "",
}

for option, value in pairs(powershell_options) do
  vim.opt[option] = value
end

require("lazy").setup{
{
--"LunarVim/lvim-themes",

},{
{ 'nvim-telescope/telescope.nvim',
tag = '0.1.2', -- or , 
branch = '0.1.x',
dependencies = { 'nvim-lua/plenary.nvim' },

 }
},{
"nvim-treesitter/nvim-treesitter",
run = ':TSUpdate'

},{
"sharkdp/fd"
},{
"nvim-tree/nvim-web-devicons"
},{
"BurntSushi/ripgrep"
},{
"folke/tokyonight.nvim",
lazy = false,
priority = 1000,
opts = {},
},{
"williamboman/mason.nvim"
},{
"neovim/nvim-lspconfig"
},{
"folke/trouble.nvim"
},
{
"mfussenegger/nvim-lint"
},{
"akinsho/toggleterm.nvim",version = "*", config = true
},
{
"nvim-tree/nvim-tree.lua", version = "*", lazy = false,dependencies = {
"nvim-tree/nvim-web-devicons"
},
{
"folke/which-key.nvim"
},
{
"folke/flash.nvim",
event = "VeryLazy",
 ---@type Flash.Config
 opts = {},
 -- stylua: ignore
 keys = {
 { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
 { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
 { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" }, 
{ "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" }, { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
},{
"akinsho/bufferline.nvim",version = "*", dependencies = "nvim-tree/nvim-web-devicons"
},{
"williamboman/mason-lspconfig.nvim"
},{
-- "windwp/windline.nvim"
},{
"lewis6991/gitsigns.nvim"
},{
--"neoclide/coc.nvim", branch = 'release',
},{
"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-nvim-lua",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"saadparwaiz1/cmp_luasnip",
		"L3MON4D3/LuaSnip",
}
}, {
"CRAG666/code_runner.nvim", config= true,
},{
"CRAG666/betterTerm.nvim"
},{
  -- 'tpope/vim-fugitive'
},{
  'windwp/nvim-autopairs', event = "InsertEnter",opts = {}
},{
  'nvim-treesitter/nvim-treesitter-context'
},{
  'numToStr/Comment.nvim', opts={}, lazy = false
},{
  'nvim-lualine/lualine.nvim', requires = {'nvim-tree/nvim-web-devicons'}, opt = true
},{
  'arkav/lualine-lsp-progress'
},{
  'dinhhuy258/git.nvim'
},{
  'RRethy/vim-illuminate'
},{
  "junegunn/fzf"
},{
'mfussenegger/nvim-dap'
},{
  'mfussenegger/nvim-dap-python'
},{ 'goolord/alpha-nvim', dependencies = { 'nvim-tree/nvim-web-devicons' }, 
config = function () 
	require'alpha'.setup(require'alpha.themes.startify'.config)
end },{
'onsails/lspkind.nvim'
}
}}

}require("nvim-treesitter").setup{}
require("telescope").setup{}
require("mason").setup{}
require("mason-lspconfig").setup{}
require('lualine').setup{sections = {lualine_c = {'lsp-progress'}}}
require('gitsigns').setup{}
--require('wlsample.evil_line')
require('treesitter-context').setup{}
require('nvim-autopairs').setup{}
require('Comment').setup{}
require('git').setup{}
--require("fzf").setup{}
require('dap-python').setup('~/AppData/Local/nvim-data/mason/packages/debugpy/venv/Scripts/python.exe')
--which-key
require('which-key').setup {
  plugins = {
    spelling = { enabled = true },
    marks = { enabled = true },
    registers = { enabled = true },
    presets = {
      operators = true,
      motions = true,
      text_objects = true,
      windows = true,
      nav = true,
      z = true,
      g = true
    }
  }
}

require('lint').linters_by_ft = {
python = {'ruff'}
}
-- Enable powershell as your default shell
-- vim.opt.shell = "pwsh.exe -NoLogo"
-- vim.opt.shellcmdflag =
--   "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
-- vim.cmd [[
-- 		let &shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
-- 		let &shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
-- 		set shellquote= shellxquote=
--   ]]
require("toggleterm").setup{}
require("code_runner").setup{}
require("betterTerm").setup{
  vim.cmd([[
  augroup toggleterm
    autocmd!
    autocmd TermOpen * call settabvar(1, 'toggleterm_directory', expand('%:p:h'))
  augroup END
]])
}
local lspkind = require('lspkind')
cmp.setup {
	formatting = {
	format = lspkind.cmp_format({
	mode = 'symbol',-- show only symbol annotations 
	maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters) 
	ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first) 
	-- The function below will be called before any actual modifications from lspkind 
	-- -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30)) 
	before = function (entry, vim_item) 
	... 
	return vim_item 
	end 
}) } }
--require('fugitive').setup{}

-- Define the key mappings
vim.api.nvim_set_keymap('n', '<A-1>', ':ToggleTerm direction=horizontal<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A-2>', ':ToggleTerm direction=vertical<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A-3>', ':ToggleTerm direction=float<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-s>', '<Esc>:w<CR>',{noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-s>', ':w<CR>',{noremap = true, silent = true })
vim.api.nvim_set_keymap('i', ';q', ':q<CR>',{noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-2>', '<Esc>:bn<CR>',{noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-2>', ':bn<CR>',{noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-1>', '<Esc>:bp<CR>',{noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-1>', ':bp<CR>',{noremap = true, silent = true })


--Running code lol
vim.cmd([[
augroup exe_code
    autocmd!
    autocmd FileType python noremap <buffer> <F5>
    	\ :sp<CR> :term py %<CR> i
    autocmd FileType cpp noremap <buffer> <F5>
    \ :sp<CR> :term g++ % -o %:r; ./%:r<CR> i
    autocmd FileType c noremap <buffer> <F5>
    \ :sp<CR> :term gcc % -o %:r; ./%:r<CR> i
augroup END
]])
require("nvim-tree").setup {}
  

--require("evil_lualine.evil_lualine")
vim.o.mouse = "a"
vim.opt.number = true
vim.cmd[[colorscheme tokyonight]]
vim.opt.termguicolors = true
require("bufferline").setup{}


-- Languages

require'lspconfig'.pyright.setup{}

require'lspconfig'.ruff_lsp.setup{
  cmd = {'ruff-lsp.cmd'}
}
local nvim_lsp = require('lspconfig')
nvim_lsp.cpptools.setup{
  cmd = { "OpenDebugAD7.cmd", "--background-index" },
  filetypes = { "c", "cpp" },
  root_dir = require'lspconfig'.util.root_pattern(".git", "compile_commands.json"),
  -- init_options = {
  --   clangdFileStatus = true,
  --   usePlaceholders = true,
  --   completeUnimported = true,
  --   semanticHighlighting = true
  -- }
}
require('lspconfig').ccls.setup{
	cmd = {"ccls"}
}
local cmp1 = require('cmp')
cmp1.setup({sources = {name = 'nvim_lsp'}})
 require("lspconfig").lua_ls.setup{
  cmd = {"lua-language-server.cmd" or "sunmeko.lua"}
}
-- C:\Users\ukpsa\AppData\Roaming\lunarvim\lvim\lua\lvim\plugins.lua to install stuff
-- Neovim config for PowerShell Editor Services
require'lspconfig'.powershell.setup{
  cmd = { "pwsh", "-NoLogo", "-NoProfile", "-NonInteractive", "-ExecutionPolicy", "Bypass", "-Command", "EditorServices.StartEditorServices()" },
  filetypes = { "powershell" },
}
-- Configure gopls
require("lspconfig").gopls.setup{
  cmd = {"gopls", "serve"},
  filetypes = {"go"},
}

vim.api.nvim_set_keymap('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A-r>', ':RunCode<CR>', {noremap = true, silent = true })

--nvim-cmp
config = function()
	local cmp = require("cmp")
	vim.opt.completeopt = { "menu", "menuone", "noselect" }

	cmp.setup({
		snippet = {
			expand = function(args)
				require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
			end,
		},
		window = {
			-- completion = cmp.config.window.bordered(),
			-- documentation = cmp.config.window.bordered(),
		},
		mapping = cmp.mapping.preset.insert({
			["<C-b>"] = cmp.mapping.scroll_docs(-4),
			["<C-f>"] = cmp.mapping.scroll_docs(4),
			["<C-Space>"] = cmp.mapping.complete(),
			["<C-e>"] = cmp.mapping.abort(),
			["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		}),
		sources = cmp.config.sources({
			{ name = "nvim_lsp" },
			{ name = "nvim_lua" },
			{ name = "luasnip" }, -- For luasnip users.
			-- { name = "orgmode" },
		}, {
			{ name = "buffer" },
			{ name = "path" },
		}),
	})

	cmp.setup.cmdline(":", {
		mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources({
			{ name = "path" },
		}, {
			{ name = "cmdline" },
		}),
	})
end
vim.keymap.set("n", "<leader>xx", function() require("trouble").open() end) 
vim.keymap.set("n", "<leader>xw", function() require("trouble").open("workspace_diagnostics") end) 
vim.keymap.set("n", "<leader>xd", function() require("trouble").open("document_diagnostics") end) 
vim.keymap.set("n", "<leader>xq", function() require("trouble").open("quickfix") end) 
vim.keymap.set("n", "<leader>xl", function() require("trouble").open("loclist") end) 
vim.keymap.set("n", "gR", function() require("trouble").open("lsp_references") end)


--coc.nvim
--require("coc.nvim").setup{}

