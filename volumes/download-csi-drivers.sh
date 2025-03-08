#!/bin/bash
set -e

# Check prerequisites
if ! command -v git &>/dev/null; then
    echo "Error: git is not installed. Please install git."
    exit 1
fi

if ! command -v kubectl &>/dev/null; then
    echo "Error: kubectl is not installed. Please install kubectl."
    exit 1
fi

# Create a temporary work directory
WORK_DIR=$(mktemp -d)
echo "Created temporary directory: $WORK_DIR"
cd "$WORK_DIR"

# Clone the CSI Hostpath Driver repository
echo "Cloning the CSI Hostpath driver repository..."
git clone https://github.com/kubernetes-csi/csi-driver-host-path.git

# Change to the Kubernetes standalone deploy directory
cd csi-driver-host-path/deploy/kubernetes-standalone

# Apply the driver manifests to your cluster
echo "Deploying the CSI Hostpath driver to the Kubernetes cluster..."
kubectl apply -f .

echo "CSI Hostpath driver installation completed successfully!"