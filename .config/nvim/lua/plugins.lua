--    ___            __  ______
--   / _ )___  ___  / /_/ __/ /________ ____
--  / _  / _ \/ _ \/ __/\ \/ __/ __/ _ `/ _ \
-- /____/\___/\___/\__/___/\__/_/  \_,_/ .__/
--                                    /_/

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)


if vim.g.vscode then
    require("lazy").setup({
        -- Commenter plugin
        {
            "numToStr/Comment.nvim",
            config = require("plugins/comment")
        },

        -- Auto pairs
        {
            "jiangmiao/auto-pairs",
        },

        -- Highlight todo comments
        {
            "folke/todo-comments.nvim",
            dependencies = { "nvim-lua/plenary.nvim" },
            config = require("plugins/todo-comments")
        },
    })
else
    require("lazy").setup({
        -- Colorscheme
        {
            "catppuccin/nvim",
            config = require("plugins/catppuccin")
        },

        -- Status line
        {
            "nvim-lualine/lualine.nvim",
            dependencies = { "kyazdani42/nvim-web-devicons" },
            config = require("plugins/lualine"),
        },

        -- Bufferline
        {
            "akinsho/bufferline.nvim",
            config = require("plugins/bufferline"),
        },

        -- Indent line
        {
            "lukas-reineke/indent-blankline.nvim",
            config = require("plugins/indent_blankline")
        },

        -- Treesitter
        {
            "nvim-treesitter/nvim-treesitter",
            config = require("plugins/treesitter"),
        },

        -- File Explorer
        {
            "kyazdani42/nvim-tree.lua",
            config = require("plugins/nvim_tree")
        },

        -- Motion Plugin
        {
            "easymotion/vim-easymotion"
        },

        -- Startup
        {
            "glepnir/dashboard-nvim",
            requires = { "liuchengxu/vim-clap" },
            config = require("plugins/dashboard")
        },

        -- Preview colors
        {
            "rrethy/vim-hexokinase",
            build = "make -C ~/.local/share/nvim/lazy/vim-hexokinase/ hexokinase",
            config = require("plugins/hexokinase")
        },

        -- Fuzzy file finder
        {
            "nvim-telescope/telescope.nvim",
            dependencies = { "nvim-lua/plenary.nvim" },
            config = true,
        },

        -- Commenter plugin
        {
            "numToStr/Comment.nvim",
            config = require("plugins/comment")
        },

        -- Auto pairs
        {
            "jiangmiao/auto-pairs",
        },

        -- Highlight todo comments
        {
            "folke/todo-comments.nvim",
            dependencies = { "nvim-lua/plenary.nvim" },
            config = require("plugins/todo-comments")
        },

        -- BreadCrumbs
        {
            "SmiteshP/nvim-navic",
            config = require("plugins/navic")
        },

        -- Terminal
        {
          -- amongst your other plugins
          "akinsho/toggleterm.nvim",
          config = require("plugins/toggleterm"),
        },

        -- GitSigns
        {
            "lewis6991/gitsigns.nvim",
            config = require("plugins/gitsigns"),
        },

        -- Text alignment
        {
            "godlygeek/tabular"
        },

        -- Markdown
        {
            "preservim/vim-markdown"
        },

        {
            "iamcco/markdown-preview.nvim",
            build = "cd app && npm install",
            config = function()
                g.mkdp_markdown_css = "~/.config/nvim/lib/github-markdown-css/github-markdown-dark.css"
            end
        },

        -- LaTex
        {
            "lervag/vimtex"
        },

        -- LSP
        {
            "williamboman/mason.nvim",
            config = require("plugins/mason"),
            build  = ":MasonUpdate"
        },

        {
            "williamboman/mason-lspconfig.nvim",
        },

        {
            "neovim/nvim-lspconfig",
            config = require("plugins/lspconfig")
        },

        {
            "L3MON4D3/LuaSnip",
            dependencies = { "rafamadriz/friendly-snippets" },
            config       = require("plugins/luasnip"),
            version      = "<CurrentMajor>.*",
        },

        -- A completion plugin for neovim coded in Lua.
        {
            "hrsh7th/nvim-cmp",
            dependencies = {
                "saadparwaiz1/cmp_luasnip",
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-cmdline",
                "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-path",
            },
            config = require("plugins/cmp")
        },
    })

end

