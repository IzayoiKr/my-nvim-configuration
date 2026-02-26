return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter").setup({
            ensure_installed = {
                "lua",
                "vim",
                "vimdoc",
                "query",
                "python",
                "c",
                "cpp",
                "tsx",
                "typescript",
                "javascript",
                "php",
                "go",
                "html",
                "css",
                "sql",
                "rust",
            },
            auto_install = true,
            highlight = { enable = true },
            indent = { enable = true },
        })
    end,
}
