function loadFolder (folderName)

local files = love.filesystem.getDirectoryItems(folderName)
return files
end

return loadFolder
