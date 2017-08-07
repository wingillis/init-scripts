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
	for k, v in ipairs(tmp) do
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

function keyPress(mod, char)
	hs.eventtap.keyStroke(mod, char, 20000)
end

function keyPressFactory(mod, char)
	-- return a function to press a certain key
	return function () keyPress(mod, char) end
end

Vim = {}

function Vim:new()
	newObj = {state = 'normal',
						keyMods = {}, -- these are like cmd, alt, shift, etc...
						commandMods = {}, -- these are like d, y, c in normal mode
						numberMods = ''}

	self.__index = self
	return setmetatable(newObj, self)
end

function Vim:start()
	self.tapWatcher = hs.eventtap.new({hs.eventtap.event.types.keyDown}, function(evt)
		return self:eventWatcher(evt)
	end)
	self.modal = hs.hotkey.modal.new({"alt"}, "escape", 'Vim-mode')
	self.modal:entered = function ()
		self.tapWatcher:start()
	end
	self.modal:exited = function ()
		self.tapWatcher:stop()
	end
end

function Vim:handleMovement(mod, chars)
	local moved = false
	-- handles movement in normal mode and visual mode
	local kpFun = function(mod, k)
		-- the 20000 = keydown length in mircoseconds
		return function () hs.eventtap.keyStroke(mod, k, 20000) end
	end
	local keymap = { j = kpFun(mod, 'down'),
									 k = kpFun(mod, 'up'),
									 l = kpFun(mod, 'right'),
									 h = kpFun(mod, 'left'),
									 ['0'] = kpFun(mergeArrays(mod, {'cmd'}), 'left'),
								 	 ['$'] = kpFun(mergeArrays(mod, {'cmd'}), 'right')
								 }
	-- TODO: add support for modifier letters as well
	if keymap[chars] == nil then
		-- do nothing except propagate value if not alphanumeric?
	else
		keymap[chars]()
		moved = true
	end

	return moved

end

function Vim:handleKeyEvent(char)
	-- check for text modifiers
	local modifiers = 'dcyr'

	-- check to see if the character should propagate through
	if self.state == 'inserting' then
		return false
	end
end

function Vim:eventWatcher(evt)
	-- stop an event from propagating through the event system
	local stop_event = true
	local evtChar = evt:getCharacters()
	local insertEvents = 'iIsaAoO'
	-- if v key is hit, then go into visual mode
	if evtChar == 'v' then
		self:setMode('visual')
		return stop_event
	elseif evtChar == ':' then
		-- do nothing for now because no ex mode
		self:setMode('ex')
		-- TODO: implement ex mode
	elseif evt:getKeyCode() == hs.keycodes.map['escape'] then
		self:setMode('normal')
	elseif insertEvents:find(evtChar) ~= nil then
		-- do the insert
		self:insert(evtChar)
	else
		-- anything else, literally
		stop_event = self:handleKeyEvent(evtChar)
	end
	return stop_event
end

function Vim:insert(char)
	-- if is an insert event then do something
	-- ...
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
	self:exitModal()
end

function Vim:exitModal()
	self.modal:exit()
end

function Vim:setMode(val)
	self.state = val
	-- TODO: change any other flags that are important for visual mode changes
	if val == 'visual' then
		self.keyMods = {'shift'}
		self.commandMods = {}
	elseif val == 'normal' then
		self.keyMods = {}
		self.commandMods = {}
	elseif val == 'ex' then
		-- do nothing because this is not implemented
	elseif val == 'inserting'
		-- do nothing because this is a placeholder
	end
end

function Vim:handleVisualMode(evt)
	local keywords = 'dycp'
	local chars = evt:getCharacters()
	local moved = self:handleMovement(self.modifiers, chars)
	if self.textModifiers ~= '' then
		self:handleTextModifier(chars)
	end
	-- if the keyword is the event character, then it's something interesting
	if string.match(keywords, chars) and not moved then
		self.textModifiers = chars
	end
	-- if moved, then probably the user wasn't doing anything else
end

-- what are the characters that end visual mode? y, p, x, d, esc

-- TODO: future implementations could use composition instead
-- TODO: add an ex mode into the Vim class using the chooser API
