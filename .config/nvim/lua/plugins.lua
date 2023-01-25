local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- TODO fzf
return require('packer').startup(function(use)

    -- Packer can manage itself
    use {
        'wbthomason/packer.nvim'
    }

    -- Startup
    use {
        'glepnir/dashboard-nvim',
        requires = { 'liuchengxu/vim-clap' },
        config = require('plugins/dashboard')
    }

    -- Colorscheme
    use {
        "catppuccin/nvim",
        as = "catppuccin",
        config = require('plugins/catppuccin')
    }

    -- Status line
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true },
        config = require('plugins/lualine')
    }

    -- Treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
        config = require('plugins/treesitter'),
    }

    -- File Explorer
    use {
        'kyazdani42/nvim-tree.lua',
        config = require('plugins/nvim_tree')
    }

    -- Commenter plugin
    use {
        'numToStr/Comment.nvim',
        config = require('plugins/comment')
    }

    -- Bufferline
    use {
        'akinsho/bufferline.nvim',
        config = require('plugins/bufferline')
    }

    -- Fuzzy file finder
    use {
        'nvim-telescope/telescope.nvim',
        requires = { 'nvim-lua/plenary.nvim' },
        config = require('telescope').setup()
    }
    -- Preview colors
    use {
       'RRethy/vim-hexokinase',
        run = "make -C ~/.local/share/nvim/site/pack/packer/start/vim-hexokinase/ hexokinase"
    }

    -- Indent line
    use {
        'lukas-reineke/indent-blankline.nvim',
        config = require('plugins/indent_blankline')
    }

    -- Auto pairs
    use {
        'steelsojka/pears.nvim',
        config = require('pears').setup(function(conf)
            conf.remove_pair_on_outer_backspace(false)
        end)
    }

    -- Highlight todo comments
    use {
        'folke/todo-comments.nvim',
        requires = { 'nvim-lua/plenary.nvim' },
        config = require('plugins/todo-comments')
    }

    -- Undotree
    use {
        'mbbill/undotree',
        config = require('plugins/undotree')
    }

    -- Set of operators and textobjects to search/select/edit sandwiched texts
    use {
        'machakann/vim-sandwich'
    }

    -- A much simpler way to use some motions in vim
    use {
        'easymotion/vim-easymotion'
    }

    use {
        'neovim/nvim-lspconfig',
        config = require('plugins/lspconfig')
    }

    use {
        'williamboman/nvim-lsp-installer',
        config = require('plugins/nvim_lsp_installer')
    }

    -- A completion plugin for neovim coded in Lua.
    use {
        'hrsh7th/nvim-cmp',
        requires = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lua',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
        },
        config = require('plugins/cmp')
    }

	if packer_bootstrap then
	require('packer').sync()
	end
end)


