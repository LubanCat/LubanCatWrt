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
echo -n 60000000 > /sys/class/pwm/pwmchip0/pwm0/period
echo -n 1 > /sys/class/pwm/pwmchip0/pwm0/enable

# max speed run 5s
echo -n 50000000 > /sys/class/pwm/pwmchip0/pwm0/duty_cycle
sleep 5
echo -n 0 > /sys/class/pwm/pwmchip0/pwm0/duty_cycle


declare -a CpuTemps=(69000 66000 63000 60000 57000 54000 51000 48000 )
declare -a PwmDutyCycles=(60000000 54000000 48000000 42000000 36000000 30000000 24000000 0)

declare -a Percents=(100 90 80 70 60 50 40 0)
DefaultDuty=0
DefaultPercents=0

while true
do
	temp=$(cat /sys/class/thermal/thermal_zone0/temp)
	INDEX=0
	FOUNDTEMP=0
	DUTY=$DefaultDuty
	PERCENT=$DefaultPercents
	
	for i in 0 1 2 3 4 5 6 7; do
		if [ $temp -gt ${CpuTemps[$i]} ]; then
			INDEX=$i
			FOUNDTEMP=1
			break
		fi	
	done
	if [ ${FOUNDTEMP} == 1 ]; then
		DUTY=${PwmDutyCycles[$i]}
		PERCENT=${Percents[$i]}
	fi

	if [[ $last_dutu -eq '0' ]]; then
		if [[ $DUTY -ne '0' ]]; then 
			echo -n 45000000 > /sys/class/pwm/pwmchip0/pwm0/duty_cycle;
			sleep 1s;
			echo -n $DUTY > /sys/class/pwm/pwmchip0/pwm0/duty_cycle;
		else
			echo -n 0 > /sys/class/pwm/pwmchip0/pwm0/duty_cycle;
		fi
	else
		echo -n $DUTY > /sys/class/pwm/pwmchip0/pwm0/duty_cycle;
	fi

	last_dutu=$DUTY
	echo "temp: $temp, duty: $DUTY, ${PERCENT}%"
	# cat /sys/devices/system/cpu/cpu*/cpufreq/cpuinfo_cur_freq

	sleep 10s;
done
