local function enable_transparency()
    local groups = {
        "Normal",
        "NormalNC",
        "NormalFloat",
        "SignColumn",
        "LineNr",
        "CursorLineNr",
        "EndOfBuffer",
        "FoldColumn",
    }
    for _, group in ipairs(groups) do
        vim.api.nvim_set_hl(0, group, { bg = "none" })
    end
end

return {
    {
        "rebelot/kanagawa.nvim",
        config = function()
            require("kanagawa").setup({
                variant = "wave", -- wave | dragon | lotus
            })
            vim.cmd.colorscheme("kanagawa-wave")
            enable_transparency()
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        opts = {
            theme = "kanagawa",
        },
    },
}
