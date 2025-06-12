local M = {}
local Versions = {}

-- local unrealEnginePath = '/home/wenhaoxiong/software/unreal/UnrealEngine-5.4.4-release/';
-- local unrealEnginePathWin = '/mnt/c/Program Files/Epic Games/UE_5.4/'
-- local unrealBuildToolPath = unrealEnginePath .. 'Engine/Binaries/DotNET/UnrealBuildTool/';
-- local unrealEditorPathWin = unrealEnginePathWin .. 'Engine/Binaries/Win64/';
-- local unrealBuildToolPathWin = unrealEnginePathWin .. 'Engine/Binaries/DotNET/UnrealBuildTool/'

local unrealEditorPathSuffix = 'Engine/Binaries/Win64/'
local unrealBuildToolPathSuffix = 'Engine/Binaries/DotNET/UnrealBuildTool/';

local function getCurrentProjectVersion()
    return '5.6'
end

function M.setUpVersionsConfig(opts)
    opts = {
        {
            version = "5.5",
            path = "test1"
        },
        {
            version = "5.6",
            path = "F:/EpicGames/UE_5.6/"
        },
    }
    -- for i, x in pairs(opts) do
    --     for key, path in pairs(x) do
    --         local item = {}
    --
    --         table.insert(Versions, ve, path)
    --         Versions.insert(version, path)
    --     end
    -- end
    Versions = opts
end

function M.getUnrealEditorPath()
    for _, x in pairs(Versions) do
        if x.version == getCurrentProjectVersion() then
            return x.path .. unrealEditorPathSuffix
        end
    end

    return nil;
end

function M.getUnrealBuildToolPath()
    for _, x in pairs(Versions) do
        if x.version == getCurrentProjectVersion() then
            return x.path .. unrealBuildToolPathSuffix
        end
    end

    return nil;
end

function M.getUnrealEnginePath()
    for _, x in pairs(Versions) do
        if x.version == getCurrentProjectVersion() then
            return x.path
        end
    end

    return nil;
end

return M;
