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


declare -a CpuTemps=(83000 81500 80000 78500 77000 75500 74000 72500 71000 69500 68000 66500 65000 63500 62000 60500)
declare -a PwmDutyCycles=(2000000 1900000 1800000 1700000 1600000 1500000 1400000 1300000 1200000 1100000 1000000 900000 800000 700000 600000 0)

declare -a Percents=(100 95 90 85 80 75 70 65 60 55 50 45 40 35 30 0)
DefaultDuty=0
DefaultPercents=0

while true
do
	temp=$(cat /sys/class/thermal/thermal_zone0/temp)
	INDEX=0
	FOUNDTEMP=0
	DUTY=$DefaultDuty
	PERCENT=$DefaultPercents
	
	for i in 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15; do
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

	echo -n $DUTY > /sys/class/pwm/pwmchip0/pwm0/duty_cycle;

        echo "temp: $temp, duty: $DUTY, ${PERCENT}%"
        # cat /sys/devices/system/cpu/cpu*/cpufreq/cpuinfo_cur_freq

	sleep 10s;
done
