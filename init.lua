-- mod-version:2 lite-xl 2.0
-- put user settings here
-- this module will be loaded after everything else when the application starts
-- it will be automatically reloaded when saved
local core = require "core"
local keymap = require "core.keymap"
local config = require "core.config"
local style = require "core.style"
local command = require "core.command"
local lspconfig = require "plugins.lsp.config"
--local common = require "core.common"

------------------------------ Themes ----------------------------------------
-- light theme:
-- core.reload_module("colors.summer")
core.reload_module("colors.vscode-dark-cukmekerb")
style.selectionhighlight = style.line_highlight
------------------------------- Fonts ----------------------------------------

-- customize fonts:
style.code_font  =  renderer.font.load(USERDIR  ..  "/fonts/NotoMono-Regular.ttf",  13  *  SCALE)
style.font = renderer.font.load(USERDIR .. "/fonts/NotoSans-Regular.ttf", 11 * SCALE)
style.big_font = renderer.font.load(USERDIR .. "/fonts/NotoSans-Regular.ttf", 40 * SCALE)

style.icon_font = renderer.font.load(USERDIR .. "/fonts/material_icons.ttf", 18 * SCALE)
style.icon_big_font = renderer.font.load(USERDIR .. "/fonts/material_icons.ttf", 24 * SCALE)
-- font names used by lite:
-- style.font          : user interface
-- style.big_font      : big text in welcome screen
-- style.icon_font     : icons
-- style.icon_big_font : toolbar icons
-- style.code_font     : code
--
-- the function to load the font accept a 3rd optional argument like:
--
-- {antialiasing="grayscale", hinting="full"}
--
-- possible values are:
-- antialiasing: grayscale, subpixel
-- hinting: none, slight, full
------------------------------ Plugins ----------------------------------------

-- enable or disable plugin loading setting config entries:

-- enable trimwhitespace, otherwise it is disable by default:
config.trimwhitespace = true
--
-- disable detectindent, otherwise it is enabled by default
config.plugins.detectindent = false

config.plugins.contextmenu = false

if pcall(require, "plugins.todotreeview-xl") then
	table.insert(config.ignore_paths, "node_modules/")
	table.insert(config.ignore_paths, "%.git/")
	table.insert(config.ignore_paths, "%.import/")
end

if pcall(require, "plugins.minimap") then
	config.plugins.minimap.caret_color = style.dim
end

config.plugins.linecopypaste = false
config.plugins.language_css = false
config.plugins.better_language_css = false
config.plugins.linter = false

--config.plugins.cukmekerb_language_css = false
config.plugins.language_xml = false
config.plugins.language_html = false

config.autosave_timeout = 0.8

-- hide tab X button
config.tab_close_button = false

-- always use tabs
config.tab_type = "hard"

-- hide todos
core.add_thread(function()
  command.perform("todotreeview:toggle")
end)

-- python linter stuff
config.flake8_args = {"--use-flake8-tabs"}


-------------------- lsp stuff -----------------------
config.autocomplete = false

lspconfig.cssls.setup {}

lspconfig.html.setup {}

lspconfig.jsonls.setup {}

lspconfig.tsserver.setup {}

lspconfig.pylsp.setup {}

lspconfig.clangd.setup {}

-- enable borderless mode :pogr:
config.borderless = true

--------------------------- Key bindings -------------------------------------

-- key binding:
-- keymap.add { ["ctrl+escape"] = "core:quit" }

-- my epick keymap:

keymap.add {
	["ctrl+h"] = "find-replace:replace",
	["ctrl+shift+z"] = "doc:redo",
	["alt+shift+t"] = "todotreeview:toggle",
	["ctrl+shift+r"] = "core:restart",
	["alt+down"] = "gitdiff:next-change",
	["alt+up"] = "gitdiff:previous-change",
}

-- put in thread to override plugin keymap
core.add_thread(function()
	keymap.add({["return"] = {"autocomplete:complete", "command:submit", "autoinsert:newline", "terminal:return"}}, true)
	-- fish shell
	--config.terminal.shell = "/usr/bin/fish"
end)


-- customize statusview
--[[
local statusview = require "core.statusview"
local common = require "core.common"
function statusview:draw_background()
	local x,y = self.position.x, self.position.y
    local w,h = self.size.x, self.size.y
    renderer.draw_rect(x, y, w + x, h + y, {common.color "#4f2947"})
end
--]]
