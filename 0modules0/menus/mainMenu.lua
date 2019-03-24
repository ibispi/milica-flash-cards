function loadMainMenu ()


	persistence.store(saveLocation.."milicaFlashCards/flashCardSaves/"..currentDeckName..".lua", currentDeck)
	--------------------------------------------------------------------------------
	flashCardCanvas = ui.newCanvas(1920*0.05,1080*0.05,1920*0.95,1080*0.85) --make a UI canvas

	ui.setCanvas (flashCardCanvas) --set the canvas in order to add elements to it

	local hoverSFX = love.audio.newSource("hover.ogg", 'static')--add sound effects
	local clickSFX = love.audio.newSource("click.ogg", 'static')
	ui.setSFX(hoverSFX, clickSFX)

	ui.setRowHeight(50) --sets the height of a row
	ui.setLineSpacing(50) --sets the distance between rows

	ui.setBackgroundColor ({10, 90, 10, 255},
	{0, 20, 0, 100})--background and outline color

	ui.setBackgroundOutlineThickness (1) --thickness of the background outline

	ui.setButtonOffset(35,5) --first button offset from the window

	ui.setElementSpacing(5, 30) --1st argument is automatic spacing, the second is
	--when you insert a space with ui.addSpace() function

	ui.setButtonRoundness(0.0) --the roundness of buttons

	ui.enableOutline() --enables outline

	ui.setOutlineThickness(5) --sets outline thickness to 5

	ui.setButtonWidth(500) --sets button width

	ui.setTextAlignment('center') --the alignment of text on the buttons

	ui.setFont(defaultFont, {10,10,10,255}, {0,0,0,255}, {50,200,50,255})
	--sets the font for the UI, its 1. normal color, its 2. hover color and
	--its 3. color when clicked

	ui.setTextOffset (10,10) --x and y offset of the text of the buttons

	ui.setColor[1] ({150,150,150,255},{170,170,170,255},{0,0,0,255})
	ui.setColor[2] ({0,0,0,255},{125,125,125,255},{255,255,255,255})
	ui.setColor[3] ({125,125,125,255},{255,255,255,255},{0,0,0,255})
	ui.setColor[4] ({0,0,0,255},{125,125,125,255},{255,255,255,255})
	--sets the colors for the ui

	ui.setColorVerticalSlider[1] ( {0,20,0,255}, {30,60,0,255}, {0,20,0,255} )
	ui.setColorVerticalSlider[2] ( {0,0,0,255}, {10,10,10,255}, {40,40,40,255} )
	ui.setColorVerticalSlider[3] ( {0,200, 0,255}, {100,225,0,255}, {200,255,0,255} )
	ui.setColorVerticalSlider[4] ( {0,20,0,255}, {30,60,0,255}, {0,20,0,255} )


	ui.setTextBoxWidth(500)
	ui.allowOnlyNumbers(false)

	ui.addSlider.vertical ( 'right', 50 )

	ui.addLabel ( "Current Deck: "..currentDeckName, true )
	ui.addSpace(50)

	ui.addTooltip("Restore an old flash card test or start a new one!")
	ui.addButton("<<Open Another Flash Card Deck Here>>")
	ui.addNewLine()
	ui.addLabel ( "Flash Cards:", true )
	ui.addNewLine()

	ui.setPotentialTableSources ( {"cardTexts"})

	cardTexts = {}

	for currentCardNum = 1, #currentDeck, 1 do

		imageData = currentDeck[currentCardNum]['imageData']
		imageName = currentDeck[currentCardNum]['imageName']
		cardTexts[#cardTexts+1] = currentDeck[currentCardNum]['text']

		if imageName ~= 'EMPTY' then
			currentDeck[currentCardNum]['imageData'] = love.graphics.newImage("images/"..imageName)
		end

		--this below is one flash card...
		ui.addLabel ( currentCardNum, true )
		ui.addSpace(100)

		ui.setButtonWidth(50)
		ui.addTooltip("Remove This Flash Card")
		ui.addButton("- "..currentCardNum)
		ui.setButtonWidth(500)
		ui.addSpace(20)

		ui.addLabel ( "text:", false )
		ui.addTooltip("The Text You Have To Type In")
		ui.addTextBox (#cardTexts)
		ui.addSpace(40)
		ui.addTooltip("Select an Appropriate Image for this Flash Card")
		ui.addLabel ( "image:", false )
		ui.setButtonWidth(300)
		ui.addButton("<insert an image "..currentCardNum.." >")
		ui.setButtonWidth(500)
		ui.addSpace(20)
		ui.addLabel ( imageName, false )


		ui.addNewLine()

	end

	ui.addTooltip("Add A New Flash Card")
		ui.addSpace(500)
	ui.addButton("+")



	--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
mainMenuCanvas = ui.newCanvas(1920*0.3,1080*0.9,1920*0.6,1080*1.0) --make a UI canvas

ui.setCanvas (mainMenuCanvas) --set the canvas in order to add elements to it

local hoverSFX = love.audio.newSource("hover.ogg", 'static')--add sound effects
local clickSFX = love.audio.newSource("click.ogg", 'static')
ui.setSFX(hoverSFX, clickSFX)

ui.setRowHeight(50) --sets the height of a row
ui.setLineSpacing(50) --sets the distance between rows

ui.setBackgroundColor ({0, 125, 0, 100},
{0, 20, 0, 100})--background and outline color

ui.setBackgroundOutlineThickness (1) --thickness of the background outline

ui.setButtonOffset(35,5) --first button offset from the window

ui.setElementSpacing(5, 30) --1st argument is automatic spacing, the second is
--when you insert a space with ui.addSpace() function

ui.setButtonRoundness(0.2) --the roundness of buttons

ui.enableOutline() --enables outline

ui.setOutlineThickness(5) --sets outline thickness to 5

ui.setButtonWidth(500) --sets button width

ui.setTextAlignment('center') --the alignment of text on the buttons

ui.setFont(defaultFont, {30,30,30,255}, {0,0,0,255}, {255,255,255,255})
--sets the font for the UI, its 1. normal color, its 2. hover color and
--its 3. color when clicked

ui.setTextOffset (10,10) --x and y offset of the text of the buttons

ui.setColor[1] ({150,150,150,255},{170,170,170,255},{0,0,0,255})
ui.setColor[2] ({0,0,0,255},{125,125,125,255},{255,255,255,255})
ui.setColor[3] ({125,125,125,255},{255,255,255,255},{0,0,0,255})
ui.setColor[4] ({0,0,0,255},{125,125,125,255},{255,255,255,255})
--sets the colors for the ui

ui.addTooltip("Click here to test your knowledge!")
ui.addButton("Test yourself, Milica!")
ui.addNewLine()

--------------------------------------------------------------------------------
end
return loadMainMenu
