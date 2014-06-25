#!/bin/bash
# Run Resin server without interation

# CPR : Jd Daniel :: Ehime-ken
# MOD : 2014-06-25 @ 13:50:52
# INP : $ run


###############################
###############################

function run () 
{
  clear

  osascript 2>/dev/null <<EOF
    tell application "System Events"
      tell process "Terminal" to keystroke "t" using command down
    end

    tell application "Terminal"
      activate
      do script with command "
        cd ~/Eclipse/CVSZR/Filson/setup/_run/filson.com/zrmacdev/

        netextender 72.175.244.2:4433   \
            --username=$F_USER          \
            --password=$F_PASS          \
            --domain=$F_DOMAIN          &

          sleep 3 ## waiting for extender to load

        bash start_apache.command       & 

          clear

        bash run_resin.command
       " in window 1
    end tell
EOF
}