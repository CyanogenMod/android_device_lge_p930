LOCAL_PATH := $(call my-dir)

## Try to build the kernel
KERNEL_DEFCONFIG := cyanogenmod_iprj_defconfig
-include kernel/lge/p930/AndroidKernel.mk

## Use prebuilt if kernel source is unavailable
ifeq ($(TARGET_PREBUILT_KERNEL),)
    TARGET_PREBUILT_KERNEL := device/lge/p930/kernel
endif

file := $(INSTALLED_KERNEL_TARGET)
ALL_PREBUILT += $(file)
$(file) : $(TARGET_PREBUILT_KERNEL) | $(ACP)
	$(transform-prebuilt-to-target)

include $(CLEAR_VARS)

ALL_PREBUILT += $(INSTALLED_KERNEL_TARGET)

# include the non-open-source counterpart to this file
-include vendor/lge/p930/AndroidBoardVendor.mk
