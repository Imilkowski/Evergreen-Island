--!Type(UI)

local UIManagerModule = require("UIManagerModule")
local SaveModule = require("SaveModule")
local Database = require("Database")
local SessionModule = require("SessionModule")

--!Bind
local _ToolsParent: VisualElement = nil

function self:Start()
    SetCurrentTool(SessionModule.GetCurrentTool())
end

function SetCurrentTool(toolName)
    --check if has a tool

    _ToolsParent:Clear()

    local _toolButton = Image.new();
    _toolButton.image = Database.GetToolIcon(toolName)
    _toolButton:AddToClassList("tool-button")
    _toolButton:AddToClassList("current-tool")

    _ToolsParent:Add(_toolButton)

    -- Register a callback for when the button is pressed
    _toolButton:RegisterPressCallback(function()
        ShowAvailableTools()
    end)
end

function SelectTool(toolName)
    print(toolName)
    SessionModule.SetCurrentTool(toolName)
    SetCurrentTool(toolName)
end

function ShowAvailableTools()
    _ToolsParent:Clear()

    currentTool = SessionModule.GetCurrentTool()
    tools = SaveModule.GetTools()

    for k, v in pairs(tools) do
        local _toolButton = Image.new();
        _toolButton.image = Database.GetToolIcon(k)
        _toolButton:AddToClassList("tool-button")

        if(k  == currentTool) then 
            _toolButton:AddToClassList("current-tool")
        else
            _toolButton:AddToClassList("available-tool")
        end

        _ToolsParent:Add(_toolButton)

        -- Register a callback for when the button is pressed
        _toolButton:RegisterPressCallback(function()
            SelectTool(k)
        end)
    end
end