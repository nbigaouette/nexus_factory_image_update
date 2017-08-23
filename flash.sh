#!/bin/bash

set -e

source config.sh


# Inspired by extracted/bullhead-n2g48c/flash-all.sh
# See:
# https://gist.github.com/MacKentoch/48ad6b91613213ee9774c138267e2ed4
# https://www.reddit.com/r/LineageOS/comments/67agc2/update_of_nexus_5x_to_latest_nightliy_wrong/

img_bootloader=`/bin/ls ${final_dir}/bootloader-bullhead-*.img`
img_radio=`/bin/ls ${final_dir}/radio-bullhead-*.img`
img_vendor=`/bin/ls ${final_dir}/vendor.img`

cd ${final_dir}
shasum -a 256 -c checksums.sha256
cd -

echo "About to flash 'vendor', 'bootloader' and 'radio'. Proceed?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) break;;
        No ) echo "Cancelled, exiting"; exit 1;;
    esac
done

echo ""
echo "--> Rebooting to the bootloader..."
adb reboot bootloader
sleep 5


echo ""
echo "--> Flashing the 'vendor' image..."
fastboot flash vendor ${img_vendor}
fastboot reboot-bootloader
sleep 5

echo ""
echo "--> Flashing the 'bootloader' image..."
fastboot flash bootloader ${img_bootloader}
fastboot reboot-bootloader
sleep 5

echo ""
echo "--> Flashing the 'radio' image..."
fastboot flash radio ${img_radio}
echo "Done!"

echo "Rebooting the device..."
fastboot reboot
