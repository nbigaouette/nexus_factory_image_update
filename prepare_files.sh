#!/bin/bash

set -e

source config.sh

if [[ ! -f "${original_archive_filename}" ]]; then
    curl -O "${download_url}/${original_archive_filename}"
fi

echo "${original_archive_sha256}  ${original_archive_filename}" > checksum.sha256

# Verify checksum
shasum -a 256 -c checksum.sha256

# Final directory
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
