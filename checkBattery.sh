#!/bin/bash
set -e

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
config_file="$DIR/.config"
[ -e "$config_file" ] || { echo "Cannot find .config file."; exit 1; }
source "$config_file"

reminder_percentage=20

battery_percentage=$(ssh -F $HOME/.ssh/config htc '~/dev/BatteryStatus/batteryPercentage.sh' | sed 's/%//')

current_time=$(date '+%Y-%m-%d %H:%M:%S')

[ -z $battery_percentage ] && { echo "$current_time Failed to get battery percentage."; exit 1; }
echo "$current_time $battery_percentage%"

[ -z "$1" ] && exit 0 

[ $battery_percentage -lt $reminder_percentage ] && {
    [ "$1" == '-t' ] && curl -s "http://jenkins.nlprliu.com/job/HTCBattery/build?token=$jenkins_token"
}
