-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here
rectBorder=nil
rectEdit=nil
lblTitle=nil
editBuffer=nil
function drawBorder(x,y,width,height)
		rectBorder = display.newRect(x,y,width,height)
		rectBorder.strokeWidth = 5
		rectBorder:setFillColor( 0, 0 , 0, 0.5 )
		rectBorder:setStrokeColor( 1, 1, 1 )
end
editBuffer=nil
function drawInputPrompt(x,y,width,height,prompt)
		lblTitle = display.newText( prompt, x, y, "fonts/ume-tgc5.ttf", 50 )
		lblTitle:setFillColor( 0.82, 0.86, 1 )
		editBuffer = display.newText( "", x, y+200, "fonts/ume-tgc5.ttf", 50 )
		editBuffer:setFillColor( 0.82, 0.86, 1 )
		rectEdit = display.newRect(x,y+200,width-500,height-700)
		rectEdit.strokeWidth = 5
		rectEdit:setFillColor( 1, 1 , 1, 0.5 )
		rectEdit:setStrokeColor( 1, 1, 1 )
end

function removerInputBox()
	rectBorder:removeSelf()
	rectEdit:removeSelf()
	lblTitle:removeSelf()
	editBuffer:removeSelf()
	okButton:removeSelf()
end

drawBorder(display.contentCenterX, display.contentCenterY, 1000-100, 800-50)
drawInputPrompt(display.contentCenterX, display.contentCenterY, 1000-100, 800-50,"Enter your input:")

--handle keystrokes
downkey=""
inputBuffer=""
local action = {}
function frameUpdate()
	local keyDown = false
	-- See if one of the selected action buttons is down and move the knight.
	if downkey == "enter" then
		print("inputBuffer:"..inputBuffer)
		inputBuffer=""
		downkey=""
		removerInputBox()
	end
	if downkey == "deleteBack" then
		inputBuffer = inputBuffer:sub(1, -2)--deletes last character off the buffer
		print("delete pressed")
		downkey=""
	end

	if downkey == "escape" then
		inputBuffer = ""
		print("escape pressed")
		downkey=""
	end

	if downkey == "space" then
		inputBuffer = inputBuffer .. " "
		print("space pressed")
		downkey=""
	end

	if downkey == "unknown" then
		print("unknown key pressed")
		downkey=""
		return
	end
		
	if downkey ~= "" then
		print("downkey:"..downkey)
		inputBuffer=inputBuffer..downkey
		downkey=""
	end
	
	editBuffer.text=inputBuffer
end

function onKeyEvent( event )
	if event.phase == "down" then
	else
		downkey=event.keyName
	end
end
--help button
webView=nil
function myHelpTouchListener( event )
	print("ok clicked!")
	removerInputBox()
    return true  -- Prevents tap/touch propagation to underlying objects
end

offsetx=100
offsety=100

local paint = {
    type = "image",
    filename = "img/ok.png"
}
okButton = display.newRect(offsetx, offsety, 150, 150 )
okButton.fill = paint

okButton:addEventListener( "touch", myHelpTouchListener )  -- Add a "touch" listener to the obj

local paint = {
    type = "image",
    filename = "img/ok.png"
}
myHelpCloseButton = display.newRect(offsetx, offsety, 150, 150 )
myHelpCloseButton.fill = paint

myHelpCloseButton:addEventListener( "touch", myHelpTouchListener )  -- Add a "touch" listener to the obj
myHelpCloseButton.isVisible=false
if system.getInfo("platform")=="html5" then
	okButton.isVisible=false
else
	okButton.isVisible=true
end

Runtime:addEventListener( "enterFrame", frameUpdate )
Runtime:addEventListener( "key", onKeyEvent )
