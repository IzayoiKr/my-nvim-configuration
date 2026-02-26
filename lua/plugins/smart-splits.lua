return {
    "mrjones2014/smart-splits.nvim",
    keys = {
        -- Basic resizing
        { "<A-h>", "<cmd>SmartResizeLeft<cr>",  desc = "Resize left" },
        { "<A-j>", "<cmd>SmartResizeDown<cr>",  desc = "Resize down" },
        { "<A-k>", "<cmd>SmartResizeUp<cr>",    desc = "Resize up" },
        { "<A-l>", "<cmd>SmartResizeRight<cr>", desc = "Resize right" },
    },
    opts = {
        ignored_filetypes = { "nofile", "prompt", "qf" },
        default_amount = 3,
    },
}
