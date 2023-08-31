vim.o.splitbelow = true
vim.o.splitright = true
vim.o.incsearch = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.cmd[[set guifont="Jetbrainsmononl Nerd Font"\Code:h11]]
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
{ 'nvim-telescope/telescope.nvim',
tag = '0.1.2', -- or , 
branch = '0.1.x',
dependencies = { 'nvim-lua/plenary.nvim' },

 }
, {
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
--"mfussenegger/nvim-lint"
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
		"rafamadriz/friendly-snippets"
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
},{
 'jose-elias-alvarez/null-ls.nvim'
},{
	'rcarriga/nvim-dap-ui'
},{
	'folke/neodev.nvim', opts = {}
},{
	"folke/persistence.nvim",
	event = "BufReadPre", -- this will only start session saving when an actual file was opened
	opts = {
	  -- add any custom options here
	}
  },{
"JoosepAlviste/nvim-ts-context-commentstring"
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
require('Comment').setup{
    pre_hook = function(ctx)
    local U = require "Comment.utils"

    local status_utils_ok, utils = pcall(require, "ts_context_commentstring.utils")
    if not status_utils_ok then
      return
    end

    local location = nil
    if ctx.ctype == U.ctype.block then
      location = utils.get_cursor_location()
    elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
      location = utils.get_visual_start_location()
    end

    local status_internals_ok, internals = pcall(require, "ts_context_commentstring.internals")
    if not status_internals_ok then
      return
    end

    return internals.calculate_commentstring {
      key = ctx.ctype == U.ctype.line and "__default" or "__multiline",
      location = location,}
    end
    }


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

local null_ls = require("null-ls")

null_ls.setup({
	sources = {
		 null_ls.builtins.diagnostics.ruff,
		 null_ls.builtins.diagnostics.cpplint,
	}
})
require("neodev").setup({
	library = { plugins = {"nvim-dap-ui"}, types = true},
})
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
-- cmp.setup {
-- 	formatting = {
-- 	format = lspkind.cmp_format({
-- 	mode = 'symbol',-- show only symbol annotations 
-- 	maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters) 
-- 	ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first) 
-- 	-- The function below will be called before any actual modifications from lspkind 
-- 	-- -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30)) 
-- 	before = function (entry, vim_item)
-- 	return vim_item
-- 	end
-- }) } }
--require('fugitive').setup{}

-- Define the key mappings
vim.api.nvim_set_keymap('n', '<A-1>', ':ToggleTerm direction=horizontal<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A-2>', ':ToggleTerm direction=vertical<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A-3>', ':ToggleTerm direction=float<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-s>', '<Esc>:w<CR>',{noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-s>', ':w<CR>',{noremap = true, silent = true })
vim.api.nvim_set_keymap('i', ';q', ':q<CR>',{noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-2>', '<Esc>:bnext<CR>',{noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-2>', ':bnext<CR>',{noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-1>', '<Esc>:bprevious<CR>',{noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-1>', ':bprevious<CR>',{noremap = true, silent = true })


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
-- nvim_lsp.cpptools.setup{
--   cmd = { "OpenDebugAD7.cmd", "--background-index" },
--   filetypes = { "c", "cpp" },
--   root_dir = require'lspconfig'.util.root_pattern(".git", "compile_commands.json"),
--   -- init_options = {
--   --   clangdFileStatus = true,
--   --   usePlaceholders = true,
--   --   completeUnimported = true,
--   --   semanticHighlighting = true
--   -- }
--}
-- require('lspconfig').ccls.setup{
-- 	cmd = {"ccls"}
-- }
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
local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
  return
end

require("luasnip/loaders/from_vscode").lazy_load()

local check_backspace = function()
  local col = vim.fn.col "." - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end

local kind_icons = {
  Text = "󰉿",
	Method = "󰆧",
	Function = "󰊕",
	Constructor = "",
  Field = " ",
	Variable = "󰀫",
	Class = "󰠱",
	Interface = "",
	Module = "",
	Property = "󰜢",
	Unit = "󰑭",
	Value = "󰎠",
	Enum = "",
	Keyword = "󰌋",
  Snippet = "",
	Color = "󰏘",
	File = "󰈙",
  Reference = "",
	Folder = "󰉋",
	EnumMember = "",
	Constant = "󰏿",
  Struct = "",
	Event = "",
	Operator = "󰆕",
  TypeParameter = " ",
	Misc = " ",
}
-- find more here: https://www.nerdfonts.com/cheat-sheet

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  mapping = {
    ["<C-k>"] = cmp.mapping.select_prev_item(),
		["<C-j>"] = cmp.mapping.select_next_item(),
    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ["<C-e>"] = cmp.mapping {
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    },
    -- Accept currently selected item. If none selected, `select` first item.
    -- Set `select` to `false` to only confirm explicitly selected items.
    ["<CR>"] = cmp.mapping.confirm { select = true },
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expandable() then
        luasnip.expand()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif check_backspace() then
        fallback()
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
  },
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(entry, vim_item)
      -- Kind icons
      vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
      -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
      vim_item.menu = ({
        nvim_lsp = "[LSP]",
        luasnip = "[Snippet]",
        buffer = "[Buffer]",
        path = "[Path]",
      })[entry.source.name]
      return vim_item
    end,
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
  },
  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  },
  window = {
    documentation = {
      border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
    },
  },
  experimental = {
    ghost_text = false,
    native_menu = false,
  },
}


vim.keymap.set("n", "<leader>xx", function() require("trouble").open() end) 
vim.keymap.set("n", "<leader>xw", function() require("trouble").open("workspace_diagnostics") end) 
vim.keymap.set("n", "<leader>xd", function() require("trouble").open("document_diagnostics") end) 
vim.keymap.set("n", "<leader>xq", function() require("trouble").open("quickfix") end) 
vim.keymap.set("n", "<leader>xl", function() require("trouble").open("loclist") end) 
vim.keymap.set("n", "gR", function() require("trouble").open("lsp_references") end)


-- restore the session for the current directory
vim.api.nvim_set_keymap("n", "<leader>qs", [[<cmd>lua require("persistence").load()<cr>]], {})

-- restore the last session
vim.api.nvim_set_keymap("n", "<leader>ql", [[<cmd>lua require("persistence").load({ last = true })<cr>]], {})

-- stop Persistence => session won't be saved on exit
vim.api.nvim_set_keymap("n", "<leader>qd", [[<cmd>lua require("persistence").stop()<cr>]], {})
