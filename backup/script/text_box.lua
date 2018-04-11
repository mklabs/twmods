local Log = require("uic/log");
local Util = require("uic/util");
local Components = require("uic/components");
local TextBox = {} --# assume TextBox: TEXT_BOX


-- function UI:createPositionPanelOld()
--   log('Creating position panel');
--   local existingFrame = Util.getComponentWithName('positionPanel');
--   if existingFrame then
--     log('Frame is already existing, assume existing frame: BUTTON');
--     existingFrame:SetVisible(true);
--     return;
--   end;
--
--   log('Creating panel');
--   local panel = Frame.new('positionPanel');
--   local parent = panel:GetContentPanel();
--   panel:Scale(1.5);
--   panel:Resize(600, 700);
--   panel:SetTitle('Starting position');
--   Util.centreComponentOnScreen(panel);
--   log('Panel created');
--
--   log('Creating elements');
--   local title = Text.new('position_title', parent, 'NORMAL', 'Define your starting position:');
--   title:PositionRelativeTo(parent, 20, 20);
--
--   local label_x = Text.new('label_x', parent, 'NORMAL', 'x');
--   label_x:PositionRelativeTo(title, 0, 40);
--   local input_pos_x = TextBox.new('position_x', parent);
--   input_pos_x:Resize(100, 30);
--   input_pos_x:PositionRelativeTo(label_x, 20, 0);
--
--   local label_y = Text.new('label_y', parent, 'NORMAL', 'y');
--   label_y:PositionRelativeTo(input_pos_x, 120, 0);
--   local input_pos_y = TextBox.new('position_y', parent);
--   input_pos_y:Resize(100, 30);
--   input_pos_y:PositionRelativeTo(label_y, 20, 0);
--   log('elements created');
--
--   log('createErrorText');
--   local errorText = Text.new('errorText', parent, 'NORMAL', 'Errors:');
--   errorText:PositionRelativeTo(label_x, 0, 40);
--   log('createErrorText done');
--
--   log('add close button');
--   panel:AddCloseButton(function()
--     local x = tonumber(input_pos_x:GetText());
--     local y = tonumber(input_pos_y:GetText());
--     log('Closed button, x:', x, input_pos_x:GetText());
--     log('Closed button, y:', y, input_pos_y:GetText());
--
--     if not x then
--       errorText.SetText('Invalid input value for x: ' .. x .. ' (must be a number)');
--       log('Invalid input for x must be a number', x);
--       return;
--     end;
--
--     if not y then
--       errorText.SetText('Invalid input value for y: ' .. y .. ' (must be a number)');
--       log('Invalid input for y must be a number', y);
--       return;
--     end;
--
--     log('values:', x, y);
--     log('Emit values for position event', x, y);
--     self:emit('position', x, y);
--     log('Delete panel');
--     panel:Delete();
--     log('Deleted panel');
--   end);
--
--   return panel;
-- end;
--
-- function UI:createFlowLayout(panel)
--   log('Setting up flow layout demo');
--   local mainContainer = UIContainer.new(FlowLayout.VERTICAL);
--   local firstButton = TextButton.new("firstButton", panel, "TEXT", "Button One");
--   local secondButton = TextButton.new("secondButton", panel, "TEXT", "Button Two");
--   local thirdButton = TextButton.new("thirdButton", panel, "TEXT", "Button Three");
--   mainContainer:AddComponent(firstButton);
--   mainContainer:AddComponent(secondButton);
--   mainContainer:AddGap(100);
--   mainContainer:AddComponent(thirdButton);
--
--   local horozontalContainer = UIContainer.new(FlowLayout.HORIZONTAL);
--   local firstHoroButton = TextButton.new("firstHoroButton", panel, "TEXT", "Button Four");
--   local containedVerticalContainer = UIContainer.new(FlowLayout.VERTICAL);
--   local firstContainedButton = TextButton.new("firstContainedButton", panel, "TEXT", "Button Five");
--   local secondContainedButton = TextButton.new("secondContainedButton", panel, "TEXT", "Button Six");
--   containedVerticalContainer:AddComponent(firstContainedButton);
--   containedVerticalContainer:AddComponent(secondContainedButton);
--   horozontalContainer:AddComponent(firstHoroButton);
--   horozontalContainer:AddGap(100);
--   horozontalContainer:AddComponent(containedVerticalContainer);
--   mainContainer:AddComponent(horozontalContainer);
--   Util.centreComponentOnComponent(mainContainer, panel);
--   log('Flow layout demo init done');
-- end;
--
-- return UI;

--v function(name: string, parent: CA_UIC | COMPONENT_TYPE) --> TEXT_BOX
function TextBox.new(name, parent)
    local parentComponent = Components.getUiContentComponent(parent);
    local textBox = Util.createComponent(name, parentComponent, "ui/common ui/text_box");

    local self = {};
    setmetatable(self, {
        __index = TextBox
    })
    --# assume self: TEXT_BOX
    self.uic = textBox --: const
    self.name = name --: const
    Util.registerComponent(name, self);
    return self;
end

-- Component functions

--v function(self: TEXT_BOX, xPos: number, yPos: number)
function TextBox.MoveTo(self, xPos, yPos)
    self.uic:MoveTo(xPos, yPos);
end

--v function(self: TEXT_BOX, xMove: number, yMove: number)
function TextBox.Move(self, xMove, yMove)
    Components.move(self.uic, xMove, yMove);
end

--v function(self: TEXT_BOX, component: CA_UIC | COMPONENT_TYPE, xDiff: number, yDiff: number)
function TextBox.PositionRelativeTo(self, component, xDiff, yDiff)
    Components.positionRelativeTo(self.uic, component, xDiff, yDiff);
end

--v function(self: TEXT_BOX, factor: number)
function TextBox.Scale(self, factor)
    Components.scale(self.uic, factor);
end

--v function(self: TEXT_BOX, width: number, height: number)
function TextBox.Resize(self, width, height)
    Components.resize(self.uic, width, height);
end

--v function(self: TEXT_BOX) --> (number, number)
function TextBox.Position(self)
    return self.uic:Position();
end

--v function(self: TEXT_BOX) --> (number, number)
function TextBox.Bounds(self)
    return self.uic:Bounds();
end

--v function(self: TEXT_BOX) --> number
function TextBox.XPos(self)
    local xPos, yPos = self:Position();
    return xPos;
end

--v function(self: TEXT_BOX) --> number
function TextBox.YPos(self)
    local xPos, yPos = self:Position();
    return yPos;
end

--v function(self: TEXT_BOX) --> number
function TextBox.Width(self)
    local width, height = self:Bounds();
    return width;
end

--v function(self: TEXT_BOX) --> number
function TextBox.Height(self)
    local width, height = self:Bounds();
    return height;
end

--v function(self: TEXT_BOX, visible: boolean)
function TextBox.SetVisible(self, visible)
    return self.uic:SetVisible(visible);
end

--v function(self: TEXT_BOX) --> boolean
function TextBox.Visible(self)
    return self.uic:Visible();
end

--v function(self: TEXT_BOX) --> CA_UIC
function TextBox.GetContentComponent(self)
    return self.uic;
end

--v function(self: TEXT_BOX) --> CA_UIC
function TextBox.GetPositioningComponent(self)
    return self.uic;
end

--v function(self: TEXT_BOX)
function TextBox.Delete(self)
    Util.delete(self.uic);
    Util.unregisterComponent(self.name);
end

-- Custom functions

--v function(self: TEXT_BOX) --> string
function TextBox.GetText(self)
    return self.uic:GetStateText();
end

return {
    new = TextBox.new;
}
