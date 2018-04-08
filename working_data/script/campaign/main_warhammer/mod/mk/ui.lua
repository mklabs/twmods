local log = require('mk/log')('mk:ui');
log('UI file loaded');

local UI = {
  cm = false,
  core = false,
  uimf = false
};

function UI:new(cm, core, uimf)
  local ui = {};
  setmetatable(ui, self);
  self.__index = self;

  ui.cm = cm;
  ui.core = core;
  ui.uimf = uimf;

  self:setupListeners();
  return ui;
end;

function UI:setupListeners()
  local core = self.core;
  log('Setting up listeners');
  core:add_listener('createFrame', 'ShortcutTriggered', self.isDefaultF11, self.demoUI, true);
end;

function UI:isDefaultF11(context)
  log('Checking condition' .. context.string);
  return context.string == 'camera_bookmark_view2';
end;

function UI:demoUI()
  log('Creating demoUI');

  local cm = self.cm;
  local Util, Frame, Text, Image, Button, TextButton, TextBox = self.uimf;

  log('Getting frame');
  local existingFrame = Util.getComponentWithName('MyFrame');

  if existingFrame then
    log('Frame is already existring, assume existing frame: BUTTON');
    existingFrame:SetVisible(true);
  end;

  log('Create frame');
  local myFrame = Frame.new('MyFrame');
  myFrame:Scale(1.5);
  Util.centreComponentOnScreen(myFrame);
  myFrame:AddCloseButton();

  log('Create image');
  local images = Text.new('images', myFrame, 'NORMAL', 'Images');
  images:PositionRelativeTo(myFrame, 20, 20);
  local normalImage = Image.new('normalImage', myFrame, 'ui/skins/default/advisor_beastmen_2d.png');
  normalImage:PositionRelativeTo(images, 0, 20);
  local smallImage = Image.new('smallImage', myFrame, 'ui/skins/default/advisor_beastmen_2d.png');
  smallImage:Scale(0.5);
  smallImage:PositionRelativeTo(normalImage, 50, 0);
  local rotatedImage = Image.new('rotatedImage', myFrame, 'ui/skins/default/advisor_beastmen_2d.png');
  rotatedImage:SetRotation(math.pi / 2);
  rotatedImage:PositionRelativeTo(smallImage, 50, 0);
  local transparentImage = Image.new('transparentImage', myFrame, 'ui/skins/default/advisor_beastmen_2d.png');
  transparentImage:SetOpacity(50);
  transparentImage:PositionRelativeTo(rotatedImage, 50, 0);

  log('Create buttons');
  local buttons = Text.new('buttons', myFrame, 'NORMAL', 'Buttons');
  buttons:PositionRelativeTo(images, 0, 50);
  local squareButton = Button.new('squareButton', myFrame, 'SQUARE', 'ui/skins/default/icon_end_turn.png');
  squareButton:PositionRelativeTo(buttons, 0, 20);
  local circularButton = Button.new('circularButton', myFrame, 'CIRCULAR', 'ui/skins/default/icon_end_turn.png');
  circularButton:PositionRelativeTo(squareButton, 50, 0);
  local textButton = TextButton.new('textButton', myFrame, 'TEXT', 'customText');
  textButton:PositionRelativeTo(circularButton, 50, 0);

  log('Create resize button');
  local resizedSquareButton = Button.new('resizedSquareButton', myFrame, 'SQUARE', 'ui/skins/default/icon_end_turn.png');
  resizedSquareButton:Scale(0.5);
  resizedSquareButton:PositionRelativeTo(squareButton, 0, 50);
  local resizedCircularButton = Button.new('resizedCircularButton', myFrame, 'CIRCULAR', 'ui/skins/default/icon_end_turn.png');
  resizedCircularButton:Scale(0.5);
  resizedCircularButton:PositionRelativeTo(resizedSquareButton, 50, 0);
  local resizedTextButton = TextButton.new('resizedTextButton', myFrame, 'TEXT', 'customText');
  local width, height = resizedTextButton:Bounds();
  resizedTextButton:Resize(250, height);
  resizedTextButton:PositionRelativeTo(resizedCircularButton, 50, 0);

  local toggleButtons = Text.new('toggleButtons', myFrame, 'NORMAL', 'Toggle Buttons');
  toggleButtons:PositionRelativeTo(buttons, 0, 100);
  local squareToggleButton = Button.new('squareToggleButton', myFrame, 'SQUARE_TOGGLE', 'ui/skins/default/icon_end_turn.png');
  squareToggleButton:PositionRelativeTo(toggleButtons, 0, 20);
  local circularToggleButton = Button.new('circularToggleButton', myFrame, 'CIRCULAR_TOGGLE', 'ui/skins/default/icon_end_turn.png');
  circularToggleButton:PositionRelativeTo(squareToggleButton, 50, 0);
  local textToggleButton = TextButton.new('textToggleButton', myFrame, 'TEXT_TOGGLE', 'customText');
  textToggleButton:PositionRelativeTo(circularToggleButton, 50, 0);

  log('Create button logic');
  local buttonLogic = Text.new('buttonLogic', myFrame, 'NORMAL', 'Button Logic');
  buttonLogic:PositionRelativeTo(toggleButtons, 0, 70);
  local incrementButton = TextButton.new('incrementButton', myFrame, 'TEXT', '+');
  incrementButton:Resize(100, 51);
  incrementButton:PositionRelativeTo(buttonLogic, 0, 20);
  local decrementButton = TextButton.new('decrementButton', myFrame, 'TEXT', '-');
  decrementButton:Resize(100, 51);
  decrementButton:PositionRelativeTo(incrementButton, 100, 0);
  local counterText = Text.new('CounterText', myFrame, 'NORMAL', '0');
  counterText:PositionRelativeTo(decrementButton, 100, 0);
  incrementButton:RegisterForClick(
      function(context)
          local number = tonumber(counterText:GetText());
          if number < 8 then
              local newText = tostring(number + 1);
              counterText:SetText(newText);
          end
      end
  );
  decrementButton:RegisterForClick(
      function(context)
          local number = tonumber(counterText:GetText());
          if number > 0 then
              local newText = tostring(number - 1);
              counterText:SetText(newText);
          end
      end
  );

  log('Create toggleTextButton');
  local toggleTextButton = TextButton.new('toggleTextButton', myFrame, 'TEXT_TOGGLE', 'Custom text');
  toggleTextButton:PositionRelativeTo(counterText, 50, 0);
  toggleTextButton:RegisterForClick(
      function(context)
          cm:callback(
              function()
                  toggleTextButton:SetButtonText(tostring(toggleTextButton:IsSelected()));
              end, 0.1, 'toggleTextListenerText'
          )
      end
  );

  log('Create texts');
  local text = Text.new('text', myFrame, 'NORMAL', 'Text');
  text:PositionRelativeTo(buttonLogic, 0, 100);
  local greenText = Text.new('greenText', myFrame, 'NORMAL', '[[col:green]]This is green text[[/col]]');
  greenText:PositionRelativeTo(text, 0, 20);
  local iconText = Text.new('iconText', myFrame, 'NORMAL', '[[img:icon_arrow_up]][[/img]]This text has icons in[[img:icon_arrow_up]][[/img]]');
  iconText:PositionRelativeTo(greenText, 0, 20);
  local resizedText = Text.new('resizedText', myFrame, 'NORMAL', 'Small text');
  resizedText:Scale(0.5);
  resizedText:PositionRelativeTo(iconText, 0, 20);
  local wrappedText = Text.new('wrappedText', myFrame, 'WRAPPED', 'This is wrapped text. This is wrapped text. This is wrapped text. This is wrapped text. This is wrapped text. This is wrapped text. This is wrapped text. This is wrapped text. ');
  wrappedText:Resize(500, 200);
  wrappedText:PositionRelativeTo(resizedText, 0, 20);
  local titleText = Text.new('titleText', myFrame, 'TITLE', 'This is title text');
  titleText:PositionRelativeTo(wrappedText, 0, 70);

  log('Create textBox');
  local textBox = TextBox.new('textBox', myFrame);
  textBox:PositionRelativeTo(text, 0, 180);
  local textBoxButton = Button.new('textBoxButton', myFrame, 'CIRCULAR', 'ui/skins/default/icon_check.png');
  textBoxButton:PositionRelativeTo(textBox, 200, 0);
  local textBoxButtonText = Text.new('textBoxButtonText', myFrame, 'NORMAL', 'CUSTOM_TEXT');
  textBoxButtonText:PositionRelativeTo(textBoxButton, 50, 0);
  textBoxButton:RegisterForClick(
      function(context)
          textBoxButtonText:SetText(textBox.uic:GetStateText());
      end
  );

  log('Done creating demoUI');
end
