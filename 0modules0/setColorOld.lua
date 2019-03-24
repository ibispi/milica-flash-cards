-- after love was updated to 11.1, color setting was changed from 0-255 to 0.0-1.0

function setColorOld (red, green, blue, alpha)
--------------------------------------------------------------------------------
if red == nil then

  love.graphics.setColor(1.0, 1.0, 1.0, 1.0)

elseif type(red) == "table" then

  local newRed = red[1]/255
  local newGreen = red[2]/255
  local newBlue = red[3]/255
  local newAlpha = red[4]/255

  love.graphics.setColor(newRed, newGreen, newBlue, newAlpha)

else

  local newRed = red/255
  local newGreen = green/255
  local newBlue = blue/255
  local newAlpha = alpha/255

  love.graphics.setColor(newRed, newGreen, newBlue, newAlpha)

end
--------------------------------------------------------------------------------
end
return setColorOld
