return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
    config = function()
        local harpoon = require("harpoon")
        harpoon:setup({})

        local themes = require("telescope.themes")
        local conf = require("telescope.config").values

        local function toggle_telescope(harpoon_files)
            if #harpoon_files.items == 0 then
                vim.notify("Harpoon list is empty", vim.log.levels.INFO)
                return
            end

            local file_paths = {}
            for _, item in ipairs(harpoon_files.items) do
                table.insert(file_paths, item.value)
            end

            local opts = themes.get_ivy({ prompt_title = "Working List" })
            require("telescope.pickers")
                .new(opts, {
                    finder = require("telescope.finders").new_table({ results = file_paths }),
                    previewer = conf.file_previewer(opts),
                    sorter = conf.generic_sorter(opts),
                })
                :find()
        end

        -- ── Harpoon list management ───────────────────────────────────
        vim.keymap.set("n", "<leader>ha", function()
            harpoon:list():add()
        end, { desc = "Harpoon: add file" })
        vim.keymap.set("n", "<leader>hr", function()
            harpoon:list():remove()
        end, { desc = "Harpoon: remove file" })
        vim.keymap.set("n", "<leader>hc", function()
            harpoon:list():clear()
        end, { desc = "Harpoon: clear all" })

        -- ── UI ───────────────────────────────────────────────────────
        vim.keymap.set("n", "<C-e>", function()
            harpoon.ui:toggle_quick_menu(harpoon:list())
        end, { desc = "Harpoon: quick menu" })

        vim.keymap.set("n", "<leader>fl", function()
            toggle_telescope(harpoon:list())
        end, { desc = "Harpoon: telescope list" })

        -- ── File selection ────────────────────────────────────────────
        vim.keymap.set("n", "<leader>1", function()
            harpoon:list():select(1)
        end, { desc = "Harpoon: file 1" })
        vim.keymap.set("n", "<leader>2", function()
            harpoon:list():select(2)
        end, { desc = "Harpoon: file 2" })
        vim.keymap.set("n", "<leader>3", function()
            harpoon:list():select(3)
        end, { desc = "Harpoon: file 3" })
        vim.keymap.set("n", "<leader>4", function()
            harpoon:list():select(4)
        end, { desc = "Harpoon: file 4" })

        -- ── Navigate prev / next ──────────────────────────────────────
        vim.keymap.set("n", "<C-p>", function()
            harpoon:list():prev()
        end, { desc = "Harpoon: prev file" })
        vim.keymap.set("n", "<C-n>", function()
            harpoon:list():next()
        end, { desc = "Harpoon: next file" })
    end,
}
