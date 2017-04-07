#!/bin/bash
while true; do
    /home/edward/git/clones/TwitchNotifier/twitchnotifier -c heckxx --config=/home/edward/git/clones/TwitchNotifier/twitchnotifier.cfg -n | grep : > /home/edward/.config/scripts/twitch_status
    sleep 30s
done
