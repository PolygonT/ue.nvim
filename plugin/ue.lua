vim.api.nvim_create_user_command("UnrealGen", function(opts)
    require("ue.commands").generateCommands(opts)
end, {
})

vim.api.nvim_create_user_command("UnrealBuildAndRun", function(opts)
    require("ue.commands").buildAndRun(opts)
end, {
})
