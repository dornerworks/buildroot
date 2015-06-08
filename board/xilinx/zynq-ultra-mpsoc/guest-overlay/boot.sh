#!/bin/sh

# set -x
mount -t proc none /proc
mount -t tmpfs udev /dev/

mkdir /dev/pts
mkdir /dev/shm
mkdir /dev/snd

mknod -m 622 /dev/console c 5 1
mknod -m 666 /dev/null c 1 3
mknod -m 666 /dev/zero c 1 5
mknod -m 666 /dev/ptmx c 5 2
mknod -m 666 /dev/tty c 5 0
mknod -m 444 /dev/random c 1 8
mknod -m 444 /dev/urandom c 1 9

mount -t devpts devpts /dev/pts
mount -t sysfs none /sys/
mount -t debugfs none /debug/
mount -t tmpfs none /tmp/
mount -t tmpfs none /var/run
mount -o rw,noexec,nosuid,nodev,relatime -t tmpfs shm /dev/shm
echo /sbin/mdev > /proc/sys/kernel/hotplug
/sbin/mdev -s

#stty -F /dev/ttyPS0 115200 clocal cread cs8 -cstopb -parenb

ip link set up dev lo
ip link set up dev eth0

# crazy alsa fixup
ln -s /dev/controlC0 /dev/snd/controlC0
ln -s /dev/controlC1 /dev/snd/controlC1
ln -s /dev/controlC2 /dev/snd/controlC2
ln -s /dev/controlC3 /dev/snd/controlC3
ln -s /dev/pcmC0D0p /dev/snd/pcmC0D0p
ln -s /dev/pcmC0D0c /dev/snd/pcmC0D0c


#ip addr add 192.168.40.100/24 dev eth0
# Add default gw
#ip route add default via 192.168.40.1

#use dhcp
/usr/sbin/inetd -e

syslogd

export LD_LIBRARY_PATH=/lib:/usr/lib:/usr/local/lib
export PATH=$PATH:/usr/local/sbin
export PATH=$PATH:/usr/local/bin

/xenboot.sh

# telnetd

echo "Started Xilinx Dom1"

# Last to give some time for the link to come up
# Only set it up if not XEN
if [ ! -f /proc/xen/capabilities ] || \
   ! grep -q "control_d" /proc/xen/capabilities ; then
	/sbin/udhcpc -i eth0 -b
fi

# exec /bin/sh

