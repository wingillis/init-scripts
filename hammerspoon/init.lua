
Vim = require('vim_bindings')
-- Vim = require('vim')

local v = Vim:new()
-- v:setDebug(true) -- uncomment this if you want some things printed to the hammerspoon console
v:start()

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "H", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.x = f.x - 10
  win:setFrame(f)
end)

hs.hotkey.bind({"ctrl", "alt"}, "m", function()
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
	-- qChangedCallback = function(qString)
	-- 	print(qString)
	-- end
	-- variablethiin:queryChangedCallback(qChangedCallback)
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

-- hs.hotkey.bind({"ctrl", "alt"}, "Space", command_chooser)

local keyStrokeFactory = function (mods, key)
	return function ()
		hs.eventtap.keyStroke(mods, key, 1000)
	end
end

transferMap = {
  q='s',
  w='i',
  e='a',
  r='e',
  c=hs.keycodes.map["space"],
  n='.',
  u='t',
  i='o',
  o='n',
  p='h',
  ui=hs.keycodes.map['delete'],
  qn='b',
  ow='c',
  nc='d',
  nr='f',
  pr='g',
  pc='j',
  co='k',
  ie='l',
  uc='m',
  ro='p',
  ir='q',
  ru='r',
  oe='u',
  ci='v',
  eu='w',
  en='x',
  wp='y',
  ep='z',
  re=hs.keycodes.map['return'],
  op=hs.keycodes.map['forwarddelete'],
  nw={'shift', '/'}, -- == '?'
	qp={{'ctrl', 'alt'}, hs.keycodes.map['space']}
}

local newMap = {}

for k,v in pairs(transferMap) do
  local key = {}
  k:gsub(".", function(c) table.insert(key, c) end)
  table.sort(key)
  local newKey = table.concat(key, '')
  if type(v) == 'table' then
  	newMap[newKey] = keyStrokeFactory(v[1], v[2])
	else
  	newMap[newKey] = keyStrokeFactory({}, v)
	end
end

newBoardStarted = false
transferMap = newMap
currChar = nil

keysDown = {
  q=false, w=false, e=false, r=false, c=false,
  n=false, u=false, i=false, o=false, p=false
}
keysToAdd = {}
typing = false

typingTimer = hs.timer.delayed.new(0.002, function ()
  typing = false
  -- currChar = nil
end)

keyNotifyTimer = hs.timer.delayed.new(0.08, function ()
  if next(keysToAdd) ~= nil then
  	local keys = {}
  	for k, v in pairs(keysToAdd) do
  		table.insert(keys, k)
		end
    table.sort(keys)
    local keycombo = table.concat(keys, '')
    local result = transferMap[keycombo]
    if result ~= nil then
      typing = true
      typingTimer:start()
      -- currChar = result
      result()
    end
  end
  keysToAdd = {}
  timerOn = false
end)


timerOn = false

tapWatcher = hs.eventtap.new({hs.eventtap.event.types.keyDown}, function(evt)
  local evtChar = evt:getCharacters()
  if typing and keysDown[evtChar] ~= true then
    return false
  else
    if keysDown[evtChar] ~= nil then
      keysDown[evtChar] = true
      if keysToAdd[evtChar] == nil then
      	keysToAdd[evtChar] = true
			end
    end
    if timerOn == false then
      timerOn = true
      keyNotifyTimer:start()
      for k, v in pairs(keysDown) do
      	if v and keysToAdd[k] == nil then
      		keysToAdd[k] = true
				end
			end
    end
    return true
  end
end)

tapUpWatcher = hs.eventtap.new({hs.eventtap.event.types.keyUp}, function(evt)
  local evtChar = evt:getCharacters()
  if keysDown[evtChar] ~= nil and currChar ~= evtChar then
    keysDown[evtChar] = false
  end
  return false
end)

hs.hotkey.bind({"ctrl", "alt"}, "Space", function()
  if newBoardStarted then
    tapWatcher:stop()
	  tapUpWatcher:stop()
	  newBoardStarted = false
  else
  	tapWatcher:start()
  	tapUpWatcher:start()
  	newBoardStarted = true
    for k,v in pairs(keysDown) do
      keysDown[k] = false
    end
    keysToAdd = {}
  end
end)
