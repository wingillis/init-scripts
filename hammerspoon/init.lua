
dofile('/Users/wgillis/dev/init_scripts/hammerspoon/vim_bindings.lua')

local v = Vim:new()
v:start()

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "H", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.x = f.x - 10
  win:setFrame(f)
end)

hs.hotkey.bind({"ctrl", "alt"}, "m", function()
  local mouse = hs.mouse.getAbsolutePosition()
  local mouseScreen = hs.mouse.getCurrentScreen()
  local screens = hs.screen.allScreens()
  if mouseScreen == screens[1] then
    local frame = screens[2]:frame()
    local x = frame.w/2
    local y = frame.h/2
    hs.mouse.setRelativePosition({x=x, y=y}, screens[2])
  else
    local frame = screens[1]:frame()
    local x = frame.w/2
    local y = frame.h/2
    hs.mouse.setRelativePosition({x=x, y=y},screens[1])
  end
end)

-- function select_keyboard_layout(layout)
-- 	hs.osascript.applescript(string.format([[
-- 	tell application "System Events" to tell process "Karabiner-Menu"
-- 		ignoring application responses
-- 			click menu bar item 1 of menu bar 1
-- 		end ignoring
-- 	end tell
-- 	do shell script "killall System\\ Events"
-- 	delay 0.1
-- 	tell application "System Events" to tell process "Karabiner-Menu"
-- 		tell menu bar item 1 of menu bar 1
-- 			click menu item "%s" of menu 1
-- 		end tell
-- 	end tell
-- 	]], layout))
-- end

function control_handler(evt)
	local dont_propagate = true
	-- all alphanumeric chars shouldn't get through
	if evt:getCharacters():match("%W") then
		dont_propagate = false
	end
	if evt:getCharacters() == 'j' then
		hs.eventtap.keyStroke('', 'down')
	end
	if evt:getCharacters() == 'p' then
		hs.timer.delayed.new(0.03, function()
			hs.eventtap.keyStroke({'cmd'}, 'v')
		end):start()
		hs.eventtap.keyStroke('', 'i')
	end
	if evt:getCharacters() == 'k' then
		hs.eventtap.keyStroke('', 'up')
	end
	if evt:getCharacters() == 'h' then
		hs.eventtap.keyStroke('', 'left')
	end
	if evt:getCharacters() == 'l' then
		hs.eventtap.keyStroke('', 'right')
	end
	if evt:getCharacters() == 'e' then
		hs.eventtap.keyStroke({'alt'}, 'right')
	end
	if evt:getCharacters() == 'b' then
		hs.eventtap.keyStroke({'alt'}, 'left')
	end
	if evt:getCharacters() == '0' then
		hs.eventtap.keyStroke({'cmd'}, 'left')
	end
	if evt:getCharacters() == 'x' then
		hs.eventtap.keyStroke({}, 'backspace')
	end
	if evt:getCharacters() == 'i' then
		mod:exit()
	end
	if evt:getCharacters() == 'A' then
		hs.eventtap.keyStroke({'cmd'}, 'right')
		hs.eventtap.keyStroke('', 'i')
	end
	if evt:getCharacters() == 'o' then
		hs.eventtap.keyStroke({'cmd'}, 'right')
		hs.eventtap.keyStroke({}, 'return')
		hs.eventtap.keyStroke('', 'i')
	end
	if evt:getCharacters() == '$' then
		hs.eventtap.keyStroke({'cmd'}, 'right')
		-- special because it isn't an alphanumeric
		dont_propagate = true
	end
	if evt:getKeyCode() == hs.keycodes.map['escape'] then
		dont_propagate = false
	end
	return dont_propagate
end

control_tap = hs.eventtap.new({hs.eventtap.event.types.keyDown}, control_handler)
-- make a modal setup for hjkl nav
mod = hs.hotkey.modal.new({"alt"}, "escape", 'Vim-mode')

function mod:entered()
	control_tap:start()
end

function mod:exited()
	control_tap:stop()
end

function command_output(some_output)
	if some_output == nil then
		return
	end
	if some_output["uuid"] == "0001" then
		hs.execute("open -a 'Google Chrome' -n --args --profile-directory='Profile 2'")
		-- hs.window.switcher.new(hs.window.filter.new{'Google Chrome'}):next()
		hs.timer.usleep(200)
		hs.window.filter.default:getWindows(hs.window.filter.sortByCreatedLast)[1]:focus()
	end
	if some_output["uuid"] == "0002" then
		hs.execute("open -a 'Google Chrome' -n --args --profile-directory='Default'")
		-- hs.window.switcher.new(hs.window.filter.new{'Google Chrome'}):next()
		hs.timer.usleep(200)
		hs.window.filter.default:getWindows(hs.window.filter.sortByCreatedLast)[1]:focus()
	end

end

function command_chooser()
	local variablethiin = hs.chooser.new(command_output)
	variablethiin:bgDark(true)
	qChangedCallback = function(qString)
		print(qString)
	end
	variablethiin:queryChangedCallback(qChangedCallback)
	local choices = {
		{
			["text"] = "New Chrome Window - Winthrop",
			["uuid"] = "0001"
		},
		{
			["text"] = "New Chrome Window - Harvard",
			["uuid"] = "0002"
		}
	}

	variablethiin:choices(choices)
	variablethiin:show()
end

hs.hotkey.bind({"ctrl", "alt"}, "Space", command_chooser)

