# inherit from the proprietary version
-include vendor/lge/p930/BoardConfigVendor.mk

-include device/lge/iprj-common/BoardConfigCommon.mk

TARGET_BOOTLOADER_BOARD_NAME := p930
TARGET_OTA_ASSERT_DEVICE := p930

# Try to build the kernel
TARGET_KERNEL_CONFIG := cyanogenmod_p930_defconfig
# Keep this as a fallback
TARGET_PREBUILT_KERNEL := device/lge/p930/kernel

BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/lge/p930/bluetooth

TARGET_RECOVERY_FSTAB = device/lge/p930/fstab.iprj
