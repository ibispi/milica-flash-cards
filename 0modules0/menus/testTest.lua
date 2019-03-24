function testTest (previousAnswer, correctOrNotString, correctAnswerString)


	luckyWinner = currentDeck[math.random(#currentDeck)]

	currentCorrectAnswer = luckyWinner['text']

	testIsOn = true


	currentAnswer = previousAnswer
	correctOrNotString = correctOrNotString
	correctAnswerString = correctAnswerString
	--------------------------------------------------------------------------------
	testCanvas = ui.newCanvas(1920*0.0,1080*0.0,1920*1.0,1080*1.0) --make a UI canvas

	ui.setCanvas (testCanvas) --set the canvas in order to add elements to it

	local hoverSFX = love.audio.newSource("hover.ogg", 'static')--add sound effects
	local clickSFX = love.audio.newSource("click.ogg", 'static')
	ui.setSFX(hoverSFX, clickSFX)

	ui.setRowHeight(50) --sets the height of a row
	ui.setLineSpacing(50) --sets the distance between rows

	ui.setBackgroundColor ({50, 90, 50, 255},
	{0, 20, 0, 255})--background and outline color

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

	if previousAnswer == "" then
		ui.addTooltip("Type Your Answer And Then Click The CHECK Button")
		ui.addButton("CHECK")
		ui.addTextBox("currentAnswer")
	else
		ui.addTooltip("Click the NEXT Button To Move Onto Next Flash Card")
		ui.addButton("NEXT")
		ui.addLabel("your previous answer: "..previousAnswer, false)
	end

	ui.addSpace(100)
	ui.addButton("Stop Testing")
	ui.addNewLine()

	ui.addLabel ( "Correct or Not?:", true )
	ui.addSpace(30)
	ui.addLabel ( correctOrNotString, false )
	ui.addNewLine()

	ui.addLabel ( "Correct Answer:", true )
	ui.addSpace(30)
	ui.addLabel ( correctAnswerString, false )
	ui.addNewLine()

	if previousAnswer == "" then
		testingImageToBeDrawn = luckyWinner['imageData']
	end

	--if luckyWinner['imageData'] ~= 'nothing' then
	--	ui.addImageLabel ( luckyWinner['imageData'] )
	--end




	--------------------------------------------------------------------------------

end
return testTest
