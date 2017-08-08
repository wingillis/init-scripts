function mergeArrays(ar1, ar2)
	-- add each array value to a table, and send the iteration at the end
	local tmp = {}
	for _, v in ipairs(ar1) do
		tmp[v] = true
	end
	for _, v2 in ipairs(ar2) do
		tmp[v2] = true
	end
	local output = {}
	for k, v in pairs(tmp) do
		table.insert(output, k)
	end
	return output
end

function mergeTables(t1, t2)
	local output = {}
	for k, v in pairs(t1) do
		if t2[k] == nil then
			output[k] = v
		else
			outpu[k] = t2[k]
		end
	end

	for k, v in pairs(t2) do
		if output[k] == nil then
			output[k] = v
		end
	end
	return output
end

function delayedKeyPress(mod, char, delay)
	-- if needed you can do a delayed keypress by `delay` seconds
	return hs.timer.delayed.new(delay, function ()
		keyPress(mod, char)
	end)
end

function keyPress(mod, char)
	-- press a key for 20ms
	hs.eventtap.keyStroke(mod, char, 20000)
end

function keyPressFactory(mod, char)
	-- return a function to press a certain key for 20ms
	return function () keyPress(mod, char) end
end

-- TODO: add ability to do complex movements
function complexKeyPressFactory(mods, keys)
	-- mods and keys are arrays and have to be the same length
end

local Vim = {}

function Vim:new()
	newObj = {state = 'normal',
						keyMods = {}, -- these are like cmd, alt, shift, etc...
						commandMods = nil, -- these are like d, y, c in normal mode
						numberMods = 0, -- for # times to do an action
						moving = false, -- flag for movement characters
						debug = false
					}

	self.__index = self
	return setmetatable(newObj, self)
end

function Vim:setDebug(val)
	self.debug = val
end

function Vim:start()
	local selfPointer = self
	self.tapWatcher = hs.eventtap.new({hs.eventtap.event.types.keyDown}, function(evt)
		return self:eventWatcher(evt)
	end)
	self.modal = hs.hotkey.modal.new({"alt"}, "escape", 'Vim-mode')
	function self.modal:entered()
		-- reset to the normal mode
		selfPointer:setMode('normal')
		selfPointer.tapWatcher:start()
	end
	function self.modal:exited()
		selfPointer.tapWatcher:stop()
		selfPointer:setMode('normal')
	end

end

function Vim:handleKeyEvent(char)
	-- check for text modifiers
	local modifiers = 'dcyr'
	local stop_event = true -- stop event from propagating
	-- allows for visual mode too
	local movements = {
		j = keyPressFactory(self.keyMods, 'down'),
		k = keyPressFactory(self.keyMods, 'up'),
		h = keyPressFactory(self.keyMods, 'left'),
		l = keyPressFactory(self.keyMods, 'right'),
		['0'] = keyPressFactory(mergeArrays(self.keyMods, {'cmd'}), 'left'),
		['$'] = keyPressFactory(mergeArrays(self.keyMods, {'cmd'}), 'right'),
		b = keyPressFactory(mergeArrays(self.keyMods, {'alt'}), 'left'),
		e = keyPressFactory(mergeArrays(self.keyMods, {'alt'}), 'right')
	}

	if self.commandMods ~= nil and modifiers:find(self.commandMods) ~= nil then
		-- do something related to modifiers
	elseif movements[char] ~= nil then
		-- do movement commands, but state-dependent
		self.moving = true
		movements[char]()
		stop_event = true
	end
	-- check to see if the character should propagate through
	if self.state == 'insert' then
		stop_event = false
	end
	return stop_event
end

function Vim:eventWatcher(evt)
	-- stop an event from propagating through the event system
	local stop_event = true
	local evtChar = evt:getCharacters()
	if self.debug then
		print('in eventWatcher: pressed ' .. evtChar)
	end
	local insertEvents = 'iIsaAoO'
	-- this function mostly handles the state-dependent events
	if self.moving then
		stop_event = false
		self.moving = false
	elseif evtChar == 'v' then
		-- if v key is hit, then go into visual mode
		self:setMode('visual')
		return stop_event
	elseif evtChar == ':' then
		-- do nothing for now because no ex mode
		self:setMode('ex')
		-- TODO: implement ex mode
	elseif evt:getKeyCode() == hs.keycodes.map['escape'] then
		-- get out of visual mode
		self:setMode('normal')
	elseif insertEvents:find(evtChar, 1, true) ~= nil and self.state == 'normal' then
		-- do the insert
		self:insert(evtChar)
	else
		-- anything else, literally
		if self.debug then
			print('handling key press event for movement')
		end
		stop_event = self:handleKeyEvent(evtChar)
	end
	return stop_event
end

function Vim:insert(char)
	-- if is an insert event then do something
	-- ...
	self.moving = true
	if char == 's' then
		-- delete character and exit
		keyPress('', 'forwarddelete')
	elseif char == 'a' then
		keyPress('', 'right')
	elseif char == 'A' then
		keyPress({'cmd'}, 'right')
	elseif char == 'I' then
		keyPress({'cmd'}, 'left')
	end
	-- TODO: implement o and O

	local selfRef = self
	hs.timer.delayed.new(0.021, function ()
		selfRef:exitModal()
	end):start()
end

function Vim:exitModal()
	self.modal:exit()
end

function Vim:setMode(val)
	self.state = val
	-- TODO: change any other flags that are important for visual mode changes
	if val == 'visual' then
		self.keyMods = {'shift'}
		self.commandMods = nil
		self.numberMods = 0
		self.moving = false
	elseif val == 'normal' then
		self.keyMods = {}
		self.commandMods = nil
		self.numberMods = 0
		self.moving = false
	elseif val == 'ex' then
		-- do nothing because this is not implemented
	elseif val == 'insert' then
		-- do nothing because this is a placeholder
	end
end

-- what are the characters that end visual mode? y, p, x, d, esc

-- TODO: future implementations could use composition instead
-- TODO: add an ex mode into the Vim class using the chooser API

return Vim
