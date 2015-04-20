mount -t xenfs xenfs /proc/xen

# Check for XEN dom0 caps.
if test -f /proc/xen/capabilities && \
   ! grep -q "control_d" /proc/xen/capabilities ; then
        exit 0
fi

[ ! -d /var/log/xen ] && mkdir /var/log/xen
[ ! -d /var/run/xen ] && mkdir /var/run/xen

xenstored
xenstore-write "/local/domain/0/name" "dom0"
xenstore-write "/local/domain/0/domid" 0

xenconsoled

brctl addbr xenbr0
brctl addif xenbr0 eth0
/sbin/udhcpc -i xenbr0 -b

export LIBXL_DEBUG_DUMP_DTB=/tmp/dbg.dtb
