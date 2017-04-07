local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local lain = require("lain")
--local pulseaudio = require("pulseaudio")

markup = lain.util.markup
separators = lain.util.separators

widgets={}
-- Textclock
widgets.clockicon = wibox.widget.imagebox(beautiful.widget_clock)

widgets.mytextclock = lain.widgets.abase({
    timeout  = 60,
    cmd      = "date +'%a %b %d %I:%M'",
    settings = function() 
        widget:set_text("" .. output)
    end
})

-- calendar
lain.widgets.calendar:attach(widgets.mytextclock, { font = "mono", font_size = 9 })

-- Mail IMAP check
widgets.mailicon = wibox.widget.imagebox(beautiful.widget_mail)
widgets.mailicon:buttons(awful.util.table.join(awful.button({ }, 1, function () awful.util.spawn(mail) end)))
--[[ commented because it needs to be set before use
widgets.mailwidget = lain.widgets.imap({
    timeout  = 180,
    server   = "server",
    mail     = "mail",
    password = "keyring get mail",
    settings = function()
        if mailcount > 0 then
            widget:set_text("" .. mailcount .. "")
            mailicon:set_image(beautiful.widget_mail_on)
        else
            widget:set_text("")
            mailicon:set_image(beautiful.widget_mail)
        end
    end
})
]]

-- MPD
widgets.mpdicon = wibox.widget.imagebox(beautiful.widget_music)
widgets.mpdicon:buttons(awful.util.table.join(
    awful.button({ }, 1, function () awful.util.spawn_with_shell("ncmpcpp") end)
))
widgets.mpdwidget = lain.widgets.mpd({
    settings = function()
        if mpd_now.state == "play" then
            artist = "" .. mpd_now.artist .. " "
            title  = mpd_now.title  .. ""
            widgets.mpdicon:set_image(beautiful.widget_music_on)
        elseif mpd_now.state == "pause" then
            artist = "" .. mpd_now.artist .. " "
            title  = mpd_now.title  .. ""
            widgets.mpdicon:set_image(beautiful.widget_music)
        else
            artist = "mpd"
            title  = " stopped"
            widgets.mpdicon:set_image(beautiful.widget_music)
        end

        widget:set_markup(markup("#EA6F81", artist) .. title)
    end
})
widgets.mpdwidget:buttons(awful.util.table.join(
    awful.button({ },9, function () os.execute("mpc next") end),
    awful.button({ },8, function () os.execute("mpc prev") end)
))


-- MEM
widgets.memicon = wibox.widget.imagebox(beautiful.widget_mem)
widgets.memwidget = lain.widgets.mem({
    settings = function()
        widget:set_text("" .. mem_now.used .. "MB ")
    end
})

-- CPU
widgets.cpuicon = wibox.widget.imagebox(beautiful.widget_cpu)
widgets.cpuwidget = lain.widgets.cpu({
    settings = function()
        widget:set_text("" .. cpu_now.usage .. "% ")
    end
})

-- Coretemp
widgets.tempicon = wibox.widget.imagebox(beautiful.widget_temp)
widgets.tempwidget = lain.widgets.temp({
    settings = function()
        widget:set_text("" .. coretemp_now .. "°C ")
    end
})

-- / fs
widgets.fsicon = wibox.widget.imagebox(beautiful.widget_hdd)
widgets.fswidget = lain.widgets.fs({
    settings  = function()
        widget:set_text("" .. fs_now.used .. "% ")
    end
})

-- Battery
widgets.baticon = wibox.widget.imagebox(beautiful.widget_battery)
widgets.batwidget = lain.widgets.bat({
    battery = "BAT1",
    settings = function()
        if bat_now.perc == "N/A" then
            widget:set_markup(" AC ")
            widgets.baticon:set_image(beautiful.widget_ac)
            return
        elseif tonumber(bat_now.perc) <= 5 then
            widgets.baticon:set_image(beautiful.widget_battery_empty)
        elseif tonumber(bat_now.perc) <= 15 then
            widgets.baticon:set_image(beautiful.widget_battery_low)
        else
            widgets.baticon:set_image(beautiful.widget_battery)
        end
        widget:set_markup("" .. bat_now.perc .. "% ")
    end
})
--
-- ALSA volume
widgets.volicon = wibox.widget.imagebox(beautiful.widget_vol)
widgets.volumewidget = lain.widgets.alsa({
    settings = function()
        if volume_now.status == "off" then
            widgets.volicon:set_image(beautiful.widget_vol_mute)
        elseif tonumber(volume_now.level) == 0 then
            widgets.volicon:set_image(beautiful.widget_vol_no)
        elseif tonumber(volume_now.level) <= 50 then
            widgets.volicon:set_image(beautiful.widget_vol_low)
        else
            widgets.volicon:set_image(beautiful.widget_vol)
        end
        widget:set_text("" .. volume_now.level .. "% ")
    end
})
widgets.volicon:buttons(awful.util.table.join(
    awful.button({}, 4, function () os.execute("amixer -D pulse set Master playback 3%+") widgets.volumewidget.update() end),
    awful.button({}, 5, function () os.execute("amixer -D pulse set Master playback 3%-") widgets.volumewidget.update() end),
    awful.button({}, 2, function () os.execute("amixer -D pulse set Master playback toggle") widgets.volumewidget.update() end)
    ))
widgets.volumewidget.widget:buttons(awful.util.table.join(
    awful.button({}, 4, function () os.execute("amixer -D pulse set Master playback 3%+") widgets.volumewidget.update() end),
    awful.button({}, 5, function () os.execute("amixer -D pulse set Master playback 3%-") widgets.volumewidget.update() end),
    awful.button({}, 2, function () os.execute("amixer -D pulse set Master playback toggle") widgets.volumewidget.update() end)
    ))

-- Net
widgets.neticon = wibox.widget.imagebox(beautiful.widget_net)
widgets.neticon:buttons(awful.util.table.join(
    awful.button({}, 1, function() os.execute("wifi toggle") end)
))
--widgets.neticon:buttons(awful.util.table.join(awful.button({ }, 1, function () awful.util.spawn_with_shell(iptraf) end)))
widgets.netwidget = lain.widgets.net({
    --stats = true,
    units = 1024^2,
    timeout = 1,
    iface = { "enp3s0" },
    settings = function()
        if net_now.state == "up" then
            widget:set_markup(markup("#7AC82E", "" .. net_now.received)
                              .. " " ..
                              markup("#46A8C3", " " .. net_now.sent .. ""))
        else
            widget:set_text("");
        end
    end
})

-- Separators
widgets.spr = wibox.widget.textbox(' ')
widgets.arrl = wibox.widget.imagebox()
widgets.arrl:set_image(beautiful.arrl)
widgets.arrl_dl = separators.arrow_left(beautiful.bg_focus, "alpha") 
widgets.arrl_ld = separators.arrow_left("alpha", beautiful.bg_focus) 

widgets.twitch_notify = lain.widgets.base({
    timeout = 30,
    cmd = "head -1 /home/edward/.config/scripts/twitch_status",
    settings = function()
        widget:set_text(output);
    end
})

return widgets
