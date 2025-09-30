#!/bin/sh
echo powersave | sudo tee /sys/devices/system/cpu/cpufreq/policy0/scaling_governor
