DEVICE_PACKAGE_OVERLAYS += device/intel/baytrail/minnow_max/overlay

BOARD_KERNEL_CMDLINE += i915.disable_power_well=0

BOARD_FLASHFILES += \
	device/intel/baytrail/minnow_max/oemvars.txt:oemvars.txt

# ----------------- BEGIN MIX-IN DEFINITIONS -----------------
# Mix-In definitions are auto-generated by mixin-update
##############################################################
# Source: device/intel/mixins/groups/kernel/gmin64/BoardConfig.mk.1
##############################################################
TARGET_USES_64_BIT_BINDER := true
##############################################################
# Source: device/intel/mixins/groups/kernel/gmin64/BoardConfig.mk
##############################################################
# Specify location of board-specific kernel headers
TARGET_BOARD_KERNEL_HEADERS := device/intel/gmin-kernel/kernel-headers

KERNEL_LOGLEVEL ?= 5

BOARD_KERNEL_CMDLINE += \
        loglevel=$(KERNEL_LOGLEVEL) \
        androidboot.hardware=$(TARGET_DEVICE)\
        firmware_class.path=/system/etc/firmware \

##############################################################
# Source: device/intel/mixins/groups/boot-arch/minnow_max_mmc/BoardConfig.mk
##############################################################
#
# -- OTA RELATED DEFINES --
#

# tell build system where to get the recovery.fstab. Userfastboot
# uses this too.
TARGET_RECOVERY_FSTAB ?= $(TARGET_DEVICE_DIR)/fstab

# Used by ota_from_target_files to add platform-specific directives
# to the OTA updater scripts
TARGET_RELEASETOOLS_EXTENSIONS ?= device/intel/common/recovery/releasetools.py

# Adds edify commands swap_entries and copy_partition for robust
# update of the EFI system partition
TARGET_RECOVERY_UPDATER_LIBS := libupdater_esp

# Extra libraries needed to be rolled into recovery updater
# libgpt_static is needed by libupdater_esp
TARGET_RECOVERY_UPDATER_EXTRA_LIBS := libcommon_recovery libgpt_static

# By default recovery minui expects RGBA framebuffer
# also affects UI in Userfastboot
TARGET_RECOVERY_PIXEL_FORMAT := "BGRA_8888"


#
# FILESYSTEMS
#

# NOTE: These values must be kept in sync with BOARD_GPT_INI
BOARD_SYSTEMIMAGE_PARTITION_SIZE ?= 2684354560
BOARD_BOOTLOADER_PARTITION_SIZE ?= 62914560
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_CACHEIMAGE_PARTITION_SIZE ?= 104857600

TARGET_USERIMAGES_USE_EXT4 := true
BOARD_FLASH_BLOCK_SIZE := 512
TARGET_USERIMAGES_SPARSE_EXT_DISABLED := false

# Partition table configuration file
BOARD_GPT_INI ?= $(TARGET_DEVICE_DIR)/gpt.ini

TARGET_BOOTLOADER_BOARD_NAME := $(TARGET_DEVICE)

#
# Trusted Factory Reset - persistent partition
#
DEVICE_PACKAGE_OVERLAYS += device/intel/common/boot/overlay
ADDITIONAL_DEFAULT_PROPERTIES += ro.frp.pst=/dev/block/by-name/android_persistent

ifeq (user,efi)
# For fastboot-uefi we need to parse gpt.ini into
# a binary format.

#can't use := here, as PRODUCT_OUT is not defined yet
BOARD_GPT_BIN = $(PRODUCT_OUT)/gpt.bin
BOARD_FLASHFILES += $(BOARD_GPT_BIN):gpt.bin
INSTALLED_RADIOIMAGE_TARGET += $(BOARD_GPT_BIN)
else
#
# USERFASTBOOT Configuration
#
TARGET_STAGE_USERFASTBOOT := true
TARGET_USE_USERFASTBOOT := true

BOOTLOADER_ADDITIONAL_DEPS += $(PRODUCT_OUT)/fastboot.img
BOOTLOADER_ADDITIONAL_ARGS += --fastboot $(PRODUCT_OUT)/fastboot.img

BOARD_FLASHFILES += $(BOARD_GPT_INI):gpt.ini
INSTALLED_RADIOIMAGE_TARGET += $(BOARD_GPT_INI)
endif

ifneq ($(EFI_EMMC_BIN),)
BOARD_FLASHFILES += $(EFI_EMMC_BIN):emmc.bin
endif

ifneq ($(EFI_IFWI_BIN),)
BOARD_FLASHFILES += $(EFI_IFWI_BIN):ifwi.bin
endif

##############################################################
# Source: device/intel/mixins/groups/sepolicy/intel/BoardConfig.mk
##############################################################
# SELinux Policy
BOARD_SEPOLICY_DIRS := device/intel/common/sepolicy
BOARD_SEPOLICY_REPLACE := \
    domain.te

# please keep this list in alphabetical order
BOARD_SEPOLICY_UNION := \
    adbd.te \
    bluetooth.te \
    cg2k.te \
    coreu.te \
    cws_manu.te \
    device.te \
    drmserver.te \
    efiprop.te \
    file_contexts \
    file.te \
    genfs_contexts \
    gpsd.te \
    hdcpd.te \
    hostapd.te \
    init.te \
    kernel.te \
    keymaster.te \
    keystore.te \
    mediaserver.te \
    netd.te \
    platform_app.te \
    power_hal_helper.te \
    property_contexts \
    property.te \
    pstore-clean.te \
    recovery.te \
    service_contexts \
    service.te \
    shell.te \
    surfaceflinger.te \
    system_app.te \
    system_server.te \
    te_macros \
    thermal.te \
    ueventd.te \
    untrusted_app.te \
    userfastboot.te \
    vold.te \
    wlan_prov.te \
    wpa.te
##############################################################
# Source: device/intel/mixins/groups/display-density/tv/BoardConfig.mk
##############################################################
ADDITIONAL_DEFAULT_PROPERTIES += ro.sf.lcd_density=213

##############################################################
# Source: device/intel/mixins/groups/cpu-arch/slm/BoardConfig.mk.1
##############################################################
ifeq ($(BOARD_USE_64BIT_USERSPACE),true)
# 64b-specific items:
TARGET_ARCH := x86_64
TARGET_CPU_ABI := x86_64
TARGET_2ND_CPU_ABI := x86
TARGET_2ND_ARCH := x86
TARGET_2ND_ARCH_VARIANT := silvermont
else
# 32b-specific items:
TARGET_ARCH := x86
TARGET_CPU_ABI := x86
endif
##############################################################
# Source: device/intel/mixins/groups/cpu-arch/slm/BoardConfig.mk
##############################################################
# Items that are common between slm 32b and 64b:
TARGET_CPU_ABI_LIST_32_BIT := x86
TARGET_ARCH_VARIANT := silvermont
TARGET_CPU_SMP := true
##############################################################
# Source: device/intel/mixins/groups/houdini/true/BoardConfig.mk
##############################################################
# Install Native Bridge
ifeq ($(WITH_NATIVE_BRIDGE),true)

# Enable ARM codegen for x86 with Native Bridge
BUILD_ARM_FOR_X86 := true

# Native Bridge ABI List
NB_ABI_LIST_32_BIT := armeabi-v7a armeabi
# NB_ABI_LIST_64_BIT := arm64-v8a

# Support 64 Bit Apps
ifeq ($(TARGET_SUPPORTS_64_BIT_APPS),true)
  TARGET_CPU_ABI_LIST_64_BIT ?= $(TARGET_CPU_ABI) $(TARGET_CPU_ABI2)
  ifeq ($(TARGET_SUPPORTS_32_BIT_APPS),true)
    TARGET_CPU_ABI_LIST_32_BIT ?= $(TARGET_2ND_CPU_ABI) $(TARGET_2ND_CPU_ABI2)
  endif
  ifneq ($(findstring ro.zygote=zygote32_64,$(PRODUCT_DEFAULT_PROPERTY_OVERRIDES)),)
    TARGET_CPU_ABI_LIST := \
        $(TARGET_CPU_ABI_LIST_32_BIT) \
        $(TARGET_CPU_ABI_LIST_64_BIT) \
        $(NB_ABI_LIST_32_BIT) \
        $(NB_ABI_LIST_64_BIT)
    TARGET_CPU_ABI_LIST_32_BIT += $(NB_ABI_LIST_32_BIT)
  else
    ifeq ($(TARGET_SUPPORTS_32_BIT_APPS),true)
      TARGET_CPU_ABI_LIST := \
          $(TARGET_CPU_ABI_LIST_64_BIT) \
          $(TARGET_CPU_ABI_LIST_32_BIT) \
          $(NB_ABI_LIST_32_BIT) \
          $(NB_ABI_LIST_64_BIT)
      TARGET_CPU_ABI_LIST_32_BIT += $(NB_ABI_LIST_32_BIT)
    else
      TARGET_CPU_ABI_LIST := $(TARGET_CPU_ABI_LIST_64_BIT) $(NB_ABI_LIST_64_BIT)
    endif
  endif
  TARGET_CPU_ABI_LIST_64_BIT += $(NB_ABI_LIST_64_BIT)

else
  TARGET_CPU_ABI_LIST_32_BIT ?= $(TARGET_CPU_ABI) $(TARGET_CPU_ABI2)
  TARGET_CPU_ABI_LIST_32_BIT += $(NB_ABI_LIST_32_BIT)
  TARGET_CPU_ABI_LIST := $(TARGET_CPU_ABI_LIST_32_BIT)
endif

endif
##############################################################
# Source: device/intel/mixins/groups/graphics/ufo_gen7/BoardConfig.mk.1
##############################################################
# Select ufo gen7 libs
UFO_ENABLE_GEN := gen7

# Defines Intel library for GPU accelerated Renderscript:
OVERRIDE_RS_DRIVER := libRSDriver_intel7.so

##############################################################
# Source: device/intel/mixins/groups/graphics/ufo_gen7/BoardConfig.mk
##############################################################
BOARD_KERNEL_CMDLINE += vga=current i915.modeset=1 drm.vblankoffdelay=1 i915.fastboot=1
USE_OPENGL_RENDERER := true
USE_INTEL_UFO_DRIVER := true
USE_INTEL_UFO_OPENCL := true
NUM_FRAMEBUFFER_SURFACE_BUFFERS := 3
INTEL_VA := true
BOARD_GRAPHIC_IS_GEN := true

# System's VSYNC phase offsets in nanoseconds
VSYNC_EVENT_PHASE_OFFSET_NS := 7500000
SF_VSYNC_EVENT_PHASE_OFFSET_NS := 5000000

# Allow HWC to perform a final CSC on virtual displays
TARGET_FORCE_HWC_FOR_VIRTUAL_DISPLAYS := true

ADDITIONAL_DEFAULT_PROPERTIES += \
	ro.ufo.use_coreu=1

BOARD_SEPOLICY_DIRS += device/intel/common/sepolicy/color_config

# Please keep this list in alphabetical order.
BOARD_SEPOLICY_UNION += \
        file_contexts \
        color_config.te \
##############################################################
# Source: device/intel/mixins/groups/storage/4xUSB-sda-emulated/BoardConfig.mk
##############################################################
DEVICE_PACKAGE_OVERLAYS += device/intel/common/storage/overlay-usb

##############################################################
# Source: device/intel/mixins/groups/media/ufo/BoardConfig.mk
##############################################################
# Settings for the Intel-optimized codecs and plug-ins:
USE_INTEL_MDP := true

# Settings for the Media SDK library and plug-ins:
# - USE_MEDIASDK: use Media SDK support or not
# - MFX_IPP: sets IPP library optimization to use
USE_MEDIASDK := true
MFX_IPP := p8

##############################################################
# Source: device/intel/mixins/groups/navigationbar/true/BoardConfig.mk
##############################################################
DEVICE_PACKAGE_OVERLAYS += device/intel/common/navigationbar/overlay

##############################################################
# Source: device/intel/mixins/groups/device-type/tablet/BoardConfig.mk
##############################################################
DEVICE_PACKAGE_OVERLAYS += device/intel/common/device-type/overlay-tablet
##############################################################
# Source: device/intel/mixins/groups/gms/true/BoardConfig.mk
##############################################################

DEVICE_PACKAGE_OVERLAYS += device/intel/common/gms/overlay
##############################################################
# Source: device/intel/mixins/groups/factory-scripts/true/BoardConfig.mk
##############################################################
# Include factory archive in 'make dist' output
TARGET_BUILD_INTEL_FACTORY_SCRIPTS := true

##############################################################
# Source: device/intel/mixins/groups/widevine/true/BoardConfig.mk
##############################################################
BOARD_USE_INTEL_OEMCRYPTO := true
##############################################################
# Source: device/intel/mixins/groups/flashfiles/true/BoardConfig.mk
##############################################################
FLASHFILES_CONFIG ?= $(TARGET_DEVICE_DIR)/flashfiles.json
USE_INTEL_FLASHFILES := true

##############################################################
# Source: device/intel/mixins/groups/libmintel/true/BoardConfig.mk
##############################################################
TARGET_USE_PRIVATE_LIBM := true

##############################################################
# Source: device/intel/mixins/groups/serialport/ttyS0/BoardConfig.mk
##############################################################
BOARD_KERNEL_CMDLINE += console=ttyS0,115200n8
##############################################################
# Source: device/intel/mixins/groups/bluetooth/btusb/BoardConfig.mk
##############################################################
BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_LINUX := true
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/intel/common/bluetooth/bcm43241/
DEVICE_PACKAGE_OVERLAYS += device/intel/common/bluetooth/overlay-bt-pan

##############################################################
# Source: device/intel/mixins/groups/art-config/default/BoardConfig.mk
##############################################################
# Enable dex-preoptimization to speed up the first boot sequence
# Note that this operation only works on Linux for now
# Enable for non-eng builds
ifneq ($(TARGET_BUILD_VARIANT),eng)
WITH_DEXPREOPT := true
endif

##############################################################
# Source: device/intel/mixins/groups/autodetect/default/BoardConfig.mk
##############################################################
BOARD_SEPOLICY_DIRS += device/intel/common/sepolicy/autodetect/false

# Please keep this list in alphabetical order.
BOARD_SEPOLICY_UNION +=\
	init.te \
##############################################################
# Source: device/intel/mixins/groups/mixin-check/default/BoardConfig.mk
##############################################################
mixin_update := $(wildcard device/intel/mixins/mixin-update)

ifneq ($(mixin_update),)

# TARGET_DEVICE_DIR doesn't get expanded until later. so OK to reference
# this in BoardConfig.mk
.PHONY: check-mixins
check-mixins:
	device/intel/mixins/mixin-update --dry-run --spec $(TARGET_DEVICE_DIR)/mixins.spec

# This invocation of dumpvar gets called during the 'lunch' command. Hook it to
# do some additional checking.
dumpvar-TARGET_DEVICE: check-mixins
droidcore: check-mixins

endif

# ------------------ END MIX-IN DEFINITIONS ------------------

