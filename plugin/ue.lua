vim.api.nvim_create_user_command("UnrealGen", function(opts)
    require("ue.commands").generateCommands(opts)
end, {
})
