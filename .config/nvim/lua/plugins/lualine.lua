return function()
    local navic = require("nvim-navic")

    require("lualine").setup({
        options = {
            component_separators    = { left = '', right = '' },
            always_divide_middle    = false,
            section_separators      = { left = '', right = '' },
            disabled_filetypes      = { "dashboard" },
            icons_enabled           = true,
            globalstatus            = true,
            theme                   = "catppuccin",
        },
        sections = {
            lualine_a = { "mode" },

            lualine_b = {
                { "branch" },
                {
                    "diagnostics",

                    sources = { "nvim_lsp" },

                    sections = { "error", "warn" },

                    diagnostics_color = {
                        error = { fg = "#DC6068" },
                        warn  = { fg = "#f9e2af" },
                    },
                    update_in_insert    = false,
                    always_visible      = false,
                    symbols             = { error = " ", warn = " " },
                    colored             = true,
                },
            },
            lualine_c = { { "filename", file_status = true, newfile_status = true, path = 1 } },
            lualine_x = { "filetype" },
            lualine_y = { "filesize" },
            lualine_z = { "location" },
        },
        winbar = {
            lualine_c = { "navic" },
        },
    })
end
