-- typst.lua - preview a compiled Typst document in a split beside a terminal.
--
-- The pane runs ~/.local/bin/typst-pager, which compiles the source with
-- `typst compile` and paints the current page with the Kitty graphics
-- protocol, then recompiles whenever the source tree changes.
--
-- Loaded from init.lua with require("typst").

local TERMINAL = "com.superlogical.terminal"
local SHELL = "com.superlogical.terminal.shell"
local PAGER = "typst-pager"

local function log(message)
  if rex.log then
    rex.log("typst: " .. message)
  end
end

-- Actions run in the server, whose PATH is not the login shell's, so look in
-- the usual install locations too.
local function which(program)
  local home = os.getenv("HOME") or ""
  local dirs = {}
  for dir in (os.getenv("PATH") or ""):gmatch("[^:]+") do
    dirs[#dirs + 1] = dir
  end
  for _, dir in ipairs({
    home .. "/.local/bin",
    home .. "/.cargo/bin",
    home .. "/bin",
    "/opt/homebrew/bin",
    "/usr/local/bin",
    "/usr/bin",
    "/bin",
  }) do
    dirs[#dirs + 1] = dir
  end
  for _, dir in ipairs(dirs) do
    local candidate = dir .. "/" .. program
    local handle = io.open(candidate, "r")
    if handle then
      handle:close()
      return candidate
    end
  end
  return nil
end

local function dirname(path)
  return path:match("^(.*)/[^/]+$") or "."
end

local function basename(path)
  return path:match("[^/]+$") or path
end

-- Blocks created through the API get the server's bare PATH, not the login
-- shell's, so name the interpreter explicitly instead of trusting a shebang.
local function pager_command(file, dir)
  local pager = which(PAGER)
  if not pager then
    return nil, PAGER .. " is not on PATH"
  end
  local argv = { "--pick", dir }
  if file then
    argv = { file }
  end
  local uv = which("uv")
  local runner
  if uv then
    runner = { uv, "run", "--quiet", "--script", pager }
  else
    runner = { which("python3") or "/usr/bin/python3", pager }
  end
  for _, item in ipairs(argv) do
    runner[#runner + 1] = item
  end
  return runner
end

-- The terminal's own list_dir resolves a relative path against the working
-- directory of its foreground process, so it works before a shell has
-- reported one with pwd.
local function list_dir(ctx, path)
  if not ctx.block_id then
    return nil
  end
  local ok, result = pcall(rex.block.call, TERMINAL, "list_dir", {
    block_id = ctx.block_id,
    path = path or "",
    files = true,
    limit = 2000,
  })
  if not ok or type(result) ~= "table" or type(result.path) ~= "string" then
    return nil
  end
  if result.status and result.status ~= "ok" then
    return nil
  end
  return result
end

local function documents(listing)
  local names = {}
  for _, entry in ipairs((listing and listing.entries) or {}) do
    local name = tostring(entry.name or "")
    if entry.file and name:match("%.typ$") then
      names[#names + 1] = name
    end
  end
  return names
end

local function choose_document(dir, names)
  if #names == 1 then
    return dir .. "/" .. names[1]
  end
  if #names == 0 then
    return nil, "no .typ file in " .. dir
  end
  table.sort(names)
  return nil, "several .typ files: " .. table.concat(names, ", ")
end

-- Returns (file or nil, directory to start in). A nil file means the pager
-- should open its picker there instead of a specific document.
local function resolve(ctx, wanted)
  if wanted and wanted ~= "" then
    if wanted:match("%.typ$") then
      local path = wanted
      if path:sub(1, 2) == "~/" then
        path = (os.getenv("HOME") or "") .. path:sub(2)
      end
      if path:sub(1, 1) ~= "/" then
        local base = list_dir(ctx, "")
        if not base then
          return nil, nil, "cannot resolve " .. wanted
        end
        path = base.path .. "/" .. path
      end
      return path, dirname(path)
    end
    local listing = list_dir(ctx, wanted)
    if not listing then
      return nil, nil, "cannot list " .. wanted
    end
    return nil, listing.path
  end

  local listing = list_dir(ctx, "")
  if not listing then
    return nil, nil, "run this in a terminal pane, or pass a path"
  end
  return nil, listing.path
end

rex.action({
  name = "typst_preview",
  title = "Preview Typst document",
  description = "Compile a Typst file and page through it in a split beside this pane.",
  category = "Typst",
  keywords = "typst pdf render page document preview",
  args = { path = "string?" },
  run = function(ctx, args)
    local file, dir, err = resolve(ctx, args and args.path)
    if not dir then
      log(err)
      return nil, err
    end

    local command, missing = pager_command(file, dir)
    if not command then
      log(missing)
      return nil, missing
    end

    local result, call_err = rex.session.new_split({
      session_id = ctx.session_id,
      anchor_id = ctx.block_id,
      direction = "horizontal",
      side = "after",
      ratio = 0.5,
      focus = true,
      layout = {
        block = {
          flavor = SHELL,
          label = file and basename(file) or "typst",
          options = {
            command = command,
            shell = "none",
            cwd = dir,
          },
        },
      },
    })
    if not result then
      log(tostring(call_err))
      return nil, call_err
    end
    log(file and ("previewing " .. file) or ("picking in " .. dir))
    return result.block_ids and result.block_ids[1] or true
  end,
})

rex.bind("cmd+shift+y", "typst_preview")
