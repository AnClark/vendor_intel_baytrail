DEVICE_PACKAGE_OVERLAYS += device/intel/baytrail/minnow_max/overlay

# SeLinux Policy
BOARD_SEPOLICY_DIRS := device/intel/baytrail/minnow_max/sepolicy
BOARD_SEPOLICY_REPLACE := \
    domain.te
BOARD_SEPOLICY_UNION := \
    genfs_contexts \
    file_contexts \
    service_contexts \
    platform_app.te \
    coreu.te \
    file.te \
    bluetooth.te \
    device.te \
    gpsd.te \
    init_shell.te \
    netd.te \
    pstore-clean.te \
    surfaceflinger.te \
    system_server.te \
    userfastboot.te  \
    vold.te \
    wpa.te \
    setup_fs.te \
    hdcpd.te \
    init.te \
    kernel.te \
    thermal.te \
    service.te \
    keystore.te \
    drmserver.te \
    mediaserver.te

BOARD_USERDATAIMAGE_PARTITION_SIZE := 4587520000

BOARD_KERNEL_CMDLINE += i915.disable_power_well=0

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
	i915.fastboot=1

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
BOARD_BOOTLOADER_PARTITION_SIZE ?= 104857600
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_CACHEIMAGE_PARTITION_SIZE ?= 268435456
ifneq ($(BOARD_USERDATAIMAGE_PARTITION_SIZE),)
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := ext4
else
ifneq ($(CALLED_FROM_SETUP),true)
$(warning "BOARD_USERDATAIMAGE_PARTITION_SIZE not defined, please specify at the top of your device's BoardConfig.mk")
endif
endif

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

##############################################################
# Source: device/intel/mixins/groups/display-density/tv/BoardConfig.mk
##############################################################
ADDITIONAL_DEFAULT_PROPERTIES += ro.sf.lcd_density=213

##############################################################
# Source: device/intel/mixins/groups/cpu-arch/slm/BoardConfig.mk
##############################################################
TARGET_ARCH := x86
TARGET_CPU_ABI := x86
TARGET_ARCH_VARIANT := silvermont
TARGET_CPU_SMP := true

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
BOARD_KERNEL_CMDLINE += vga=current i915.modeset=1 drm.vblankoffdelay=1
USE_OPENGL_RENDERER := true
USE_INTEL_UFO_DRIVER := true
NUM_FRAMEBUFFER_SURFACE_BUFFERS := 3
INTEL_VA := true
BOARD_GRAPHIC_IS_GEN := true

# System's VSYNC phase offsets in nanoseconds
VSYNC_EVENT_PHASE_OFFSET_NS := 7500000
SF_VSYNC_EVENT_PHASE_OFFSET_NS := 5000000

# Allow HWC to perform a final CSC on virtual displays
TARGET_FORCE_HWC_FOR_VIRTUAL_DISPLAYS := true

ADDITIONAL_DEFAULT_PROPERTIES += \
	persist.intel.ogl.username=Developer \
	persist.intel.ogl.debug=/data/ufo.prop \
	persist.intel.ogl.dumpdebugvars=1 \
	ro.ufo.use_coreu=1

##############################################################
# Source: device/intel/mixins/groups/storage/sdcard-mmcblk1-4xUSB-sda-emulated/BoardConfig.mk
##############################################################
DEVICE_PACKAGE_OVERLAYS += device/intel/common/storage/overlay-sdcard-usb
RECOVERY_HAVE_SD_CARD := true

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
# Source: device/intel/mixins/groups/factory-scripts/true/BoardConfig.mk
##############################################################
# Include factory archive in 'make dist' output
TARGET_BUILD_INTEL_FACTORY_SCRIPTS := true

##############################################################
# Source: device/intel/mixins/groups/flashfiles/true/BoardConfig.mk
##############################################################
FLASHFILES_CONFIG ?= $(TARGET_DEVICE_DIR)/flashfiles.json
USE_INTEL_FLASHFILES := true

##############################################################
# Source: device/intel/mixins/groups/serialport/ttyS0/BoardConfig.mk
##############################################################
BOARD_KERNEL_CMDLINE += console=ttyS0,115200n8
##############################################################
# Source: device/intel/mixins/groups/art-config/default/BoardConfig.mk
##############################################################
# Enable dex-preoptimization to speed up the first boot sequence
# Note that this operation only works on Linux for now
# Enable for user and eng builds
ifneq ($(TARGET_BUILD_VARIANT),userdebug)
WITH_DEXPREOPT := true
endif

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

