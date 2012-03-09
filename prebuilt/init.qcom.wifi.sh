#!/system/bin/sh
# Copyright (c) 2010-2011, Code Aurora Forum. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above
#       copyright notice, this list of conditions and the following
#       disclaimer in the documentation and/or other materials provided
#       with the distribution.
#     * Neither the name of Code Aurora Forum, Inc. nor the names of its
#       contributors may be used to endorse or promote products derived
#      from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESS OR IMPLIED
# WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT
# ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS
# BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
# BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
# OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
# IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
# This script will load and unload the wifi driver to put the wifi in
# in deep sleep mode so that there won't be voltage leakage.
# Loading/Unloading the driver only incase if the Wifi GUI is not going
# to Turn ON the Wifi. In the Script if the wlan driver status is
# ok(GUI loaded the driver) or loading(GUI is loading the driver) then
# the script won't do anything. Otherwise (GUI is not going to Turn On
# the Wifi) the script will load/unload the driver
# This script will get called after post bootup.
target=`getprop ro.product.device`
wifishd=`getprop wlan.driver.status`
case "$target" in
    msm8660*)
    exit 0
    ;;
    msm7630*)
        wlanchip=`cat /persist/wlan_chip_id`
        echo "The WLAN Chip ID is $wlanchip"
        case "$wlanchip" in
            "WCN1314")
             ln -s /system/lib/modules/volans/WCN1314_rf.ko /system/lib/modules/wlan.ko
             ;;
            "WCN1312")
             ln -s /system/lib/modules/libra/libra.ko /system/lib/modules/wlan.ko
	      ;;
           *)
            echo "********************************************************************"
	     echo "*** Error:WI-FI chip ID is not specified in /persist/wlan_chip_id **"
            echo "*******    WI-FI may not work    ***********************************"
            ;;
        esac
        case "$wifishd" in
            "ok")
             ;;
            "loading")
            ;;
           *)
               case "$wlanchip" in
                   "WCN1314")
                    ;;

                   "WCN1312")
                        /system/bin/amploader -i
                        ;;
                   *)
	                ;;
               esac
        esac
    ;;
    msm7627*)
        wifishd=`getprop wlan.driver.status`
        case "$wifishd" in
            "ok")
             ;;
            "loading")
             ;;
            *)
# For the new .38 kernel for 1312, there was an FFA panic
# when no 1312/1314 chip was present. Hence this is commented out
# Will need to reenable this code for 1312.
#
#                /system/bin/amploader -i
            ;;
        esac
    ;;

    *)
      ;;
esac
exit 0
