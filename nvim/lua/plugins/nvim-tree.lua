-- nvim-tree: VS Code-style file explorer sidebar with icons.
-- Behaviour:
--   nvim somedir/  → tree auto-opens, rooted at somedir/
--   nvim file.lua  → tree stays closed until you toggle it
--   <leader>cd     → toggle tree
--   <leader>cf     → reveal current file in tree
return {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        -- Disable netrw entirely — nvim-tree replaces it
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1

        require("nvim-tree").setup({
            -- Root the tree to cwd, so `nvim somedir/` roots at somedir/
            sync_root_with_cwd = true,
            respect_buf_cwd = true,
            update_focused_file = {
                enable = true,
                update_root = {
                    -- Allow root to change when navigating into subdirectories
                    enable = true,
                    ignore_list = {},
                },
            },

            view = {
                width = 35,
                side = "left",
                preserve_window_proportions = true,
            },

            renderer = {
                group_empty = true, -- collapse single-child folders
                highlight_git = "name", -- color filenames by git status
                highlight_opened_files = "name",
                indent_markers = {
                    enable = true, -- show │ guide lines like VS Code
                },
                icons = {
                    show = {
                        file = true,
                        folder = true,
                        folder_arrow = true,
                        git = true,
                    },
                },
            },

            filters = {
                dotfiles = false,
            },

            git = {
                enable = true,
                ignore = false,
                timeout = 400,
            },

            actions = {
                open_file = {
                    quit_on_open = false,
                    window_picker = {
                        enable = true,
                    },
                },
                change_dir = {
                    -- When you press `]` or enter a dir in the tree,
                    -- change Neovim's cwd to match so the root stays tight
                    enable = true,
                    global = false,
                    restrict_above_cwd = false,
                },
            },
        })

        -- Auto-open tree when nvim is launched with a directory argument.
        -- Does nothing when opening a file directly.
        vim.api.nvim_create_autocmd("VimEnter", {
            callback = function(data)
                local is_directory = vim.fn.isdirectory(data.file) == 1
                if not is_directory then
                    return
                end

                -- cd into the directory so cwd = the opened folder
                vim.cmd.cd(data.file)
                -- Open the tree rooted there
                require("nvim-tree.api").tree.open()
            end,
        })

        vim.keymap.set("n", "<leader>cd", "<cmd>NvimTreeToggle<CR>", { desc = "Tree: toggle sidebar" })
        vim.keymap.set("n", "<leader>cf", "<cmd>NvimTreeFindFile<CR>", { desc = "Tree: reveal current file" })
    end,
}
