[main]
mixinsdir: device/intel/mixins/groups

[mapping]
product.mk: device.mk

[groups]
boot-arch: minnow_max_mmc
kernel: gmin64
display-density: tv
dalvik-heap: tablet-7in-hdpi-1024
cpu-arch: slm
graphics: ufo_gen7
storage: sdcard-mmcblk1-4xUSB-sda-emulated
ethernet: dhcp
media: ufo
usb: host+acc
usb-gadget: g_android
navigationbar: true
device-type: tablet
factory-scripts: true
sepolicy: intel
disk-bus: mmc-minnow
flashfiles: true
serialport: ttyS0
bluetooth: btusb
suspend: never
memory: ksm
gms: true
