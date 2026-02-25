return {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
        require("toggleterm").setup({
            open_mapping = [[<leader>/]],
            direction = "float",
            shade_terminals = true,
            float_opts = {
                border = "curved",
            },
        })

        vim.api.nvim_create_autocmd("TermOpen", {
            pattern = "term://*",
            callback = function()
                local opts = { buffer = 0 }
                vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
                vim.keymap.set("t", "<leader>/", [[<cmd>ToggleTerm<cr>]], opts)
            end,
        })
    end,
}
