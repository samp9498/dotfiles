#!/bin/sh
#=#=#=
# xrandr wrapper for switching display at presentaion.
#
# You may change these environment variables. (write and export in 'zshrc')
#
# ```
# OUTPUT_DEV=eDP1
# OUTPUT_RES=1920x1080
# ```
#
# ```
# projector="VGA1"
# projector_mode="1024x768"
# ```
#
# ```
# NAME
#       presenmode.sh - provide easy way to manage the monitors with xrandr.
#
# USAGE
#       presenmode.sh COMMAND [-d output] [-m mode] [-h]
#
# COMMAND
#       start: Start Presentation mode
#       stop : Stop Presentaion mode
#
# OPTION
#       -d: Output device connecting (default: $projector)
#       -m: Manually select the display resolution (default: $projector_mode)
#       -h: Show this message and quit
# ```
#=#=

default_output="${OUTPUT_DEV:-eDP1}"
default_mode="${OUTPUT_RES:-1920x1080}"
projector="VGA1"
projector_mode="1024x768"

f="$0"
usage() {
  sed -n '/^#=#=#=/,/^#=#=/p' $f | sed -e '1d;$d' | cut -b3- | grep -v "\`\`\`"
  exit 1
}

# Manage options
while getopts d:m:hH OPT
do
  case $OPT in
    "d" ) projector="$OPTARG" ;;
    "m" ) projector_mode="$OPTARG" ;;
    "h" ) usage ;;
    "H" ) usage_all "$f"; exit 0 ;;
      * ) usage ;;
  esac
done

# Change X Window setting by xrandr
if [ "$1" = "start" ]; then
  xrandr --output $default_output --mode $projector_mode
  xrandr --output $projector --mode $projector_mode --same-as $default_output
elif [ "$1" = "stop" ]; then
  xrandr --output $projector --off
  xrandr --output $default_output --mode $default_mode
else
  usage
fi
