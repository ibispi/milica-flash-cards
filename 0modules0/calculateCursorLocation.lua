function calculateCursorLocation ()
--------------------------------------------------------------------------------

  local xCursor, yCursor = 0, 0
  if currentOS == "Android" then
    local touches = love.touch.getTouches()

    for i, id in ipairs(touches) do
        xCursor, yCursor = love.touch.getPosition(id)
    end
  else
    xCursor, yCursor = love.mouse.getPosition()
  end

  xCursor = xCursor/sx-xx/sx
  yCursor = yCursor/sy-yy/sy


  return xCursor, yCursor

--------------------------------------------------------------------------------
end
return calculateCursorLocation
