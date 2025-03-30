M = {}

local buffer_number = -1

local function log(_, data)
    if data then
        -- Make it temporarily writable so we don't have warnings.
        vim.api.nvim_buf_set_option(buffer_number, "readonly", false)
        -- Append the data.
        vim.api.nvim_buf_set_lines(buffer_number, -1, -1, true, data)

        -- Make readonly again.
        vim.api.nvim_buf_set_option(buffer_number, "readonly", true)

        -- Mark as not modified, otherwise you'll get an error when
        -- attempting to exit vim.
        vim.api.nvim_buf_set_option(buffer_number, "modified", false)

        -- Get the window the buffer is in and set the cursor position to the bottom.
        local buffer_window = vim.api.nvim_call_function("bufwinid", { buffer_number })
        local buffer_line_count = vim.api.nvim_buf_line_count(buffer_number)
        vim.api.nvim_win_set_cursor(buffer_window, { buffer_line_count, 0 })
    end
end

local function open_buffer()
    -- Get a boolean that tells us if the buffer number is visible anymore.
    --
    -- :help bufwinnr
    local buffer_visible = vim.api.nvim_call_function("bufwinnr", { buffer_number }) ~= -1

    if buffer_number == -1 or not buffer_visible then
        -- Create a new buffer with the name "AUTOTEST_OUTPUT".
        -- Same name will reuse the current buffer.
        vim.api.nvim_command("botright vsplit AUTOTEST_OUTPUT")
        -- Collect the buffer's number.
        buffer_number = vim.api.nvim_get_current_buf()
        -- Mark the buffer as readonly.
        vim.opt_local.readonly = true
    end
end

local unrealEnginePath = '/home/wenhaoxiong/software/unreal/UnrealEngine-5.4.4-release/';
local unrealBuildToolPath = unrealEnginePath .. 'Engine/Binaries/DotNET/UnrealBuildTool/';
local unrealProjectPath = '/mnt/c/Users/wenhaoxiong/Documents/Unreal Projects/';

function M.generateCommands(opts)


    local uProjectFileName = vim.fn.glob('*.uproject')
    local isUnrealProject = string.len(uProjectFileName) ~= 0
    if isUnrealProject then
        local unrealProjectName = string.gsub(uProjectFileName, ".uproject", "")
        local cmd = './UnrealBuildTool -mode=GenerateClangDatabase -NoExecCodeGenActions -project="' .. unrealProjectPath .. unrealProjectName .. unrealProjectName .. '.uproject" -game  -engine ' .. unrealProjectName .. 'Editor DebugGame Linux';

        open_buffer();

        vim.fn.jobstart(cmd, {
            cwd = unrealBuildToolPath,
            on_exit = function ()
                callback(unrealProjectPath .. unrealProjectName)
            end,
            on_stdout = log,
            on_stderr = log,
        })
    else
        print("not a unreal project")
    end

end

function callback(projectPath)
    print("callback start.")
    local cmd = 'cp ' .. '\'' .. unrealEnginePath .. 'compile_commands.json\' ' .. '\'' .. projectPath .. '\'';
    print(cmd)

    vim.fn.jobstart(cmd, {
        cwd = unrealEnginePath,
        on_exit = function () end,
        on_stdout = function () end,
        on_stderr = function () end,
    })
end


return M;
