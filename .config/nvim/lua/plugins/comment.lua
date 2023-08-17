return function()
	require("Comment").setup({
	    padding = true,     -- Add space b/w comment and the line
	    ignore = "^$",      -- Don't comment empty lines
	    toggler = {
            line = "gcc",
            block = "gb"
	    }
	})
end
