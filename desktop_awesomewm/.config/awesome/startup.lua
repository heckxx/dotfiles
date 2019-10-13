local logger  = require("logger")
local awful   = require("awful")
local naughty = require("naughty")

TAG = "startup"
function startup(autorun, autorun_apps)
  if autorun then
    -- Run pgrep to see if program is running
    local function pgrep(command)
      -- Adapted from https://stackoverflow.com/a/23833013
      return io.popen('pgrep -x ' .. command .. ' \necho _$?'):read'*a':match'.*%D(%d+)'+0
    end

    for app_index = 1, #autorun_apps do
      local app = autorun_apps[app_index]
      local cmd = app.target and app.target or app.cmd
      local status = app.always and app.always or pgrep(cmd)

      -- Exit code 1 means the process couldn't be found => probably not running
      if status == 1.0 then
        local command = app.cmd

        -- Add args if defined
        if app.args then
          command = command .. " " .. app.args
        end

        props = app.props and app.props or {}

        -- Spawn the process
        awful.util.spawn(command, props)
        logger.log(TAG, cmd .. " starting", logger.DEBUG)
      else
        logger.log(TAG, cmd .. " already running")
      end

      -- Exit code 2 is invalid syntax, code 3 is a fatal error
      if status == 2.0 then
        logger.log(TAG, "syntax error: " .. cmd, logger.WARN)
        naughty.notify({ 
            preset = naughty.config.presets.critical,
            title = "Oops, autostart program syntax error!",
            text = "Program with invalid syntax: " .. cmd
          })
      end
      if status == 3.0 then
        logger.log(TAG, "fatal error while autostarting " .. cmd, logger.WARN)
        naughty.notify({ 
            preset = naughty.config.presets.critical,
            title = "Oops, fatal error while autostarting!",
            text = "Program causing fatal error: " .. cmd
          })
      end
    end
  end
end

startup(true, {
    -- apply startup settings
    --{ cmd = "xset", args = "m 0 0", always = true }, -- disable mouse acceleration
    { cmd = "xset", args = "-b", always = true }, -- disable hardware beep
    { cmd = "xset", args = "dpms 300 300 300", always = true }, -- DPMS monitor suspend
    { cmd = "xautolock", args = "-detectsleep -time 30 -locker i3lock --blur=5" ..
      " --pass-media-keys --clock --timecolor=ffffffa0 --datecolor=ffffff60 " ..
    " --veriftext='hmmmm' --wrongtext='nope!' -n" },  -- desktop locker
    { cmd = "xmodmap", args = "~/.Xmodmap"}, -- map ctrl to mod
    { cmd = "xbindkeys" },
    { cmd = "numlockx", args = "on" },
    -- startup services/daemons
    { cmd = "~/.config/scripts/wallpaper", args = "slideshow" }, -- wallpaper changer
    { cmd = "redshift" },
    { cmd = "qbittorrent" },
    { cmd = "mpd" },
    { cmd = "mpdscribble" },
    { cmd = "dropbox", args = "start" },
    { cmd = "compton", args = "-b" },
    -- startup programs
    { cmd = "firefox-developer-edition", target = "firefox" },
    { cmd = "hexchat" },
    { cmd = "nulloy" },
    { cmd = "env STEAM_RUNTIME=0 steam", target = "steam" }
  })

