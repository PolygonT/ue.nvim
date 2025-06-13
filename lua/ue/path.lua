local M = {}
local Versions = {}

-- local unrealEnginePath = '/home/wenhaoxiong/software/unreal/UnrealEngine-5.4.4-release/';
-- local unrealEnginePathWin = '/mnt/c/Program Files/Epic Games/UE_5.4/'
-- local unrealBuildToolPath = unrealEnginePath .. 'Engine/Binaries/DotNET/UnrealBuildTool/';
-- local unrealEditorPathWin = unrealEnginePathWin .. 'Engine/Binaries/Win64/';
-- local unrealBuildToolPathWin = unrealEnginePathWin .. 'Engine/Binaries/DotNET/UnrealBuildTool/'

local unrealEditorPathSuffix = 'Engine/Binaries/Win64/'
local unrealBuildToolPathSuffix = 'Engine/Binaries/DotNET/UnrealBuildTool/';
local currentProjectVersion = nil

local function getCurrentProjectVersion()
    if currentProjectVersion ~= nil then
        return currentProjectVersion
    end

    local uProjectFileName = vim.fn.glob('*.uproject')
    local input = assert(io.open(uProjectFileName, "r"))
    local jsonStr = input:read("*all")
    local jsonTable = vim.json.decode(jsonStr)
    currentProjectVersion = jsonTable.EngineAssociation
    return currentProjectVersion
end

function M.setUpVersionsConfig(opts)
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
