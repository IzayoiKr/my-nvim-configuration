return {
    { -- Git plugin
        "tpope/vim-fugitive",
    },
    { -- Show CSS Colors
        "brenoprata10/nvim-highlight-colors",
        config = function()
            require("nvim-highlight-colors").setup({})
        end,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {},
    },
    {
        "numToStr/Comment.nvim",
        opts = {},
    },
    {
        "kylechui/nvim-surround",
        version = "*",
        opts = {},
    },
}
