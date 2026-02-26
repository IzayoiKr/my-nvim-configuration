-- gitsigns.nvim: inline git decorations and hunk actions.
-- Shows +/-/~ signs in the gutter, lets you stage/reset individual hunks,
-- preview diffs inline, and blame lines — all without leaving Neovim.
return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" }, -- lazy-load when opening a file
	config = function()
		require("gitsigns").setup({
			signs = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "" },
				topdelete = { text = "" },
				changedelete = { text = "▎" },
				untracked = { text = "▎" },
			},
			-- Show blame annotation at end of line (toggle with <leader>gb)
			current_line_blame = false,
			current_line_blame_opts = {
				delay = 500,
			},

			on_attach = function(bufnr)
				local gs = require("gitsigns")

				local function map(mode, lhs, rhs, desc)
					vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
				end

				-- ── Navigation ────────────────────────────────────────
				map("n", "]h", function()
					if vim.wo.diff then
						vim.cmd.normal({ "]c", bang = true })
					else
						gs.nav_hunk("next")
					end
				end, "Git: next hunk")

				map("n", "[h", function()
					if vim.wo.diff then
						vim.cmd.normal({ "[c", bang = true })
					else
						gs.nav_hunk("prev")
					end
				end, "Git: prev hunk")

				-- ── Actions ───────────────────────────────────────────
				map("n", "<leader>gs", gs.stage_hunk, "Git: stage hunk")
				map("n", "<leader>gr", gs.reset_hunk, "Git: reset hunk")
				map("n", "<leader>gS", gs.stage_buffer, "Git: stage buffer")
				map("n", "<leader>gR", gs.reset_buffer, "Git: reset buffer")
				map("n", "<leader>gu", gs.undo_stage_hunk, "Git: undo stage hunk")
				map("n", "<leader>gp", gs.preview_hunk, "Git: preview hunk")
				map("n", "<leader>gb", gs.toggle_current_line_blame, "Git: toggle line blame")
				map("n", "<leader>gd", gs.diffthis, "Git: diff this")

				-- Stage/reset hunk in visual mode
				map("v", "<leader>gs", function()
					gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, "Git: stage selected hunk")
				map("v", "<leader>gr", function()
					gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, "Git: reset selected hunk")

				-- ── Text object: select a hunk with ih ───────────────
				map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "Git: select hunk")
			end,
		})
	end,
}
