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
system_temp="${system_temp//.*°C/°}"
system_temp=$(echo $system_temp)

cpu_temp="$(echo "$sensors_output" | grep 'CPU:')"
cpu_temp="${cpu_temp#CPU: +}"
cpu_temp="${cpu_temp//.*°C/°}"
cpu_temp=$(echo $cpu_temp)

echo "<executor.markup.true> Temp <span foreground='grey'>CPU:</span>$cpu_temp <span foreground='grey'>Sys:</span>$system_temp <span foreground='grey'>|</span> Fan RPM <span foreground='grey'>CPU:</span>$cpu_fan <span foreground='grey'>Sys1:</span>$system_fan1 <span foreground='grey'>Sys2:</span>$system_fan2 <span foreground='grey'>GPU:</span>$gpu_fan"


