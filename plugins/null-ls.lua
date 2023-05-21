local nls = require('null-ls')

local fmt = nls.builtins.formatting
local dgn = nls.builtins.diagnostics

-- Configuring null-ls
nls.setup({
	sources = {
		-- # FORMATTING #
		fmt.trim_whitespace.with({
			filetypes = { 'text', 'sh', 'zsh', 'toml', 'make', 'conf', 'tmux' },
		}),
		-- NOTE:
		-- 1. both needs to be enabled to so prettier can apply eslint fixes
		-- 2. prettierd should come first to prevent occassional race condition
		-- fmt.prettierd,
		fmt.eslint_d,
    fmt.prettier_d,
		-- fmt.prettier.with({
		--     extra_args = {
		--         '--tab-width=4',
		--         '--trailing-comma=es5',
		--         '--end-of-line=lf',
		--         '--arrow-parens=always',
		--     },
		-- }),
		-- fmt.rustfmt,
		-- fmt.stylua,
		-- fmt.terraform_fmt,
		-- fmt.gofmt,
		-- fmt.zigfmt,
		-- fmt.shfmt.with({
			-- extra_args = { '-i', 4, '-ci', '-sr' },
		-- }),
		-- # DIAGNOSTICS #
		dgn.eslint_d,
		dgn.shellcheck,
	},
})
