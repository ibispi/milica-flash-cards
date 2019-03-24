function drawGFX ()

	function refreshScreen ()--this should happen whenever the window size is
		--changed or the mode is changed from full screen to windowed
		local w = love.graphics.getWidth()
		local h = love.graphics.getHeight()
		local totalRatio = game.defaultCanvasSize.x/game.defaultCanvasSize.y
		ww = h*totalRatio
		if ww>w then
		while ww>w do
			ww=ww-0.1
		end
		hh=ww/totalRatio
		else hh = h end
		sx = ww/game.defaultCanvasSize.x
		sy = hh/game.defaultCanvasSize.y
		yy = (1-(hh/h))/2*h
		xx = (1-(ww/w))/2*w
	end

	refreshScreen()

		love.graphics.setBackgroundColor( 0, 0.05, 0, 1.0 ) --back-background color
		setColorOld( 255, 255, 255, 255 )

		love.graphics.setBlendMode('alpha', 'premultiplied')

		--effect(function()

			love.graphics.draw(defaultCanvas,xx,yy,0,sx,sy)

			

		--end)

		--love.graphics.draw(awesomecanvas,0,0,0,zoom,zoom)
		--love.graphics.draw(buttonCanvas,0,0,0,zoom,zoom)
		--love.graphics.draw(buttonCanvas,xx,yy,0,sx,sy)


		setColorOld( 0, 0, 0, 255 )


		love.graphics.setBlendMode('alpha', 'alphamultiply')
--[[temporarilyhere, this below
		love.graphics.setFont(randomfont)
		setColorOld(0,0,0,255)
		love.graphics.print(printMeThis, 10, 10)
		setColorOld(255,255,255,255)]]
end

return drawGFX
