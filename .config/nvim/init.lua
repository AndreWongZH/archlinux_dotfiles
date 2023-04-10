require("basic.remap")
print("hello world lua")

-- update cursor back in alacritty
vim.cmd
[[
	augroup change_cursor
		au!
		au ExitPre * :set guicursor=a:ver90
	augroup END
]]



