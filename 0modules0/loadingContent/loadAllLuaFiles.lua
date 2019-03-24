function loadAllLuaFiles (folderName)

  local additionalFolders = {}

  local function addAdditionalFolder (slashDir, requireDir)
    local additionalFolderTable = {slashDir = slashDir, requireDir = requireDir}
    table.insert (additionalFolders, additionalFolderTable)
  end

  ---------------------------------------------------------------------
  local bannedLuaFiles = {"tween_spec.lua", "loadingAllLuaFiles.lua",
  "boxblur.lua", "chromasep.lua", "colorgradesimple.lua", "crt.lua", "desaturate.lua", "dmg.lua",
  "fastgaussianblur.lua", "filmgrain.lua", "gaussianblur.lua", "glow.lua", "godsray.lua",
  "init.lua"}
  ---------------------------------------------------------------------

  local function searchForLuaFiles (currentDir)

    local files = love.filesystem.getDirectoryItems(additionalFolders[currentDir].slashDir)

    for i = 1, #files, 1 do
      local _ = files[i]:match(".lua")
      if _ ~= nil then
        local canPass = true
        for g = 1, #bannedLuaFiles, 1 do
          if files[i]== bannedLuaFiles[g] then
            canPass = false
          end
        end
        if canPass == true then
          local _ = files[i]:gsub(".lua", "")
          local __ = additionalFolders[currentDir].requireDir..".".._
          require (__)
        end
      else
        local _ = love.filesystem.getInfo(additionalFolders[currentDir].slashDir.."/"..files[i], 'directory')

        if _ ~= nil then
          local __ = additionalFolders[currentDir].slashDir.."/"..files[i]
          local _ = additionalFolders[currentDir].requireDir.."."..files[i]
          addAdditionalFolder(__, _)
        end
      end
    end

  end

  addAdditionalFolder (folderName, folderName)
  local currentDir = 0
  while currentDir ~= #additionalFolders do
    currentDir = currentDir+1
    searchForLuaFiles(currentDir)
  end

end

return loadAllLuaFiles
