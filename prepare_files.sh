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

tmp_checksum_file=`mktemp`
echo "${original_archive_sha256}  ${original_archive_filename}" > ${tmp_checksum_file}
mv ${tmp_checksum_file} ${download_dir}/${aosp_fullname}.sha256

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
cd "${device}-${original_aosp_revision}"
unzip -n image-${device}-${original_aosp_revision}.zip

cp vendor.img ${final_dir}/
cp radio-${device}-*.img ${final_dir}/
cp bootloader-${device}-*.img ${final_dir}/

cd "${final_dir}"
shasum -a 256 * > checksums.sha256
