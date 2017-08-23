#!/bin/bash

set -e

source config.sh

cd "${main_dir}"

if [[ ! -f "${download_dir}/${original_archive_filename}" ]]; then
    mkdir -p "${download_dir}"
    cd "${download_dir}"
    curl -O "${download_url}/${original_archive_filename}"
    cd "${main_dir}"
fi

echo "${original_archive_sha256}  ${original_archive_filename}" > ${download_dir}/${aosp_fullname}.sha256

# Verify checksum
cd "${download_dir}"
echo shasum -a 256 -c ${aosp_fullname}.sha256
cd "${main_dir}"

# Final directory
mkdir -p ${final_dir}

# Extract files
mkdir -p "${extracted_dir}"
cd "${extracted_dir}"
unzip -n ${download_dir}/${original_archive_filename}
cd "bullhead-${original_aosp_revision}"
unzip -n image-bullhead-${original_aosp_revision}.zip

cp vendor.img ${final_dir}/
cp radio-bullhead-*.img ${final_dir}/
cp bootloader-bullhead-*.img ${final_dir}/

cd "${final_dir}"
shasum -a 256 * > checksums.sha256
