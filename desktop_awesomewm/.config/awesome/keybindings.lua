local awful = require("awful");
local menubar = require("menubar");
local lain = require("lain");
<<<<<<< Updated upstream
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
=======
local vars = require("vars");
local hotkeys_popup = require("awful.hotkeys_popup").widget
local modkey, altkey = vars.modkey, vars.altkey
local quake= lain.util.quake({ app = terminal, height = 1, followtag = true, argname = "--name %s" })

local keybindings = {}

-- {{{ GLOBAL 
keybindings.global_buttons = awful.util.table.join(
  -- awful.button({ }, 3, function () awful.util.mymainmenu:toggle() end),
  -- awful.button({ }, 4, awful.tag.viewnext),
  -- awful.button({ }, 5, awful.tag.viewprev)
  )
keybindings.global_keys = awful.util.table.join(
  -- lock
  awful.key({ modkey, }, "w", function() awful.spawn.with_shell(vars.lock) end,
    {description="lock", group="awesome"}),
  awful.key({ modkey, }, "s",      hotkeys_popup.show_help,
    {description="show help", group="awesome"}),
  -- Tag browsing
  --[[
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),
    ]]

  -- Non-empty tag browsing
  --[[
    awful.key({ altkey }, "Left", function () lain.util.tag_view_nonempty(-1) end,
              {description = "view  previous nonempty", group = "tag"}),
    awful.key({ altkey }, "Right", function () lain.util.tag_view_nonempty(1) end,
              {description = "view  previous nonempty", group = "tag"}),
    ]]

  -- Default client focus
  awful.key({ modkey, }, "j", function () awful.client.focus.byidx( 1) end,
    {description = "focus next by index", group = "client"}
    ),
  awful.key({ modkey, }, "k", function () awful.client.focus.byidx(-1) end,
    {description = "focus previous by index", group = "client"}
    ),

  -- By direction client focus
  --[[
    awful.key({ modkey }, "j",
        function()
            awful.client.focus.bydirection("down")
>>>>>>> Stashed changes
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey}, "k", function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
<<<<<<< Updated upstream
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
=======
    awful.key({ modkey }, "h",
        function()
            awful.client.focus.bydirection("left")
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey }, "l",
        function()
            awful.client.focus.bydirection("right")
            if client.focus then client.focus:raise() end
        end),
        --]]

  -- Layout manipulation
  awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
    {description = "swap with next client by index", group = "client"}),
  awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
    {description = "swap with previous client by index", group = "client"}),
  --[[
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
              --]]
  awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
    {description = "jump to urgent client", group = "client"}),
  awful.key({ modkey,           }, "Tab",
    function ()
      awful.client.focus.history.previous()
      if client.focus then
        client.focus:raise()
      end
    end,
    {description = "go back", group = "client"}),

  -- Show/Hide Wibox
  --[[
    awful.key({ modkey }, "b", function ()
        for s in screen do
            s.mywibox.visible = not s.mywibox.visible
            if s.mybottomwibox then
                s.mybottomwibox.visible = not s.mybottomwibox.visible
            end
        end
    end),
    --]]

  -- On the fly useless gaps change
  awful.key({ altkey, "Control" }, "=", function () lain.util.useless_gaps_resize(1) end,
    {description = "increase useless gaps", group = "layout"}),
  awful.key({ altkey, "Control" }, "-", function () lain.util.useless_gaps_resize(-1) end,
    {description = "decrease useless gaps", group = "layout"}),

  -- Dynamic tagging
  awful.key({ modkey, "Control" }, "n", function () lain.util.add_tag() end),
  awful.key({ modkey, "Control" }, "r", function () lain.util.rename_tag() end),
  awful.key({ modkey, "Shift" }, "Left", function () lain.util.move_tag(1) end),   -- move to next tag
  awful.key({ modkey, "Shift" }, "Right", function () lain.util.move_tag(-1) end), -- move to previous tag
  awful.key({ modkey, "Shift" }, "d", function () lain.util.delete_tag() end),

  -- Standard program
  awful.key({ modkey, }, "Return", function () awful.spawn(vars.terminal) end,
    {description = "open a terminal", group = "launcher"}),
  awful.key({ modkey, "Shift" }, "r", awesome.restart,
    {description = "reload awesome", group = "awesome"}),
  awful.key({ modkey, "Shift" }, "q", awesome.quit,
    {description = "quit awesome", group = "awesome"}),

  awful.key({ modkey }, "l",     function () awful.tag.incmwfact( 0.05)          end,
    {description = "increase master width factor", group = "layout"}),
  awful.key({ modkey }, "h",     function () awful.tag.incmwfact(-0.05)          end,
    {description = "decrease master width factor", group = "layout"}),
  awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
    {description = "increase the number of master clients", group = "layout"}),
  awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
    {description = "decrease the number of master clients", group = "layout"}),
  awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
    {description = "increase the number of columns", group = "layout"}),
  awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
    {description = "decrease the number of columns", group = "layout"}),
  awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
    {description = "select next", group = "layout"}),
  awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
    {description = "select previous", group = "layout"}),

  awful.key({ modkey, "Shift" }, "n",
    function ()
      local c = awful.client.restore()
      -- Focus restored client
      if c then
        client.focus = c
        c:raise()
      end
    end,
    {description = "restore minimized", group = "client"}),

  -- Dropdown application
  awful.key({}, "`", function () quake:toggle() end,
    {description = "dropdown terminal", group = "other"}),

  -- Widgets popups
  --[[
    awful.key({ altkey, }, "c", function () lain.widget.calendar.show(7) end,
              {description = "show calendar", group = "widgets"}),
    awful.key({ altkey, }, "h", function () if beautiful.fs then beautiful.fs.show(7) end end,
              {description = "show fs", group = "widgets"}),
    awful.key({ altkey, }, "w", function () if beautiful.weather then beautiful.weather.show(7) end end,
              {description = "show weather", group = "widgets"}),
    ]]

  awful.key({ }, "XF86MonBrightnessDown", function () awful.spawn.with_shell("xbacklight -dec 15") end,
    { description = "decrease brightness", group = "display" }),
  awful.key({ }, "XF86MonBrightnessUp", function () awful.spawn.with_shell("xbacklight -inc 15") end,
    { description = "increase brightness", group = "display" }),

  -- ALSA volume control
  awful.key({}, "#123",
    function ()
      os.execute(string.format("amixer -q set %s 3%%+", beautiful.volume.channel))
      beautiful.volume.update()
    end,
    {description = "raise volume", group = "audio"}),
  awful.key({}, "#122",
    function ()
      os.execute(string.format("amixer -q set %s 3%%-", beautiful.volume.channel))
      beautiful.volume.update()
    end,
    {description = "lower volume", group = "audio"}),
  awful.key({altkey}, "m",
    function ()
      os.execute(string.format("amixer -q set %s toggle", beautiful.volume.togglechannel or beautiful.volume.channel))
      beautiful.volume.update()
    end,
    {description = "mute", group = "audio"}),

  -- MPD control
  awful.key({}, "#172",
    function ()
      awful.spawn.with_shell("mpc toggle")
      beautiful.mpd.update()
    end,
    {description = "play/pause", group = "audio"}),
  awful.key({}, "#174",
    function ()
      awful.spawn.with_shell("mpc stop")
      beautiful.mpd.update()
    end,
    {description = "stop", group = "audio"}),
  awful.key({}, "#173",
    function ()
      awful.spawn.with_shell("mpc prev")
      beautiful.mpd.update()
    end,
    {description = "prev track", group = "audio"}),
  awful.key({}, "#171",
    function ()
      awful.spawn.with_shell("mpc next")
      beautiful.mpd.update()
    end,
    {description = "next track", group = "audio"}),
  awful.key({ altkey }, "0",
    function ()
      local common = { text = "MPD widget ", position = "top_middle", timeout = 2 }
      if beautiful.mpd.timer.started then
        beautiful.mpd.timer:stop()
        common.text = common.text .. lain.util.markup.bold("OFF")
      else
        beautiful.mpd.timer:start()
        common.text = common.text .. lain.util.markup.bold("ON")
      end
      naughty.notify(common)
    end,
    {description = "toggle mpd widget", group = "widgets"}),

  -- Copy primary to clipboard (terminals to gtk)
  -- awful.key({ modkey }, "c", function () awful.spawn("xsel | xsel -i -b") end),
  -- Copy clipboard to primary (gtk to terminals)
  -- awful.key({ modkey }, "v", function () awful.spawn("xsel -b | xsel") end),

  -- User programs
  -- awful.key({ modkey }, "e", function () awful.spawn(gui_editor) end),
  -- awful.key({ modkey }, "q", function () awful.spawn(browser) end),

  -- Default
  --[[ Menubar
    awful.key({ modkey }, "p", function() menubar.show() end,
              {description = "show the menubar", group = "launcher"})
    --]]
  --[[ dmenu
    awful.key({ modkey }, "x", function ()
        awful.spawn(string.format("dmenu_run -i -fn 'Monospace' -nb '%s' -nf '%s' -sb '%s' -sf '%s'",
        beautiful.bg_normal, beautiful.fg_normal, beautiful.bg_focus, beautiful.fg_focus))
    end)
    --]]
  -- Prompt
  awful.key({ modkey }, "r", function () awful.screen.focused().mypromptbox:run() end,
    {description = "command execute prompt", group = "awesome"}),
  awful.key({ modkey }, "x",
    function ()
      awful.prompt.run {
        prompt       = "Run Lua code: ",
        textbox      = awful.screen.focused().mypromptbox.widget,
        exe_callback = awful.util.eval,
        history_path = awful.util.get_cache_dir() .. "/history_eval"
      }
    end,
    {description = "lua execute prompt", group = "awesome"})
  )
-- }}}

-- {{{ CLIENTS
keybindings.client_keys = awful.util.table.join(
  awful.key({ altkey, "Shift"   }, "m",      lain.util.magnify_client                         ),
  awful.key({ modkey,           }, "f",
    function (c)
      c.fullscreen = not c.fullscreen
      c:raise()
    end,
    {description = "toggle fullscreen", group = "client"}),
  awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end,
    {description = "close", group = "client"}),
  awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
    {description = "toggle floating", group = "client"}),
  awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
    {description = "move to master", group = "client"}),
  awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
    {description = "move to screen", group = "client"}),
  awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
    {description = "toggle keep on top", group = "client"}),
  awful.key({ modkey,           }, "n",
    function (c)
      -- The client currently has the input focus, so it cannot be
      -- minimized, since minimized clients can't have the focus.
      c.minimized = true
    end ,
    {description = "minimize", group = "client"}),
  awful.key({ modkey,           }, "m",
    function (c)
      c.maximized = not c.maximized
      c.maximized_horizontal = c.maximized
      c.maximized_vertical = c.maximized
      c:raise()
    end ,
    {description = "maximize", group = "client"})
  )

>>>>>>> Stashed changes
-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
<<<<<<< Updated upstream
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
=======
  keybindings.global_keys = awful.util.table.join(keybindings.global_keys,
    -- View tag only.
    awful.key({ modkey }, "#" .. i + 9,
      function ()
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then
          tag:view_only()
        end
      end,
      {description = "view tag #"..i, group = "tag"}),
    -- Toggle tag display.
    awful.key({ modkey, "Control" }, "#" .. i + 9,
      function ()
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then
          awful.tag.viewtoggle(tag)
        end
      end,
      {description = "toggle tag #" .. i, group = "tag"}),
    -- Move client to tag.
    awful.key({ modkey, "Shift" }, "#" .. i + 9,
      function ()
        if client.focus then
          local tag = client.focus.screen.tags[i]
          if tag then
            client.focus:move_to_tag(tag)
          end
        end
      end,
      {description = "move focused client to tag #"..i, group = "tag"}),
    -- Toggle tag on focused client.
    awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
      function ()
        if client.focus then
          local tag = client.focus.screen.tags[i]
          if tag then
            client.focus:toggle_tag(tag)
          end
        end
      end,
      {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
>>>>>>> Stashed changes
end
keybindings.client_buttons = awful.util.table.join(
  awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
  awful.button({ modkey }, 1, awful.mouse.client.move),
  awful.button({ modkey }, 3, awful.mouse.client.resize)
  )
-- }}}
-- TAG LIST
keybindings.taglist_buttons = awful.util.table.join(
  -- awful.button({ }, 1, function(t) t:view_only() end),
  awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
  awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
  )
-- TASK LIST
keybindings.tasklist_buttons = awful.util.table.join(
  awful.button({ }, 1, function (c)
    if c == client.focus then
      c.minimized = true
    else
      -- Without this, the following
      -- :isvisible() makes no sense
      c.minimized = false
      if not c:isvisible() and c.first_tag then
        c.first_tag:view_only()
      end
      -- This will also un-minimize
      -- the client, if needed
      client.focus = c
      c:raise()
    end
  end),
  --[[
   awful.button({ }, 3, function()
       local instance = nil

<<<<<<< Updated upstream
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
=======
       return function ()
           if instance and instance.wibox.visible then
               instance:hide()
               instance = nil
           else
               instance = awful.menu.clients({ theme = { width = 250 } })
           end
      end
   end),
   ]]
  awful.button({ }, 4, awful.client.focus.byidx(1) ),
  awful.button({ }, 5, awful.client.focus.byidx(-1) )
  )
return keybindings
>>>>>>> Stashed changes
