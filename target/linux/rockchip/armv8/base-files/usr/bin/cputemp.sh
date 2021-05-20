#!/bin/bash

a=30
b=41
frq=0
tmp=0
while true
do
tmp=$((`cat /sys/class/thermal/thermal_zone0/temp`/1000))
#$((`cat /sys/class/thermal/thermal_zone0/temp|cut -c1-2`)).$((`cat /sys/clas
frq=$(cat /sys/devices/system/cpu/cpu[04]/cpufreq/cpuinfo_cur_freq)
echo -e "\033[${a}m Current cpu frequency: [$frq] \033[0m"
echo -e "\033[${a}m Temperature: [$tmp] \033[0m"
a=$(($(($a%7))+30))
b=$(($(($b%7))+40))
echo -e "\033[4A\033[0m"
sleep 1s;
done

