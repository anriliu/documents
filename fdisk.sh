#/bin/bash
mkdir /data
#echo 'mount /dev/vdb1 /data' >>/etc/rc.local
#
fdisk /dev/vda << EOF
c
u
d
n
p
1


a
1
w
EOF
exit 0
#fdisk /dev/vdb << EOF
#c
#u
#n
#p
#1


#w
#EOF
