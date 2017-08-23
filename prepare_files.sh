#!/bin/bash

set -e

# https://forum.xda-developers.com/nexus-5x/orig-development/rom-cm14-1-nexus-5x-bullhead-t3496798
# https://developers.google.com/android/images#bullhead

download_url="https://dl.google.com/dl/android/aosp"

# 7.1.2 (N2G48C, Aug 2017)
original_aosp_date="201708"
original_aosp_version="7.1.2"
original_aosp_revision="n2g48c"
original_archive_sha256="45d442a26832292df258d7be83de160f280681fa57a12932a3bccfbf088fc337"

original_archive_filename="bullhead-${original_aosp_revision}-factory-${original_archive_sha256:0:8}.zip"

extracted_dir="extracted"


main_dir=`pwd`

if [[ ! -f "${original_archive_filename}" ]]; then
    curl -O "${download_url}/${original_archive_filename}"
fi

echo "${original_archive_sha256}  ${original_archive_filename}" > checksum.sha256

# Verify checksum
shasum -a 256 -c checksum.sha256

# Final directory
final_dir="${main_dir}/aosp_${original_aosp_date}_${original_aosp_version}_${original_aosp_revision}"
mkdir -p ${final_dir}

# Extract files
mkdir -p "${extracted_dir}"
cd "${extracted_dir}"
unzip -n ${main_dir}/${original_archive_filename}
cd bullhead-${original_aosp_revision}
unzip -n image-bullhead-${original_aosp_revision}.zip

cp vendor.img ${final_dir}/
cp radio-bullhead-*.img ${final_dir}/
cp bootloader-bullhead-*.img ${final_dir}/

cd ${final_dir}
shasum -a 256 * > checksums.sha256
