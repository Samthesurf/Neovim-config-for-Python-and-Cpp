vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.incsearch = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.termguicolors = true
vim.opt.guifont = "JetBrainsMono Nerd Font:h10"
if vim.g.neovide then
    vim.opt.guifont = "JetBrainsMono Nerd Font:h10:b"
    vim.g.neovide_transparency = 0.95
    vim.g.neovide_background_color = "#1f528f"
    -- vim.cmd [[au BufWritePre * :cd ~/Downloads]]
end
vim.opt.relativenumber = true
vim.api.nvim_set_var('mapleader', ' ')
vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', { noremap = true })
-- vim.api.nvim_set_keymap('n','x','_x',{desc = "delete without yanking"})
vim.o.completeopt = "menuone,noselect"
vim.opt.cursorline = true
vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.opt.clipboard:append("unnamedplus")
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({ "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        -- latest stable release
        lazypath, })
end
vim.opt.rtp:prepend(lazypath)
local powershell_options = {
    shell = vim.fn.executable "pwsh.exe -NoLogo" == 1 and "pwsh.exe -NoLogo" or "pwsh.exe -NoLogo",
    shellcmdflag =
    "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;",
    shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait",
    shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode",
    shellquote = "",
    shellxquote = "",
}

for option, value in pairs(powershell_options) do
    vim.opt[option] = value
end
require("lazy").setup {
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.2', -- or ,
        branch = '0.1.x',
        dependencies = { 'nvim-lua/plenary.nvim',"debugloop/telescope-undo.nvim"},

    }
    , {
    "nvim-treesitter/nvim-treesitter",
    run = ':TSUpdate'

}, {
    -- "sharkdp/fd"
}, {
    "nvim-tree/nvim-web-devicons"
}, {
    -- "BurntSushi/ripgrep"
}, {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
}, {
    "williamboman/mason.nvim"
}, {
    "neovim/nvim-lspconfig"
}, {
    "folke/trouble.nvim"
},
    {
        --"mfussenegger/nvim-lint"
    }, {
    "akinsho/toggleterm.nvim", version = "*", config = true
},
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons"
        }
    },
    {
        "folke/which-key.nvim"
    },
    {
        "folke/flash.nvim",
        -- enabled = false,
        event = "VeryLazy",
        -- -@type Flash.Config
        opts = {},
        -- stylua: ignore
        keys = {
            {
                "r",
                mode = "o",
                function() require("flash").remote() end,
                desc =
                "Remote Flash"
            },
            {
                "R",
                mode = { "o", "x" },
                function() require("flash").treesitter_search() end,
                desc =
                "Treesitter Search"
            },
            { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
        }
    },
    {
        "akinsho/bufferline.nvim", version = "*", dependencies = "nvim-tree/nvim-web-devicons"
    },
    {
        "williamboman/mason-lspconfig.nvim"
    },
    {
        -- "windwp/windline.nvim"
    },
    {
        "lewis6991/gitsigns.nvim"
    },
    {
        --"neoclide/coc.nvim", branch = 'release',
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "saadparwaiz1/cmp_luasnip",
            "L3MON4D3/LuaSnip",
            "rafamadriz/friendly-snippets",
        }
    },
    {
        "CRAG666/code_runner.nvim", config = true,
    },
    {
        "CRAG666/betterTerm.nvim"
    },
    {
        "tpope/vim-fugitive"
    },
    {
        'windwp/nvim-autopairs', event = "InsertEnter", opts = {}
    },
    {
        'nvim-treesitter/nvim-treesitter-context'
    },
    {
        'numToStr/Comment.nvim', opts = {}, lazy = false
    },
    {
        'nvim-lualine/lualine.nvim', requires = { 'nvim-tree/nvim-web-devicons' }, opt = true
    },
    {
        'folke/zen-mode.nvim'
    },
    {
        -- 'dinhhuy258/git.nvim'
    },
    {
        'RRethy/vim-illuminate'
    },
    {
        "junegunn/fzf"
    },
    {
        'mfussenegger/nvim-dap'
    },
    {
        'mfussenegger/nvim-dap-python'
    },
    {
        'goolord/alpha-nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require 'alpha'.setup(require 'alpha.themes.startify'.config)
        end
    },
    {
        -- 'onsails/lspkind.nvim'
    },
    {
        'jose-elias-alvarez/null-ls.nvim'
    },
    {
        'rcarriga/nvim-dap-ui'
    },
    {
        'folke/neodev.nvim', opts = {}
    },
    {
        "folke/persistence.nvim",
        event = "BufReadPre", -- this will only start session saving when an actual file was opened
        opts = {
            -- add any custom options here
        }
    },
    {
        "JoosepAlviste/nvim-ts-context-commentstring"
    },
    {
        -- "simrat39/inlay-hints.nvim", enabled = false
    },
    {
        --'nvim-pack/nvim-spectre'
    },
    {
        'iamcco/markdown-preview.nvim', event = "VeryLazy"
    },
    {
        "folke/noice.nvim",
        enabled = false,
        event = "VeryLazy",
        opts = {
            -- add any options here
        },
        {
            'catppuccin/nvim', name = 'catppuccin', priority = 1000
        }
    },
    {
        -- "folke/twilight.nvim"
    },
    {
        "petertriho/nvim-scrollbar"
    },
    {
        "MunifTanjim/nui.nvim", enabled = false,
    },
    {
        "rcarriga/nvim-notify", enabled = false
    },
    {
        -- "ggandor/leap.nvim", dependencies = { "tpope/vim-repeat" }
    },
    {
        -- "tpope/vim-repeat"
    },
    {
        "EdenEast/nightfox.nvim"
    },
    {
        "marko-cerovac/material.nvim", event = "VeryLazy"
    },
    {
        "rebelot/kanagawa.nvim"
    },
    {
        "xiyaowong/transparent.nvim"
    },
    {
        "nvim-telescope/telescope-dap.nvim", enabled = false
    },
    {
        "natecraddock/workspaces.nvim"
    },
    {
        "christoomey/vim-tmux-navigator"
    },
    {
        "907th/vim-auto-save",
    },
    {
        -- "stevearc/conform.nvim"
    },
    { "dense-analysis/ale", enabled = false },
    {
        "utilyre/barbecue.nvim",
        name = "barbecue",
        version = "*",
        dependencies = { "SmiteshP/nvim-navic", "nvim-tree/nvim-web-devicons", },
        opts = {},
    },
    {
        "johngrib/vim-game-snake",event = "VeryLazy"
    }
}

-- vim.keymap.set('n', '<Esc>', '<Esc>:w<CR>', { desc = "trying auto save" })
-- vim.keymap.set('i', '<Esc>', '<Esc>:w<CR>', { desc = "trying auto save" })
require("nvim-treesitter.configs").setup {
    auto_install = true,
    highlight = { enable = true }
}
require("telescope").setup {}
require("telescope").load_extension("undo")
require("mason").setup {}
require("mason-lspconfig").setup {}
require('gitsigns').setup {}
--require('wlsample.evil_line')
require('treesitter-context').setup {}
require('nvim-autopairs').setup {}
-- require('telescope').load_extension('dap')
require("workspaces").setup {}
require('Comment').setup {
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
            location = location, }
    end
}
local colors = require("tokyonight.colors").setup()
require("scrollbar").setup({
    handle = {
        color = "#b2beb5",
    },
    marks = {
        Search = { color = colors.orange },
        Error = { color = colors.error },
        Warn = { color = colors.warning },
        Info = { color = colors.info },
        Hint = { color = colors.hint },
        Misc = { color = colors.purple },
    }
})
require("barbecue").setup({
    theme = {
        -- this highlight is used to override other highlights
        -- you can take advantage of its bg and set a background throughout your winbar
        -- (e.g. basename will look like this: { fg = "#c0caf5", bold = true })
        normal = { fg = "#c0caf5" },

        -- these highlights correspond to symbols table from config
        ellipsis = { fg = "#737aa2" },
        separator = { fg = "#737aa2" },
        modified = { fg = "#737aa2" },

        -- these highlights represent the _text_ of three main parts of barbecue
        dirname = { fg = "#737aa2" },
        basename = { bold = true },
        context = {},

        -- these highlights are used for context/navic icons
        context_file = { fg = "#ac8fe4" },
        context_module = { fg = "#ac8fe4" },
        context_namespace = { fg = "#ac8fe4" },
        context_package = { fg = "#ac8fe4" },
        context_class = { fg = "#ac8fe4" },
        context_method = { fg = "#ac8fe4" },
        context_property = { fg = "#ac8fe4" },
        context_field = { fg = "#ac8fe4" },
        context_constructor = { fg = "#ac8fe4" },
        context_enum = { fg = "#ac8fe4" },
        context_interface = { fg = "#ac8fe4" },
        context_function = { fg = "#ac8fe4" },
        context_variable = { fg = "#ac8fe4" },
        context_constant = { fg = "#ac8fe4" },
        context_string = { fg = "#ac8fe4" },
        context_number = { fg = "#ac8fe4" },
        context_boolean = { fg = "#ac8fe4" },
        context_array = { fg = "#ac8fe4" },
        context_object = { fg = "#ac8fe4" },
        context_key = { fg = "#ac8fe4" },
        context_null = { fg = "#ac8fe4" },
        context_enum_member = { fg = "#ac8fe4" },
        context_struct = { fg = "#ac8fe4" },
        context_event = { fg = "#ac8fe4" },
        context_operator = { fg = "#ac8fe4" },
        context_type_parameter = { fg = "#ac8fe4" },
    },
})
local function lspinfo()
    local msg = 'No Active Lsp'
    local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
    local clients = vim.lsp.get_active_clients()
    if next(clients) == nil then return msg end
    local active_clients = {}
    for _, client in ipairs(clients) do
        local filetypes = client.config.filetypes
        if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
            table.insert(active_clients, client.name)
        end
    end
    if #active_clients > 0 then
        return table.concat(active_clients, ', ')
    else
        return msg
    end
end

local lspinfo_component = {
    function()
        return lspinfo()
    end,
    icon = ' LSP:',
    color = { fg = '#87ceeb', gui = 'bold' }
}
local function surfer()
    return [[SamuelSurf]]
end
require('lualine').setup {
    options = {
        section_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' },
        disabled_filetypes = { 'NvimTree' }
    },
    sections = {
        lualine_c = { 'filename' },
        lualine_x = { lspinfo_component, surfer, 'filetype' }
    }
}
--require('git').setup {}
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
        -- null_ls.builtins.formatting.black,
        -- null_ls.builtins.diagnostics.mypy,
    },
})
vim.g.transparent_enabled = true
-- require("conform").setup {
--     formatters_by_ft = {
--         python = { "black" }
--     },
--     format_on_save = {
--         timeout_ms = 20000,
--         lsp_fallback = false,
--     }
-- }
-- Format Python files on save
-- vim.cmd  [[au BufWritePre *.py silent !black %]]
vim.cmd([[
augroup format
    autocmd!
    autocmd FileType python noremap <buffer> <Esc>
    	\ :silent !black %<CR>
augroup END
]])
require("neodev").setup({
    library = { plugins = { "nvim-dap-ui" }, types = true },
})
require("code_runner").setup {}
-- require('persistence').setup{}
require("betterTerm").setup {}
vim.cmd([[
  augroup toggleterm
    autocmd!
    autocmd TermOpen * call settabvar(1, 'toggleterm_directory', expand('%:p:h'))
  augroup END
]])
--require("noice").setup({
--  lsp = {
--    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
--  override = {
--    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
--  ["vim.lsp.util.stylize_markdown"] = true,
--["cmp.entry.get_documentation"] = true,
--},
--},
-- you can enable a preset for easier configuration
--presets = {
--  bottom_search = true,         -- use a classic bottom cmdline for search
--command_palette = true,       -- position the cmdline and popupmenu together
--long_message_to_split = true, -- long messages will be sent to a split
-- inc_rename = false,           -- enables an input dialog for inc-rename.nvim
-- lsp_doc_border = false,       -- add a border to hover docs and signature help
--},
--})
vim.keymap.set("n", "<leader>/", "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>",
    { desc = 'Comment line' })
vim.keymap.set("x", "<leader>/", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
    { desc = 'Comment line' })
vim.api.nvim_set_keymap("n", "<leader>ft", ":Telescope live_grep<CR>", { noremap = true })
vim.keymap.set("n", "<C-m>", ":Mason<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>cl", ":LspInfo<cr>", { desc = "Lsp Info" })
vim.api.nvim_set_keymap("n", "K", ":lua vim.lsp.buf.hover()<CR>", { desc = "Hover" })
vim.api.nvim_set_keymap("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
vim.keymap.set("n", "<leader>S", ":BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
vim.keymap.set("n", "<leader>s", ":BufferLineCycleNext<cr>", { desc = "Next buffer" })
vim.api.nvim_set_keymap('n', '<leader>k', ':lua vim.lsp.buf.definition()<CR>', { desc = 'Show definition' })
vim.keymap.set('n', '<leader>t', ':NvimTreeFocus<CR>', { desc = 'Jump to Tree' })
vim.keymap.set('n', ':Q', ':q', { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>fd", ":lua vim.lsp.buf.format{timeout_ms = 12000}<CR>", { desc = "Format" })
vim.api.nvim_set_keymap("n", "p", "P", { noremap = true })
vim.api.nvim_set_keymap("n", "yy", "_y$", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>a", "gg0vG$", { desc = "highlight entire document" })
vim.api.nvim_set_keymap("i", "<A><A>", "<C-c>", { desc = "Entering normal mode" })
vim.api.nvim_set_keymap("n", "<leader>vs",":VimGameSnake<CR>",{desc = "Play Vim Snake"})
vim.api.nvim_set_keymap("n","<leader>ss",":echo g:VimSnakeScore<CR>",{desc = "See Snake score"})

-- Define the key mappings
vim.api.nvim_set_keymap('n', '<A-1>', ':ToggleTerm direction=horizontal<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A-2>', ':ToggleTerm direction=vertical<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A-3>', ':ToggleTerm direction=float<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-s>', '<Esc>:w<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-s>', ':w<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>qa', ':qall<CR>', { desc = "Close Neovim" })
vim.api.nvim_set_keymap('n', '<leader>of', ':Telescope oldfiles<CR>', { desc = 'Recent Files' })
vim.api.nvim_set_keymap('n', '<leader>fz', ':FZF<CR>', { desc = 'fzf' })
vim.api.nvim_set_keymap('n', '<leader>wa', ':wqall<CR>', { desc = "Save and exit Neovim" })
vim.api.nvim_set_keymap('n', '<leader>tk', ':Telescope keymaps<CR>', { desc = "Keymaps" })
vim.api.nvim_set_keymap('n', '<C-d>', '<C-d>zz', { desc = "half page up" })
vim.api.nvim_set_keymap('n', '<C-u>', '<C-u>zz', { desc = "half page down" })
--Running code lol
vim.cmd([[
augroup exe_code
    autocmd!
    autocmd FileType python noremap <buffer> <F5>
    	\ :sp<CR>:term py %<CR> i
    autocmd FileType cpp noremap <buffer> <F5>
    \ :sp<CR>:term clang++ % -o %:r.exe;cmd /K %:r<CR> i
    autocmd FileType c noremap <buffer> <F5>
    \ :sp<CR>:term clang % -o %:r.exe;cmd /K %:r<CR> i
augroup END
]])
require("nvim-tree").setup {
    view = {
        side = 'right',
        number = true,
        relativenumber = true,
        -- show_header = true,
        -- header_title = "Sam's Files",
    },
    renderer = {
        highlight_diagnostics = true,
        highlight_git = true,
    }
}
-- require("leap").add_default_mappings()
vim.keymap.set('n', 's', function() require("flash").jump() end, { desc = "jump" })
vim.keymap.set('n', 'S', function() require("flash").treesitter() end, { desc = "Flash Treesitter" })
vim.keymap.set('n', '<bsc>', "i<bsc>")
--require("evil_lualine.evil_lualine")
vim.cmd [[let g:auto_save = 1]]
vim.cmd [[let g:auto_save_silent = 1]]
vim.o.mouse = "a"
vim.opt.number = true
require("catppuccin").setup { flavour = "mocha" }
vim.cmd [[colorscheme kanagawa]]
require("bufferline").setup {}


local nvim_lsp = require('lspconfig')
nvim_lsp.jedi_language_server.setup {}
nvim_lsp.jsonls.setup {}


-- require'lspconfig'.pylyzer.setup{}
-- local ih = require("inlay-hints")
nvim_lsp.clangd.setup {
    cmd = { "clangd", "--clang-tidy" },
    filetypes = { "c", "cpp" },
    root_dir = require 'lspconfig'.util.root_pattern(".git", "compile_commands.json"),
}

local cmp1 = require('cmp')
cmp1.setup({ sources = { name = 'nvim_lsp' } })
require("lspconfig").lua_ls.setup {
    cmd = { "lua-language-server.cmd" or "sunmeko.lua" }, {
    diagnostics = {
        libraryFiles = "Disable"
    },
    {
        workspace = {
            maxPreload = 2
        }
    }
}
}
-- Neovim config for PowerShell Editor Services
require 'lspconfig'.powershell_es.setup {
    cmd = { "pwsh", "-NoLogo", "-NoProfile", "-NonInteractive", "-ExecutionPolicy", "Bypass", "-Command",
        "EditorServices.StartEditorServices()" },
    filetypes = { "powershell" },
}
-- Configure gopls
require("lspconfig").gopls.setup {
    cmd = { "gopls", "serve" },
    filetypes = { "go" },
}

vim.api.nvim_set_keymap('n', '<leader>e', ':NvimTreeFindFileToggle<CR>', { noremap = true, silent = true })
-- <A means alt
vim.api.nvim_set_keymap('n', '<A-r>', ':RunCode<CR>i', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>d', ':bw!<CR>', { desc = "delete tab" })

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
        ["<Tab>"] = cmp.mapping.confirm { select = true },
        ["<Down>"] = cmp.mapping(function(fallback)
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
        ["<Up>"] = cmp.mapping(function(fallback)
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
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        {
            name = 'cmdline',
            option = {
                ignore_cmds = { 'Man', '!' }
            }
        }
    })
})
cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})
vim.keymap.set("n", "<leader>tt", function() require("trouble").open() end, { desc = "Trouble" })
vim.keymap.set("n", "<leader>tw", function() require("trouble").open("workspace_diagnostics") end,
    { desc = "workspace trouble" })
vim.keymap.set("n", "<leader>td", function() require("trouble").open("document_diagnostics") end,
    { desc = "document trouble" })
vim.keymap.set("n", "<leader>tq", function() require("trouble").open("quickfix") end, { desc = "quickfix" })
vim.keymap.set("n", "<leader>tl", function() require("trouble").open("loclist") end, { desc = "loclist" })
vim.keymap.set("n", "gR", function() require("trouble").open("lsp_references") end, { desc = "references" })

-- restore the session for the current directory
vim.api.nvim_set_keymap("n", "<leader>ps", [[<cmd>lua require("persistence").load()<cr>]],
    { desc = "restore session for dir" })

-- restore the last session
vim.api.nvim_set_keymap("n", "<leader>pl", [[<cmd>lua require("persistence").load({ last = true })<cr>]],
    { desc = "restore last session" })

-- stop Persistence => session won't be saved on exit
vim.api.nvim_set_keymap("n", "<leader>qd", [[<cmd>lua require("persistence").stop()<cr>]],
    { desc = "Don't save session" })
