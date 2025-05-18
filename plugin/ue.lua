vim.api.nvim_create_user_command("UnrealGen", function(opts)
    require("ue.commands").generateCommands(opts)
end, {
})

vim.api.nvim_create_user_command("UnrealBuild", function(opts)
    require("ue.commands").build(opts)
end, {
})

vim.api.nvim_create_user_command("UnrealBuildAndRun", function(opts)
    require("ue.commands").buildAndRun(opts)
end, {
})

vim.api.nvim_create_user_command("UnrealPrintHeaders", function(opts)
    require("ue.commands").printHeaders(opts)
end, {
})

