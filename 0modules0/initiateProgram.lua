function initiateProgram ()
--------------------------------------------------------------------------------
	sprite = {} users={} char={} obj = {}
	sx, sy, xx, yy = 1, 1, 0, 0
--------------------------------------------------------------------------------
	require "0modules0.loadingContent.loadAllLuaFiles" loadAllLuaFiles("0modules0")
--------------------------------------------------------------------------------
	addTimers(100)

	-----------------------------------------------------------------------------------------------------------------------
	---persistence module for saving/loading
	local write, writeIndent, writers, refCount;

	persistence =
	{
		store = function (path, ...)
			local file, e = io.open(path, "w");
			if not file then
				return error(e);
			end
			local n = select("#", ...);
			-- Count references
			local objRefCount = {}; -- Stores reference that will be exported
			for i = 1, n do
				refCount(objRefCount, (select(i,...)));
			end;
			-- Export Objects with more than one ref and assign name
			-- First, create empty tables for each
			local objRefNames = {};
			local objRefIdx = 0;
			file:write("-- Persistent Data\n");
			file:write("local multiRefObjects = {\n");
			for obj, count in pairs(objRefCount) do
				if count > 1 then
					objRefIdx = objRefIdx + 1;
					objRefNames[obj] = objRefIdx;
					file:write("{};"); -- table objRefIdx
				end;
			end;
			file:write("\n} -- multiRefObjects\n");
			-- Then fill them (this requires all empty multiRefObjects to exist)
			for obj, idx in pairs(objRefNames) do
				for k, v in pairs(obj) do
					file:write("multiRefObjects["..idx.."][");
					write(file, k, 0, objRefNames);
					file:write("] = ");
					write(file, v, 0, objRefNames);
					file:write(";\n");
				end;
			end;
			-- Create the remaining objects
			for i = 1, n do
				file:write("local ".."obj"..i.." = ");
				write(file, (select(i,...)), 0, objRefNames);
				file:write("\n");
			end
			-- Return them
			if n > 0 then
				file:write("return obj1");
				for i = 2, n do
					file:write(" ,obj"..i);
				end;
				file:write("\n");
			else
				file:write("return\n");
			end;
			if type(path) == "string" then
				file:close();
			end;
		end;

		load = function (path)
			local f, e;
			if type(path) == "string" then
				f, e = loadfile(path);
			else
				f, e = path:read('*a')
			end
			if f then
				return f();
			else
				return nil, e;
			end;
		end;
	}

	-- Private methods

	-- write thing (dispatcher)
	write = function (file, item, level, objRefNames)
		writers[type(item)](file, item, level, objRefNames);
	end;

	-- write indent
	writeIndent = function (file, level)
		for i = 1, level do
			file:write("\t");
		end;
	end;

	-- recursively count references
	refCount = function (objRefCount, item)
		-- only count reference types (tables)
		if type(item) == "table" then
			-- Increase ref count
			if objRefCount[item] then
				objRefCount[item] = objRefCount[item] + 1;
			else
				objRefCount[item] = 1;
				-- If first encounter, traverse
				for k, v in pairs(item) do
					refCount(objRefCount, k);
					refCount(objRefCount, v);
				end;
			end;
		end;
	end;

	-- Format items for the purpose of restoring
	writers = {
		["nil"] = function (file, item)
				file:write("nil");
			end;
		["number"] = function (file, item)
				file:write(tostring(item));
			end;
		["string"] = function (file, item)
				file:write(string.format("%q", item));
			end;
		["boolean"] = function (file, item)
				if item then
					file:write("true");
				else
					file:write("false");
				end
			end;
		["table"] = function (file, item, level, objRefNames)
				local refIdx = objRefNames[item];
				if refIdx then
					-- Table with multiple references
					file:write("multiRefObjects["..refIdx.."]");
				else
					-- Single use table
					file:write("{\n");
					for k, v in pairs(item) do
						writeIndent(file, level+1);
						file:write("[");
						write(file, k, level+1, objRefNames);
						file:write("] = ");
						write(file, v, level+1, objRefNames);
						file:write(";\n");
					end
					writeIndent(file, level);
					file:write("}");
				end;
			end;
		["function"] = function (file, item)
				-- Does only work for "normal" functions, not those
				-- with upvalues or c functions
				local dInfo = debug.getinfo(item, "uS");
				if dInfo.nups > 0 then
					file:write("nil --[[functions with upvalue not supported]]");
				elseif dInfo.what ~= "Lua" then
					file:write("nil --[[non-lua function not supported]]");
				else
					local r, s = pcall(string.dump,item);
					if r then
						file:write(string.format("loadstring(%q)", s));
					else
						file:write("nil --[[function could not be dumped]]");
					end
				end
			end;
		["thread"] = function (file, item)
				file:write("nil --[[thread]]\n");
			end;
		["userdata"] = function (file, item)
				file:write("nil --[[userdata]]\n");
			end;
	}

	---persistence module code ends here....
	-----------------------------------------------------------------------------------------

buttonList = {

}

keyboardButtonList ={ } --???? should be a separate lua file

	color_change_shader = [[
	extern vec4 colors;

	vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords )
	{
			vec4 texcolor = Texel(texture, texture_coords); // This reads a color from our texture at the coordinates LOVE gave us (0-1, 0-1)

			return texcolor*colors;
	}]]

	color_change = love.graphics.newShader (color_change_shader)



game = {
screenResolution = {x=1024, y=768},
defaultCanvasSize = {x=1920, y=1080},
}

ui.screen = {


}

defaultCanvas = love.graphics.newCanvas(game.defaultCanvasSize.x, game.defaultCanvasSize.y)
defaultCanvas:setFilter('nearest', 'nearest')
love.graphics.setDefaultFilter( 'nearest', 'nearest', 0 )

--function resetWindow()
	local a  = love.graphics.getWidth()
	local b = love.graphics.getHeight()
	love.window.setMode( game.screenResolution.x, game.screenResolution.y,
	{fullscreen =false, fullscreentype="desktop",
	vsync=false,msaa=0,resizable = true,borderless = false,centered = true,
	display = 1,minwidth=0,minheight=0,highdpi=false} )
--end

	--read the settingfile and check if default mode is true or false
	--if default mode is true don't do anything if it's false
	--load the custom settings from before
		--create the canvas and set the filter to nearest neighbor
--------------------------------------------------------------------------------
	--draws important variables
	defaultFont = love.graphics.newFont( "YanoneKaffeesatz-Regular.ttf", 36 )

	love.graphics.setFont(defaultFont)

	ui.tooltip.minSize (0, 0)

	ui.tooltip.maxWidth (700)

	ui.tooltip.colors ({0,0,0,220}, {0,0,0,255}, {255, 255, 255, 230})

	ui.tooltip.outlineThickness(1)

	ui.tooltip.enableOutline()

	ui.tooltip.textOffset (10, 10)

	ui.tooltip.font (defaultFont)

	ui.tooltip.cursorOffset (30, 30)


	loadDeckLoading()
	--loadMainMenu()
	--loadCharCreation()
	--loadCharCreation2()
	--loadCharDerivedStats()
end
return initiateProgram
