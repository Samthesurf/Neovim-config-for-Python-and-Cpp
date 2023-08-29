vim.o.splitbelow = true
vim.o.splitright = true
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
  shell = vim.fn.executable "pwsh" == 1 and "pwsh" or "powershell",
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
--"folke/trouble.nvim"
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
"neoclide/coc.nvim", branch = 'release',
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
  "ibhagwan/fzf-lua"
},{
'mfussenegger/nvim-dap'
},{
  'mfussenegger/nvim-dap-python'
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
require("fzf-lua").setup{}
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
--require('fugitive').setup{}

-- Define the key mappings
vim.api.nvim_set_keymap('n', '<A-1>', ':ToggleTerm direction=horizontal<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A-2>', ':ToggleTerm direction=vertical<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A-3>', ':ToggleTerm direction=float<CR>cls<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-s>', '<Esc>:w<CR>',{noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-s>', ':w<CR>',{noremap = true, silent = true })
vim.api.nvim_set_keymap('i', ';q', ':q<CR>',{noremap = true, silent = true })
vim.api.nvim_set_keymap('i', 'F6', '<Esc>:bn<CR>',{noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'F6', ':bn<CR>',{noremap = true, silent = true })
vim.api.nvim_set_keymap('i', 'F4', '<Esc>:bp<CR>',{noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'F4', ':bp<CR>',{noremap = true, silent = true })


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
nvim_lsp.clangd.setup{
  cmd = { "clangd", "--background-index" },
  filetypes = { "c", "cpp", "objc", "objcpp" },
  root_dir = require'lspconfig'.util.root_pattern(".git", "compile_commands.json"),
  -- init_options = {
  --   clangdFileStatus = true,
  --   usePlaceholders = true,
  --   completeUnimported = true,
  --   semanticHighlighting = true
  -- }
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



--coc.nvim
--require("coc.nvim").setup{}
-- Some servers have issues with backup files, see #649
vim.opt.backup = false
vim.opt.writebackup = false

-- Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
-- delays and poor user experience
vim.opt.updatetime = 300

-- Always show the signcolumn, otherwise it would shift the text each time
-- diagnostics appeared/became resolved
vim.opt.signcolumn = "yes"

local keyset = vim.keymap.set
-- Autocomplete
function _G.check_back_space()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

-- Use Tab for trigger completion with characters ahead and navigate
-- NOTE: There's always a completion item selected by default, you may want to enable
-- no select by setting `"suggest.noselect": true` in your configuration file
-- NOTE: Use command ':verbose imap <tab>' to make sure Tab is not mapped by
-- other plugins before putting this into your config
local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
keyset("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

-- Make <CR> to accept selected completion item or notify coc.nvim to format
-- <C-g>u breaks current undo, please make your own choice
keyset("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)

-- Use <c-j> to trigger snippets
keyset("i", "<c-j>", "<Plug>(coc-snippets-expand-jump)")
-- Use <c-space> to trigger completion
keyset("i", "<c-space>", "coc#refresh()", {silent = true, expr = true})

-- Use `[g` and `]g` to navigate diagnostics
-- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
keyset("n", "[g", "<Plug>(coc-diagnostic-prev)", {silent = true})
keyset("n", "]g", "<Plug>(coc-diagnostic-next)", {silent = true})

-- GoTo code navigation
keyset("n", "gd", "<Plug>(coc-definition)", {silent = true})
keyset("n", "gy", "<Plug>(coc-type-definition)", {silent = true})
keyset("n", "gi", "<Plug>(coc-implementation)", {silent = true})
keyset("n", "gr", "<Plug>(coc-references)", {silent = true})


-- Use K to show documentation in preview window
function _G.show_docs()
    local cw = vim.fn.expand('<cword>')
    if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
        vim.api.nvim_command('h ' .. cw)
    elseif vim.api.nvim_eval('coc#rpc#ready()') then
        vim.fn.CocActionAsync('doHover')
    else
        vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
    end
end
keyset("n", "K", '<CMD>lua _G.show_docs()<CR>', {silent = true})


-- Highlight the symbol and its references on a CursorHold event(cursor is idle)
vim.api.nvim_create_augroup("CocGroup", {})
vim.api.nvim_create_autocmd("CursorHold", {
    group = "CocGroup",
    command = "silent call CocActionAsync('highlight')",
    desc = "Highlight symbol under cursor on CursorHold"
})


-- Symbol renaming
keyset("n", "<leader>rn", "<Plug>(coc-rename)", {silent = true})


-- Formatting selected code
keyset("x", "<leader>f", "<Plug>(coc-format-selected)", {silent = true})
keyset("n", "<leader>f", "<Plug>(coc-format-selected)", {silent = true})


-- Setup formatexpr specified filetype(s)
vim.api.nvim_create_autocmd("FileType", {
    group = "CocGroup",
    pattern = "typescript,json",
    command = "setl formatexpr=CocAction('formatSelected')",
    desc = "Setup formatexpr specified filetype(s)."
})

-- Update signature help on jump placeholder
vim.api.nvim_create_autocmd("User", {
    group = "CocGroup",
    pattern = "CocJumpPlaceholder",
    command = "call CocActionAsync('showSignatureHelp')",
    desc = "Update signature help on jump placeholder"
})

-- Apply codeAction to the selected region
-- Example: `<leader>aap` for current paragraph
local opts = {silent = true, nowait = true}
keyset("x", "<leader>a", "<Plug>(coc-codeaction-selected)", opts)
keyset("n", "<leader>a", "<Plug>(coc-codeaction-selected)", opts)

-- Remap keys for apply code actions at the cursor position.
keyset("n", "<leader>ac", "<Plug>(coc-codeaction-cursor)", opts)
-- Remap keys for apply source code actions for current file.
keyset("n", "<leader>as", "<Plug>(coc-codeaction-source)", opts)
-- Apply the most preferred quickfix action on the current line.
keyset("n", "<leader>qf", "<Plug>(coc-fix-current)", opts)

-- Remap keys for apply refactor code actions.
keyset("n", "<leader>re", "<Plug>(coc-codeaction-refactor)", { silent = true })
keyset("x", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })
keyset("n", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })

-- Run the Code Lens actions on the current line
keyset("n", "<leader>cl", "<Plug>(coc-codelens-action)", opts)


-- Map function and class text objects
-- NOTE: Requires 'textDocument.documentSymbol' support from the language server
keyset("x", "if", "<Plug>(coc-funcobj-i)", opts)
keyset("o", "if", "<Plug>(coc-funcobj-i)", opts)
keyset("x", "af", "<Plug>(coc-funcobj-a)", opts)
keyset("o", "af", "<Plug>(coc-funcobj-a)", opts)
keyset("x", "ic", "<Plug>(coc-classobj-i)", opts)
keyset("o", "ic", "<Plug>(coc-classobj-i)", opts)
keyset("x", "ac", "<Plug>(coc-classobj-a)", opts)
keyset("o", "ac", "<Plug>(coc-classobj-a)", opts)


-- Remap <C-f> and <C-b> to scroll float windows/popups
---@diagnostic disable-next-line: redefined-local
local opts = {silent = true, nowait = true, expr = true}
keyset("n", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
keyset("n", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)
keyset("i", "<C-f>",
       'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"', opts)
keyset("i", "<C-b>",
       'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"', opts)
keyset("v", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
keyset("v", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)


-- Use CTRL-S for selections ranges
-- Requires 'textDocument/selectionRange' support of language server
--keyset("n", "<C-s>", "<Plug>(coc-range-select)", {silent = true})
keyset("x", "<C-Space><s>", "<Plug>(coc-range-select)", {silent = true})


-- Add `:Format` command to format current buffer
vim.api.nvim_create_user_command("Format", "call CocAction('format')", {})

-- " Add `:Fold` command to fold current buffer
vim.api.nvim_create_user_command("Fold", "call CocAction('fold', <f-args>)", {nargs = '?'})

-- Add `:OR` command for organize imports of the current buffer
vim.api.nvim_create_user_command("OR", "call CocActionAsync('runCommand', 'editor.action.organizeImport')", {})

-- Add (Neo)Vim's native statusline support
-- NOTE: Please see `:h coc-status` for integrations with external plugins that
-- provide custom statusline: lightline.vim, vim-airline
vim.opt.statusline:prepend("%{coc#status()}%{get(b:,'coc_current_function','')}")

-- Mappings for CoCList
-- code actions and coc stuff
---@diagnostic disable-next-line: redefined-local
local opts = {silent = true, nowait = true}
-- Show all diagnostics
keyset("n", "<space>a", ":<C-u>CocList diagnostics<cr>", opts)
-- Manage extensions
keyset("n", "<space>x", ":<C-u>CocList extensions<cr>", opts)
-- Show commands
keyset("n", "<space>c", ":<C-u>CocList commands<cr>", opts)
-- Find symbol of current document
keyset("n", "<space>o", ":<C-u>CocList outline<cr>", opts)
-- Search workspace symbols
keyset("n", "<space>s", ":<C-u>CocList -I symbols<cr>", opts)
-- Do default action for next item
keyset("n", "<space>j", ":<C-u>CocNext<cr>", opts)
-- Do default action for previous item
keyset("n", "<space>k", ":<C-u>CocPrev<cr>", opts)
-- Resume latest coc list
keyset("n", "<space>p", ":<C-u>CocListResume<cr>", opts)
