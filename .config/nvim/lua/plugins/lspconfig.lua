return function()
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    require("lspconfig").clangd.setup{
        capabilities = capabilities,
    }
    require("lspconfig").pyright.setup{
        capabilities = capabilities,
    }

    require("lspconfig").intelephense.setup{
        capabilities = capabilities,
    }

    require("lspconfig").html.setup{
        capabilities = capabilities,
    }

    require("lspconfig").lua_ls.setup{
        capabilities = capabilities,
        settings = {
            Lua = {
                runtime = {
                    version = "Lua 5.3",
                    path = {
                        "?/init.lua",
                        "?.lua"
                    },
                },
                workspace = {
                    library = {
                        "/usr/share/nvim/runtime/lua",
                        "/usr/share/nvim/runtime/lua/lsp",
                        "/usr/share/awesome/lib/"
			        },
                },
                completion = {
                    enable = true,
                },
                diagnostics = {
                    enable = true,
                    globals = { "vim", "awesome", "client", "root", "luasnip", },
                },
            }
        }
    }

	vim.diagnostic.config({
	    update_in_insert = true,
	    signs = false,
	})
end
