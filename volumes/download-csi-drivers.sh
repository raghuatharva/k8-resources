#!/bin/bash
set -e  # Exit on error

### 🚀 Step 1: Check for Prerequisites
echo "🔍 Checking prerequisites..."
if ! command -v git &>/dev/null; then
    echo "❌ Error: git is not installed. Please install git and try again."
    exit 1
fi

if ! command -v kubectl &>/dev/null; then
    echo "❌ Error: kubectl is not installed. Please install kubectl and try again."
    exit 1
fi

if ! kubectl cluster-info &>/dev/null; then
    echo "❌ Error: Kubernetes cluster is not running or kubeconfig is not set."
    exit 1
fi

echo "✅ Prerequisites OK!"

### 🚀 Step 2: Create a Temporary Work Directory
WORK_DIR=$(mktemp -d)
echo "📂 Created temporary directory: $WORK_DIR"
cd "$WORK_DIR"

### 🚀 Step 3: Clone the CSI HostPath Driver Repository
echo "📥 Cloning CSI HostPath driver repository..."
git clone https://github.com/kubernetes-csi/csi-driver-host-path.git
cd csi-driver-host-path

### 🚀 Step 4: Identify the Correct Deployment Directory
DEPLOY_DIR=$(find deploy -type d -name "kubernetes*" | sort -r | head -n 1)

if [ -z "$DEPLOY_DIR" ]; then
    echo "❌ Error: No Kubernetes deployment directory found in the repo!"
    exit 1
fi

echo "📂 Using deployment directory: $DEPLOY_DIR"
cd "$DEPLOY_DIR"

### 🚀 Step 5: Apply the CSI Driver Manifests
echo "🚀 Deploying the CSI HostPath driver to the Kubernetes cluster..."
kubectl apply -f .

echo "🎉 CSI HostPath driver installation completed successfully!"

### 🚀 Step 6: Verify Installation
echo "🔍 Verifying installation..."
kubectl get pods -n kube-system | grep csi
