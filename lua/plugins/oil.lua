-- oil.nvim: edit your filesystem like a Neovim buffer.
-- Navigate into a directory and its contents appear as lines you can
-- rename, delete, move, or create — then :w to apply the changes.
return {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("oil").setup({
            -- Default will be handled by nvim-tree
            default_file_explorer = false,
            -- Show hidden files (dotfiles) by default
            view_options = {
                show_hidden = true,
            },
            -- Float oil in a window instead of taking over a buffer
            float = {
                padding = 2,
                max_width = 80,
                max_height = 30,
                border = "rounded",
                win_options = { winblend = 0 },
            },
            -- Keymaps inside the oil buffer (these are oil-local, not global)
            keymaps = {
                ["g?"] = "actions.show_help",
                ["<CR>"] = "actions.select",
                ["<C-v>"] = "actions.select_vsplit",
                ["<C-x>"] = "actions.select_split",
                ["<C-t>"] = "actions.select_tab",
                ["<C-p>"] = "actions.preview",
                ["<C-c>"] = "actions.close",
                ["<C-r>"] = "actions.refresh",
                ["-"] = "actions.parent", -- go up a directory
                ["_"] = "actions.open_cwd",
                ["`"] = "actions.cd",
                ["~"] = "actions.tcd",
                ["gs"] = "actions.change_sort",
                ["gx"] = "actions.open_external",
                ["g."] = "actions.toggle_hidden",
            },
        })

        -- Open oil in a float with <leader>e
        -- (replaces the old <leader>cd → vim.cmd.Ex netrw binding)
        vim.keymap.set("n", "<leader>e", function()
            require("oil").toggle_float()
        end, { desc = "Oil: open file explorer" })

        -- Open oil in the current directory (full buffer, not float)
        -- vim.keymap.set("n", "<leader>cd", function()
        --     require("oil").open()
        -- end, { desc = "Oil: open in current dir" })
    end,
}
