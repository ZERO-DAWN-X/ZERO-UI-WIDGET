function Initialize()
    local colorCount = 35  -- Total number of colors (added 3 new colors)
    local columns = 5      -- Number of columns in the grid
    local startY = 60      -- Starting Y position
    local startX = 35      -- Starting X position (adjusted for wider spacing)
    local spacing = 40     -- Spacing between dots (increased)
    
    -- Get the absolute path to the Includes folder
    local skinPath = SKIN:GetVariable('CURRENTPATH'):gsub('ThemeMenu\\$', '')
    local filePath = skinPath .. '@Resources\\Includes\\ColorGrid.inc'
    print("Writing to file: " .. filePath)
    
    local file = io.open(filePath, 'w')
    if not file then
        print("Error: Could not open file for writing")
        return
    end
    
    for i = 1, colorCount do
        local row = math.floor((i-1) / columns)
        local col = (i-1) % columns
        local x = startX + col * spacing
        local y = startY + row * spacing
        
        local meterName = string.format([[
[Color%dDot]
Meter=Shape
X=%d
Y=%d
Shape=Ellipse (#ColorDotSize#/2),#ColorDotSize#/2,#ColorDotSize#/2 | Fill Color #Color%d# | StrokeWidth 0 | Extend Glow
MouseOverAction=[!SetOption #CURRENTSECTION# Shape "Ellipse (#ColorDotSize#/2),#ColorDotSize#/2,(#ColorDotSize#/2 + 2) | Fill Color #Color%d# | StrokeWidth 0 | Extend GlowHover"][!UpdateMeter *][!Redraw]
MouseLeaveAction=[!SetOption #CURRENTSECTION# Shape "Ellipse (#ColorDotSize#/2),#ColorDotSize#/2,#ColorDotSize#/2 | Fill Color #Color%d# | StrokeWidth 0 | Extend Glow"][!UpdateMeter *][!Redraw]
LeftMouseUpAction=[!WriteKeyValue Variables TriggerBgColor "#Color%d#" "#ROOTCONFIGPATH#MyTheme\\Welcome.ini"][!RefreshGroup catppuccin][!DeactivateConfig]
DynamicVariables=1
Group=ColorDots
Glow=
GlowHover=Blur 4

]], i, x, y, i, i, i, i)
        
        file:write(meterName)
    end
    
    file:close()
    print("ColorGrid.inc file generated successfully")
end