hs.hotkey.bind({"cmd", "alt", "ctrl"}, "H", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.x = f.x - 10
  win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "W", function()
  hs.alert.show("Hello World!")
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

function select_keyboard_layout(layout)
	hs.osascript.applescript(string.format([[
	tell application "System Events" to tell process "Karabiner-Menu"
		ignoring application responses
			click menu bar item 1 of menu bar 1
		end ignoring
	end tell
	do shell script "killall System\\ Events"
	delay 0.1
	tell application "System Events" to tell process "Karabiner-Menu"
		tell menu bar item 1 of menu bar 1
			click menu item "%s" of menu 1
		end tell
	end tell
	]], layout))
end

-- make a modal setup for hjkl nav
mod = hs.hotkey.modal.new({"alt"}, "escape", 'Vim-mode entered')

function mod:entered()
	select_keyboard_layout('vim-mode')
end

function mod:exited()
	select_keyboard_layout('Caps -> Esc')
end

mod:bind('', 'escape', function()
	mod:exit()
end)
