timer() {
     local ARGS=()
     while [[ $# -gt 0 ]]
     do
         opt="$1"
         case $opt in
             --help)
                 cat <<- EOF
     Usage:
     $ $0 'Message' [OPTIONS]
     Options:
     -M|--msg|--message
     -h|--hours:                 specifies the amount in hours
     -m|--minutes:               specifies the amount in minutes
     -s|--seconds:               specifies the amount in seconds
     -T|--title
     -t|--subtitle
     -o|--open:                  optional URL to open when clicking
     -i|--ignore-do-not-disturb: ignores DnD and awakes!
     -a|--audio:                 whether or not to have the 'bling'
     E.g.:
     $ $0 -h 0 -m 0 -s 5 'Text'  # timer elapsing in 5sec
     $ $0 -h 0 -m 30 'Text'      # timer elapsing in 30min
     $ $0 --audio -m 1 'Text'    # timer with audio feedback
EOF
                 return 0
                 ;;
             -h|--hour|--hours)
                 local HOUR="$2"
                 shift
                 shift
                 ;;
             -m|--min|--minutes)
                 local MIN="$2"
                 shift
                 shift
                 ;;
             -s|--sec|--seconds)
                 local SEC="$2"
                 shift
                 shift
                 ;;
             -T|--title)
                 local TITLE="-title $2"
                 shift
                 shift
                 ;;
             -o|--open)
                 local URL="-o $2"
                 shift
                 shift
                 ;;
             -t|--subtitle)
                 local SUBTITLE="-subtitle $2"
                 shift
                 shift
                 ;;
             -M|--msg|--message)
                 local MSG="$2"
                 shift
                 shift
             ;;
             -i|--ignore-do-not-disturb)
                 local DND="-ignoreDnD"
                 shift
                 ;;
             -a|--audio)
                 local AUDIO="-s default"
                 shift
                 ;;
             *)
                 ARGS+=("$1")
                 shift
                 ;;
         esac
     done
     set -- "${ARGS[@]}"
     if !command -v terminal-notifier &> /dev/null
     then
         echo "'terminal-notifier' could not be found, installing it..."
         if !command -v brew &> /dev/null
         then
             echo "'brew' could not be found, exiting..."
             return -1
         fi
         brew install terminal-notifier
     fi
     echo "Timer started..." \
        && sleep $(echo "${HOUR:-0} * 3600 + ${MIN:-0} * 60 + ${SEC:-0}" | /usr/bin/bc) \
        && echo "$MSG" | terminal-notifier $AUDIO $MSG $TITLE $SUBTITLE $DND ${ARGS[@]}
     return 0
}
