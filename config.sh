#!/bin/bash

set -e

# AOSP official download:
# https://developers.google.com/android/images
# https://forum.xda-developers.com/nexus-5x/orig-development/rom-cm14-1-nexus-5x-bullhead-t3496798

download_url="https://dl.google.com/dl/android/aosp"


device="bullhead"


# ------------------------------------------------------------------------------
# 7.1.2 (N2G48C, Aug 2017)
# original_aosp_date="201708"
# original_aosp_version="7.1.2"
# original_aosp_revision="n2g48c"
# original_archive_sha256="45d442a26832292df258d7be83de160f280681fa57a12932a3bccfbf088fc337"
# ------------------------------------------------------------------------------
# 8.1.0 (OPM3.171019.016, Mar 2018)
original_aosp_date="201803"
original_aosp_version="8.1.0"
original_aosp_revision="opm3.171019.016"
original_archive_sha256="6e4c89cba89bc9135abf3e8c12fcbf2c2fe77ceaf6ec6dbbb532baa78acf2f50"
# ------------------------------------------------------------------------------


original_archive_filename="${device}-${original_aosp_revision}-factory-${original_archive_sha256:0:8}.zip"

aosp_fullname="aosp_${original_aosp_date}_${original_aosp_version}_${original_aosp_revision}"

main_dir=`pwd`

download_dir="${main_dir}/downloaded"
extracted_dir="${main_dir}/extracted"
final_dir="${main_dir}/${aosp_fullname}"
