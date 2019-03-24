function checkTableForVariable (tableName, wantedVariable)
--------------------------------------------------------------------------------
if tableName ~= nil and tableName[1] ~= nil then
  for tableCount = 1, #tableName, 1 do
    if tableName[tableCount] == wantedVariable then
      return true
    end
  end
end

return false

--------------------------------------------------------------------------------
end
return checkTableForVariable
