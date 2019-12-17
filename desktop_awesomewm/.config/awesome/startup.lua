<<<<<<< Updated upstream
local awful = require("awful")
--STARTUP
--
function run_once(prg,arg_string,pname,screen)
    if not prg then
        do return nil end
=======
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
>>>>>>> Stashed changes
    end

    if not pname then
       pname = prg
    end
    if not arg_string then 
        awful.util.spawn_with_shell("pgrep -f -u $USER -x '" .. pname .. "' || (" .. prg .. ")")
    else
        awful.util.spawn_with_shell("pgrep -f -u $USER -x '" .. pname .. " ".. arg_string .."' || (" .. prg .. " " .. arg_string .. ")")
    end
end

<<<<<<< Updated upstream
--startup scripts/settings
run_once("~/.config/scripts/wallpaper","slideshow"); -- wallpaper changer
--run_once("xset","m 0 0"); -- disable mouse acceleration
run_once("xset","-b"); -- disable hardware beep
run_once("xautolock","-detectsleep -time 30 -locker \"i3lock-fancy -gp\""); -- desktop locker
run_once("xmodmap","~/.Xmodmap"); -- map ctrl to mod
run_once("setxkbmap","option ctrl:nocaps"); -- map capslock to ctrl
run_once("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"); -- Authentication agent (for mounting)
--startup services/daemons
run_once("redshift");
run_once("deluge");
--run_once("subsonic");
run_once("mpd");
run_once("mpdscribble");
run_once("dropbox start");
run_once("xbindkeys");
run_once("numlockx on");
--startup programs
run_once("firefox-developer-edition",nil,nil,2);
run_once("env STEAM_RUNTIME=0 steam");
run_once("nulloy",nil,nil,2);
=======
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
>>>>>>> Stashed changes

