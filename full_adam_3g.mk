# Copyright (C) 2011 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

PRODUCT_PACKAGES := \
    Camera \
    LegacyCamera \
    SpareParts \
    PQiToggle \
    Development \
    libmbm-ril \
    Stk \
    Mms \

DEVICE_PACKAGE_OVERLAYS += device/notionink/adam_3g/overlay

# Some files for 3G
PRODUCT_COPY_FILES += \
    device/notionink/adam_3g/files/rild:/system/bin/rild


$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base.mk)

# Inherit from ADAM common device tree
$(call inherit-product, device/notionink/adam_common/device-common.mk)

# The gps config appropriate for this device
$(call inherit-product, device/common/gps/gps_us_supl.mk)

$(call inherit-product-if-exists, vendor/notionink/adam/device-vendor.mk)

PRODUCT_NAME := full_adam_3g
PRODUCT_DEVICE := adam_3g
PRODUCT_BRAND := NotionInk
PRODUCT_MODEL := Notion Ink ADAM

#$(call inherit-product, device/notionink/adam_common/google_apps.mk)
