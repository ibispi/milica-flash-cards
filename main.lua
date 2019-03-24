--Copyright 2018 Ibispi

--the main file

function love.load()
	testingImageToBeDrawn = 'nothing'
	saveLocation = ""

	currentCorrectAnswer = ""

	currentAnswer = ""

	newDeckNameVar = "New Deck Name"

	currentDeckName = "Welcome!"
	loadingDecks = false
	loadingImages = false
	loadingImageForCard = 0

	currentDeck = {

			{ imageData = 'nothing', imageName = 'EMPTY', text = 'Flash Card Text', },

								}




	require "0modules0.initiateProgram" initiateProgram()

	--effect = moonshine(moonshine.effects.vignette)
	--effect.vignette.opacity = 0.3

	--backgroundTest = love.graphics.newImage("backgroundTest.png") --TO BE REMOVED

	testIsOn = false

end

function love.mousereleased(x, y, button, isTouch)

	local mouseX, mouseY = calculateCursorLocation()

	if testIsOn == false then
		if loadingImages == false and loadingDecks == false then
			ui.updateMouseClick (mainMenuCanvas, mouseX, mouseY)
			ui.updateMouseClick (flashCardCanvas, mouseX, mouseY)
		else
			if loadingImages == true then
				ui.updateMouseClick (imageLoadingCanvas, mouseX, mouseY)
			elseif loadingDecks == true then
				ui.updateMouseClick (deckLoadingCanvas, mouseX, mouseY)
			end
		end
	else
		ui.updateMouseClick (testCanvas, mouseX, mouseY)
	end

	--if charCreationOn == true then

	--	ui.updateMouseClick (charCreationCanvas, mouseX, mouseY)
	--end

end



function love.update(dt)
--------------------------------------------------------------------------------
	if ui.hoveringOverRPGVariables ~= nil then
		if ui.hoveringOverRPGVariables[1] ~= nil then
			ui.hoveringOverRPGVariables = {}
		end
	end

	if loadingImages == true then

		imagesThatCanBeLoaded = love.filesystem.getDirectoryItems( "images" )

		for anImg = 1, #imagesThatCanBeLoaded, 1 do

			if ui.clicked(imagesThatCanBeLoaded[anImg], imageLoadingCanvas) then
				currentDeck[loadingImageForCard]['imageName'] = imagesThatCanBeLoaded[anImg]
				loadingImages = false
				loadMainMenu()
				break
			end

		end

	end

	if testIsOn == true then
		if ui.clicked("Stop Testing", testCanvas) then
			testIsOn = false
			loadMainMenu()
		end

		if ui.clicked("CHECK", testCanvas) then
			correctOrNotStr = "TRUE"
			if currentCorrectAnswer ~= currentAnswer then
				correctOrNotStr = "FALSE"
			end

			testTest(currentAnswer, correctOrNotStr, currentCorrectAnswer)
		end

		if ui.clicked("NEXT", testCanvas) then
			testTest("", "", "")
		end

	end

	if loadingDecks == true then

		savesThatCanBeLoaded = love.filesystem.getDirectoryItems( "flashCardSaves" )

		for aDeckNum = 1, #savesThatCanBeLoaded, 1 do

			if ui.clicked(savesThatCanBeLoaded[aDeckNum], deckLoadingCanvas) then

				currentDeck = persistence.load(saveLocation.."milicaFlashCards/flashCardSaves/"..savesThatCanBeLoaded[aDeckNum])

				for aCard = 1, #currentDeck, 1 do
					currentDeck[aCard]['imageData'] = love.graphics.newImage("images/"..currentDeck[aCard]['imageName'])
				end

				currentDeckName = string.sub(savesThatCanBeLoaded[aDeckNum], 0, -5)
				loadingDecks = false
				loadMainMenu()
				break

			end
		end

		if ui.clicked("Add This Deck", deckLoadingCanvas) then
			if newDeckNameVar ~= "" then
				currentDeckName = newDeckNameVar
				loadingDecks = false
				loadMainMenu()
			end
		end

	end


	if testIsOn == false and loadingImages == false and loadingDecks == false then



		if ui.clicked("<<Open Another Flash Card Deck Here>>",flashCardCanvas) then

			for aCard = 1, #currentDeck, 1 do
				currentDeck[aCard]['text'] = cardTexts[aCard]
			end

			persistence.store(saveLocation.."milicaFlashCards/flashCardSaves/"..currentDeckName..".lua", currentDeck)

			newDeckNameVar = "New Deck Name"

			loadingDecks = true

		end

		for currentCardNum = 1, #currentDeck, 1 do

			imageData = currentDeck[currentCardNum]['imageData']
			imageName = currentDeck[currentCardNum]['imageName']
			cardTexts[#cardTexts+1] = currentDeck[currentCardNum]['text']

			if ui.clicked("- "..currentCardNum, flashCardCanvas) then
				table.remove(cardTexts, currentCardNum)
				table.remove(currentDeck, currentCardNum)
				loadMainMenu()
				break
			end

			if ui.clicked("<insert an image "..currentCardNum.." >", flashCardCanvas) then
				loadingImages = true
				loadingImageForCard = currentCardNum
				loadImageLoading()
				break
			end

		end


		if ui.clicked("+", flashCardCanvas) then
			currentDeck[#currentDeck+1] = { imageData = 'nothing', imageName = 'EMPTY', text = 'Flash Card Text', }
			loadMainMenu()
		end

		if ui.clicked("Test yourself, Milica!", mainMenuCanvas) then
			testTest("", "", "")
		end
	end


	timerCheck()

	love.graphics.setCanvas(defaultCanvas)
	love.graphics.clear()


	setColorOld()
	ui.tooltipToBeDrawn = nil

	local mouseX, mouseY = calculateCursorLocation()--for mouse over...

	--love.graphics.draw(backgroundTest) --TO BE REMOVED

	if testIsOn == true then

		ui.drawCanvas (testCanvas, mouseX, mouseY)

	else

		if loadingImages == false and loadingDecks==false then

			ui.drawCanvas (mainMenuCanvas, mouseX, mouseY)
			ui.drawCanvas (flashCardCanvas, mouseX, mouseY)

		else

			if loadingImages == true then
				ui.drawCanvas (imageLoadingCanvas, mouseX, mouseY)
			elseif loadingDecks == true then
				ui.drawCanvas (deckLoadingCanvas, mouseX, mouseY)
			end

		end

	end





--tool tips are drawn here:
	if ui.tooltipToBeDrawn ~= nil then
		ui.drawTooltip(ui.tooltipToBeDrawn.tooltipText,
		ui.tooltipToBeDrawn.mouseX,
		ui.tooltipToBeDrawn.mouseY)
	end


	if testIsOn and testingImageToBeDrawn~='nothing' then

		heightOfImg = testingImageToBeDrawn:getPixelHeight( )
		widthOfImg = testingImageToBeDrawn:getPixelWidth( )

		heightThatIsWanted = 1080*0.9-1080*0.3
		widthThatIsWanted = 1920*0.7-1920*0.3

		theScaleX = widthThatIsWanted/widthOfImg
		theScaleY = heightThatIsWanted/heightOfImg
		love.graphics.draw(testingImageToBeDrawn, 1920*0.3, 1080*0.3, 0, theScaleX, theScaleY)
	end
--------------------------------------------------------------------------------
	love.graphics.setCanvas()

--------------------------------------------------------------------------------


end

function love.keypressed(key, unicode)
	ui.updateKeyboardPressed(key)

	for aCard = 1, #currentDeck, 1 do
		currentDeck[aCard]['text'] = cardTexts[aCard]
	end

	persistence.store(saveLocation.."milicaFlashCards/flashCardSaves/"..currentDeckName..".lua", currentDeck)
end


function love.textinput( key )
	ui.updateKeyboardInput( key )
end


function love.draw()
	drawGFX()
end
