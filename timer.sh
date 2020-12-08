#!/bin/bash
ARGS=()
while [[ $# -gt 0 ]]
do
    opt="$1"
    case $opt in
        --help)
            echo "Usage:"
            echo "  $ $0 'Message' [OPTIONS]"
            echo "Options:"
            echo "  -M|--msg|--message"
            echo "  -h|--hours:                 specifies the amount in hours"
            echo "  -m|--minutes:               specifies the amount in minutes"
            echo "  -s|--seconds:               specifies the amount in seconds"
            echo "  -T|--title"
            echo "  -t|--subtitle"
            echo "  -o|--open:                  optional URL to open when clicking"
            echo "  -i|--ignore-do-not-disturb: ignores DnD and awakes\!"
            echo "  -a|--audio:                 whether or not to have the 'bling'"
            echo "E.g.:"
            echo "  $ $0 -h 0 -m 0 -s 5 'Text'  # timer elapsing in 5sec"
            echo "  $ $0 -h 0 -m 30 'Text'  # timer elapsing in 30min"
            echo "  $ $0 --audio -m 1 'Text'  # timer with audio feedback"
            exit 0
            ;;
        -h|--hour|--hours)
            HOUR="$2"
            shift
            shift
            ;;
        -m|--min|--minutes)
            MIN="$2"
            shift
            shift
            ;;
        -s|--sec|--seconds)
            SEC="$2"
            shift
            shift
            ;;
        -T|--title)
            TITLE="-title $2"
            shift
            shift
            ;;
        -o|--open)
            URL="-o $2"
            shift
            shift
            ;;
        -t|--subtitle)
            SUBTITLE="-subtitle $2"
            shift
            shift
            ;;
        -M|--msg|--message)
            MSG="$2"
            shift
            shift
            ;;
        -i|--ignore-do-not-disturb)
            DND="-ignoreDnD"
            shift
            ;;
        -a|--audio)
            AUDIO="-s default"
            shift
            ;;
        *)
            ARGS+=("$1")
            shift
            ;;
    esac
done
set -- "${ARGS[@]}"
if ! command -v terminal-notifier &> /dev/null
then
    echo "'terminal-notifier' could not be found, installing it..."
    brew install terminal-notifier
fi
echo "Timer started..." && sleep $(echo "${HOUR:-0} * 3600 + ${MIN:-0} * 60 + ${SEC:-0}" | /usr/bin/bc) && echo "$MSG" | terminal-notifier $AUDIO $MSG $TITLE $SUBTITLE $DND ${ARGS[@]}
