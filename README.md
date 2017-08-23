# Download, Extract and Flash Nexus Devies

This repository contains two bash scripts for helping download, extract and
flash the official Google monthly updates on Nexus devices.

Tested on a Nexus 5X (bullhead).


## Scripts

### `prepare_files.sh`

This script will download (if not already downloaded) the update from Google
servers and extract the required files in a directory named with the proper
version, for example `aosp_201708_7.1.2_n2g48c` for the August 2017 update.

A checksum file will be generated in that directory.


### `flash.sh`

This script will flash the phone with the files in the `aosp_*` directory.
This procedure should _not_ wipe any user information and should be safe.


## Configuration

The file `config.sh` contains the variable definitions used in both
`prepare_files.sh` and `flash.sh`.

When a new update is released, simply visit the official
[_Factory Images for Nexus and Pixel Devices_](https://developers.google.com/android/images)
page and navigate to your device's section. Change `config.sh` with the new
image's information:
* `original_aosp_date`: Image's date in `YYYYMM` format (for example
  `201708` for August 2017's update);
* `original_aosp_version`: Android version of the update (for example `7.1.2`);
* `original_aosp_revision`: Image's revision (for example `n2g48c`);
* `original_archive_sha256`: Image's SHA-256 checksum (for example `45d442a26832292df258d7be83de160f280681fa57a12932a3bccfbf088fc337`);

Run the `prepare_files.sh` script to download and extract, then `flash.sh` to
flash the update.
