#!/bin/bash
set -e

# Configurable variables
CSI_VERSION="v1.6.0"  # Set the desired version here
CSI_DRIVER="csi-driver-host-path"  # Selector for the driver

# Construct the download URL (using GitHub releases)
DOWNLOAD_URL="https://github.com/kubernetes-csi/${CSI_DRIVER}/archive/refs/tags/${CSI_VERSION}.tar.gz"
DOWNLOAD_DIR="./${CSI_DRIVER}-${CSI_VERSION}"

echo "Downloading ${CSI_DRIVER} version ${CSI_VERSION}..."
mkdir -p "${DOWNLOAD_DIR}"
curl -L "${DOWNLOAD_URL}" -o "${DOWNLOAD_DIR}/driver.tar.gz"

echo "Extracting the CSI driver package..."
tar -xzf "${DOWNLOAD_DIR}/driver.tar.gz" -C "${DOWNLOAD_DIR}"
rm "${DOWNLOAD_DIR}/driver.tar.gz"

echo "Download and extraction complete! The CSI driver files are in ${DOWNLOAD_DIR}/"
