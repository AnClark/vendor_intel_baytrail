[main]
mixinsdir: device/intel/mixins/groups

[mapping]
product.mk: device.mk

[groups]
kernel: gmin64(path=gmin,loglevel=5)
boot-arch: minnow_max_mmc(uefi_arch=x86_64,fastboot=user)
display-density: low
dalvik-heap: tablet-7in-hdpi-1024
cpu-arch: slm_64bit
graphics: ufo_gen7
storage: 4xUSB-sda-emulated
ethernet: dhcp
media: ufo
usb: host
navigationbar: true
device-type: tablet
factory-scripts: true
sepolicy: intel
disk-bus: mmc-minnow
flashfiles: true
serialport: ttyS0
bluetooth: btusb
audio: hdmi+usb
suspend: never
memory: ksm
adb_net: true
