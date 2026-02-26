-- nvim-ts-autotag: auto-close and auto-rename HTML/JSX/PHP/Blade tags.
-- Requires nvim-treesitter to be loaded first (listed as a dependency).
-- Works out of the box — no manual setup() call needed for basic usage.
return {
    "windwp/nvim-ts-autotag",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = "InsertEnter", -- lazy-load: only activates when you start typing
    opts = {
        -- Filetypes autotag is active on. Add/remove as needed.
        opts = {
            enable_close = true,  -- auto-close tags
            enable_rename = true, -- rename closing tag when opening tag changes
            enable_close_on_slash = false, -- don't close on </
        },
    },
}
