## Specify phone tech before including full_phone
$(call inherit-product, vendor/cm/config/gsm.mk)

# Inherit some common CM stuff.
$(call inherit-product, vendor/cm/config/common_full_phone.mk)

# Inherit device configuration
$(call inherit-product, device/lge/p930/p930.mk)

PRODUCT_NAME := cm_p930

# Release name and versioning
PRODUCT_RELEASE_NAME := OptimusLTE
PRODUCT_VERSION_DEVICE_SPECIFIC := -SelfKANG0

## Device identifier. This must come after all inclusions
PRODUCT_DEVICE := p930

PRODUCT_BUILD_PROP_OVERRIDES += PRODUCT_NAME=lge_iproj BUILD_FINGERPRINT=lge/lge_iproj/lgp930:2.3.5/GRJ90/LG-P930-V10f.19d9f9b804:user/release-keys PRIVATE_BUILD_DESC="i_atnt-user 2.3.5 GRJ90 eng.nick.jeong.20111031.203437 release-keys"
