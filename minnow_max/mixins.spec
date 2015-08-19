[main]
mixinsdir: device/intel/mixins/groups

[mapping]
product.mk: device.mk

[groups]
kernel: gmin64(path=device/intel/gmin-kernel,src_path=kernel/gmin,quilt_build_script=./byt-git-build.sh,loglevel=5,binary_name=bzImage, interactive_governor=false)
boot-arch: efi(uefi_arch=x86_64,fastbootefi=false,acpi_permissive=true,device=/dev/block/mmcblk0)
sepolicy: intel
display-density: tv
dalvik-heap: tablet-7in-hdpi-1024
cpu-arch: slm
graphics: ufo_gen7(use_opencl=true)
storage: 4xUSB-sda-emulated
ethernet: dhcp
audio: hdmi+usb
media: ufo
usb: host+acc
navigationbar: true
device-type: tablet
factory-scripts: true
disk-bus: mmc-minnow
flashfiles: json
memory: ksm
serialport: ttyS0
suspend: never
bluetooth: btusb
adb_net: true
