#!/bin/bash

if [ ! -d /sys/class/pwm/pwmchip0 ]; then
    echo "this model does not support pwm."
    exit 1
fi

if [ ! -d /sys/class/pwm/pwmchip0/pwm0 ]; then
    echo -n 0 > /sys/class/pwm/pwmchip0/export
fi
sleep 1
while [ ! -d /sys/class/pwm/pwmchip0/pwm0 ];
do
    sleep 1
done
ISENABLE=`cat /sys/class/pwm/pwmchip0/pwm0/enable`
if [ $ISENABLE -eq 1 ]; then
    echo -n 0 > /sys/class/pwm/pwmchip0/pwm0/enable
fi
echo -n 2000000 > /sys/class/pwm/pwmchip0/pwm0/period
echo -n 1 > /sys/class/pwm/pwmchip0/pwm0/enable

# max speed run 5s
echo -n 1900000 > /sys/class/pwm/pwmchip0/pwm0/duty_cycle
sleep 5
echo -n 0 > /sys/class/pwm/pwmchip0/pwm0/duty_cycle

declare -a DutyCycles=(0 600000 800000 1000000 1200000 1400000 1600000 1800000 2000000)

DUTY=0
time=0
time_tick=5
time_use=0
count=0
load=0

time_start=$(date '+%s')
echo 'start time: '${time_start}'-----'$(date "+%Y-%m-%d %H:%M:%S")

rm -f fan.log

while true
do
	count=`expr $time / 600`
	
	if [ $count -le '8' ];
	then
		DUTY=${DutyCycles[$count]}
	else
		if [ $load -ge '4' ];
		then
			ps | grep 'dd if'|awk '{print $1}'|xargs kill -9
			echo -n 1000000 > /sys/class/pwm/pwmchip0/pwm0/duty_cycle;
			exit
		fi
		dd if=/dev/zero of=/dev/null bs=1&
		load=`expr $load + 1`
		echo 'load2='${load}
		time=0
	fi

	echo -n $DUTY > /sys/class/pwm/pwmchip0/pwm0/duty_cycle;
	
	freq=$(cat /sys/devices/system/cpu/cpu*/cpufreq/cpuinfo_cur_freq)
	temp=$(cat /sys/class/thermal/thermal_zone0/temp)
	time_now=$(date '+%s')
	time_use=`expr $time_now - $time_start`
	echo 'Time:'${time_use}' Temp:'${temp}' Freq:'${freq}' Duty:'${DUTY}
	echo 'Time:'${time_use}' Temp:'${temp}' Freq:'${freq}' Duty:'${DUTY} >> fan.log
	time=`expr $time + $time_tick`
	sleep ${time_tick}s;

done

