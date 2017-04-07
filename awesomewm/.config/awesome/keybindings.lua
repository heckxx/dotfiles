local awful = require("awful");
local menubar = require("menubar");
local lain = require("lain");
local drop = require("scratchdrop");

-- {{{ Key bindings - Global
-- Mod + tag:                Go to tag
-- Mod + Shift + tag:        Move to tag
-- Mod + Ctrl + tag:         Toggle tag
-- Mod + Ctrl + Shift + tag: Toggle tag
-- Mod + left,right:         Go to prev,next tag
-- Mod + Esc:                Go to previously selected tag
-- Mod + j,k:                Go to prev,next client
-- Mod + w:                  Lock screen
-- Mod + Shift + j,k:        Swap selected client with prev,next client
-- Mod + u:                  Go to next urgent client
-- Mod + Tab:                Go to previously selected client
-- Mod + "-,=":              Resize uselessgaps
-- Mod + Enter:              Spawn terminal
-- Mod + Ctrl + R:           Restart awesome
-- Mod + h,l:                Resize client parallel to layout
-- Mod + Ctrl + j,k:         Resize client perpendicular to layout
-- Mod + Ctrl + h,l:         Increase,decrease number of columns in non-master clients
-- Mod + Space:              Next layout
-- Mod + Shift + Space:      Previous layout
-- Mod + Shift + n:          Restore client
-- Mod + r:                  Shell prompt
-- Mod + x:                  Lua prompt
-- Mod + p:                  Show menubar
-- ~:                        Guake terminal
-- Alt + m:                  Toggle mute
keybindings = {};
keybindings.globalkeys = awful.util.table.join(
    awful.key({ modkey}, "Left",   awful.tag.viewprev),
    awful.key({ modkey}, "Right",  awful.tag.viewnext),
    awful.key({ modkey}, "Escape", awful.tag.history.restore),
    awful.key({ modkey}, "j", function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey}, "k", function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey }, "w", function () awful.util.spawn_with_shell("i3lock-fancy -gp") end),
    -- awful.key({ modkey}, "w", function () mymainmenu:show() end),
    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
--    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
--    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey}, "u", awful.client.urgent.jumpto),
    awful.key({ modkey}, "Tab", function ()
            awful.client.focus.history.previous()
            if client.focus then client.focus:raise() end
        end),
    -- On the fly useless gaps change
    awful.key({ modkey, "Control" }, "=", function () lain.util.useless_gaps_resize(5) end),
    awful.key({ modkey, "Control" }, "-", function () lain.util.useless_gaps_resize(-5) end),
    -- Standard program
    awful.key({ modkey}, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),
    awful.key({ modkey}, "l", function () awful.tag.incmwfact( 0.05) end),
    awful.key({ modkey}, "h", function () awful.tag.incmwfact(-0.05) end),
    awful.key({ modkey, "Control"}, "j", function () awful.client.incwfact( 0.05) end),
    awful.key({ modkey, "Control"}, "k", function () awful.client.incwfact(-0.05) end),
    awful.key({ modkey, "Shift"}, "h", function () awful.tag.incnmaster( 1) end),
    awful.key({ modkey, "Shift"}, "l", function () awful.tag.incnmaster(-1) end),
    awful.key({ modkey, "Control"}, "h", function () awful.tag.incncol( 1) end),
    awful.key({ modkey, "Control"}, "l", function () awful.tag.incncol(-1) end),
    awful.key({ modkey, "Shift" }, "n", awful.client.restore),
    -- Dropdown terminal, ~
    awful.key({}, "#49",      function () drop(terminal,"top","center",1,1,true) end),
    -- Keyboard media keys
    awful.key({}, "#171", function () os.execute("mpc next") widgets.mpdwidget.update() end),
    awful.key({}, "#172", function () os.execute("mpc toggle") widgets.mpdwidget.update() end),
    awful.key({}, "#173", function () os.execute("mpc prev") widgets.mpdwidget.update() end),
    awful.key({}, "#174", function () os.execute("mpc stop") widgets.mpdwidget.update() end),
    -- ALSA volume control
    awful.key({}, "#123", function () os.execute("amixer -D pulse set Master playback 3%+") widgets.volumewidget.update() end),
    awful.key({}, "#122", function () os.execute("amixer -D pulse set Master playback 3%-") widgets.volumewidget.update() end),
    awful.key({altkey}, "m", function () os.execute("amixer -D pulse set Master playback toggle") widgets.volumewidget.update() end),
    -- Brightness control
    awful.key({ }, "XF86MonBrightnessDown", function () awful.util.spawn("xbacklight -dec 15") end),
    awful.key({ }, "XF86MonBrightnessUp", function () awful.util.spawn("xbacklight -inc 15") end),
    -- Prompt
    awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen]:run() end),
    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end),
    -- Menubar
    awful.key({ modkey }, "p", function() menubar.show() end)
)
-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    keybindings.globalkeys = awful.util.table.join(keybindings.globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        local tag = awful.tag.gettags(screen)[i]
                        if tag then
                           awful.tag.viewonly(tag)
                        end
                  end),
        -- Toggle tag.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      local tag = awful.tag.gettags(screen)[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = awful.tag.gettags(client.focus.screen)[i]
                          if tag then
                              awful.client.movetotag(tag)
                          end
                     end
                  end),
        -- Toggle tag.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = awful.tag.gettags(client.focus.screen)[i]
                          if tag then
                              awful.client.toggletag(tag)
                          end
                      end
                  end))
end

-- {{{ Key bindings for clients
keybindings.clientkeys = awful.util.table.join(
    awful.key({ modkey}, "f", function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"}, "c", function (c) c:kill() end),
    awful.key({ modkey, "Control"}, "space", awful.client.floating.toggle),
    awful.key({ modkey, "Control"}, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey}, "o", awful.client.movetoscreen),
    awful.key({ modkey}, "t", function (c) c.ontop = not c.ontop end),
    awful.key({ modkey}, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end),
    awful.key({ modkey}, "m", function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)
-- }}}

-- {{{ Mouse bindings for clients
keybindings.clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize)
    )
-- }}}
return keybindings;
