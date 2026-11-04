-- Rex configuration. Docs: https://www.superlogical.com/rex/docs/customize/config

package.path = (os.getenv("HOME") or "") .. "/.config/rex/?.lua;" .. package.path

require("typst")

rex.mode("resize", { exclusive = true })
rex.bind("cmd+shift+r", "client.mode.enter", { name = "resize" })

-- Vim-style pane navigation
rex.bind("cmd+alt+h", "pane.focus.left")
rex.bind("cmd+alt+j", "pane.focus.down")
rex.bind("cmd+alt+k", "pane.focus.up")
rex.bind("cmd+alt+l", "pane.focus.right")

rex.bind("resize/left", "pane.resize", { direction = "left" })
rex.bind("resize/right", "pane.resize", { direction = "right" })
rex.bind("resize/up", "pane.resize", { direction = "up" })
rex.bind("resize/down", "pane.resize", { direction = "down" })

rex.bind("resize/shift+left", "pane.resize", { direction = "left", amount = 15 })
rex.bind("resize/shift+right", "pane.resize", { direction = "right", amount = 15 })
rex.bind("resize/shift+up", "pane.resize", { direction = "up", amount = 15 })
rex.bind("resize/shift+down", "pane.resize", { direction = "down", amount = 15 })

rex.bind("resize/=", "pane.balance")
rex.bind("resize/enter", "client.mode.exit")
