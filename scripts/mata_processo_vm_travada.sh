#!/bin/bash

VM="$1"
proc_vm=$(ps -aux |grep "/usr/bin/kvm -id $VM" |awk '{print $2}'|head -2|tail -1)
echo "Matando Processo da VM($VM) Processo: $proc_vm"
kill -9 $proc_vm

