local awful = require("awful")
--STARTUP
--
function run_once(prg,arg_string,pname,screen)
    if not prg then
        do return nil end
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
run_once("firefox",nil,nil,2);
run_once("env STEAM_RUNTIME=0 steam");
run_once("nulloy",nil,nil,2);

