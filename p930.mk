$(call inherit-product, device/lge/iprj-common/iprj.mk)

$(call inherit-product-if-exists, vendor/lge/p930/p930-vendor.mk)

## These are different between models
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/config/bcmdhd.cal:system/etc/wifi/bcmdhd.cal \
    $(LOCAL_PATH)/fstab.iprj:root/fstab.iprj

## Model specific files
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/init.iprj.rc:root/init.iprj.rc

PRODUCT_NAME := full_p930 
PRODUCT_DEVICE := p930 
PRODUCT_MODEL := LG-P930 
