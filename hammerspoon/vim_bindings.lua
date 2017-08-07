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

Vim = {}

function Vim:new()
	newObj = {normalMode = false,
						visualMode = false,
						insertMode = true, 
						modifiers = {},
						textModifiers = ''
					}
	self.__index = self
	return setmetatable(newObj, self)
end

function Vim:start()
	self.tapWatcher = hs.eventtap.new({hs.eventtap.event.types.keyDown}, function(evt)
		return self:eventWatcher(evt)
	end)
	self.mod = hs.hotkey.modal.new({"alt"}, "escape", 'Vim-mode')
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

function Vim:eventWatcher(evt)
	-- stop an event from propagating through the event system
	local stop_event = true
	-- if v key is hit, then go into visual mode
	if evt:getCharacters() == 'v' then
		self:setVisualMode(true)
		return stop_event
	end

	if self.visualMode then
		-- what are the characters to watch out for?
		return self:handleVisualMode(evt)
	end
end

function Vim:setVisualMode(val)
	-- val is bool
	self.visualMode = val
	-- TODO: change any other flags that are important for visual mode changes
	self.modifiers = {'shift'}
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
