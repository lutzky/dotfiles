#!/bin/bash

sensors_output="$(sensors | grep 'Fan\|^System:\|^CPU:' | sed -e 's/RPM.*//' -e 's/ \s\+/ /' -e 's/$/  /' -e 's/(.*)//')"

cpu_fan="$(echo "$sensors_output" | grep 'CPU Fan')"
cpu_fan="${cpu_fan#CPU Fan: }"
cpu_fan="${cpu_fan// /}"

gpu_fan="$(echo "$sensors_output" | grep 'GPU Fan')"
gpu_fan="${gpu_fan#GPU Fan: }"
gpu_fan="${gpu_fan// /}"

system_fan1="$(echo "$sensors_output" | grep 'System Fan #1')"
system_fan1="${system_fan1#System Fan #1: }"
system_fan1="${system_fan1// /}"

system_fan2="$(echo "$sensors_output" | grep 'System Fan #2')"
system_fan2="${system_fan2#System Fan #2: }"
system_fan2="${system_fan2// /}"

system_temp="$(echo "$sensors_output" | grep 'System:')"
system_temp="${system_temp#System: +}"
system_temp="${system_temp//.*°/°}"
system_temp=$(echo $system_temp)

cpu_temp="$(echo "$sensors_output" | grep 'CPU:')"
cpu_temp="${cpu_temp#CPU: +}"
cpu_temp="${cpu_temp//.*°/°}"
cpu_temp=$(echo $cpu_temp)

echo "Temp (C,S): $cpu_temp,$system_temp | Fan (C,S1,S2,G): $cpu_fan,$system_fan1,$system_fan2,$gpu_fan RPM"


