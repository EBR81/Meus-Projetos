#!/bin/bash
echo "$[10 * 2**30 -1]" >/sys/module/zfs/parameters/zfs_arc_min
echo "$[10 * 2**30]" >>/sys/module/zfs/parameters/zfs_arc_max

# Parametro Definitivo
#echo "options zfs zfs_arc_min=$[10 * 2**30 -1]" >/etc/modprobe.d/zfs.conf
#echo "options zfs zfs_arc_max=$[10 * 2**30]" >>/etc/modprobe.d/zfs.conf
#update-initramfs -u -k all
