#!/usr/bin/env bash


echo"nameserver 147.232.16.16" >/etc/resolv.conf
ifconfig enp12s0 147.232.22.158 netmask 255.255.255.224 up
sleep 2
route add default gw 147.232.22.129
sleep 2
ping dennikn.sk -c 2


