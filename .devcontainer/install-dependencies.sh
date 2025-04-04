#!/usr/bin/bash

set -ex

remove_installation_stuff() {
    # Create a list of items
    items=("capstone*" "basenine*")

    # Loop through each item in the list
    echo "Cleaning up following items:"
    for item in "${items[@]}"; do
        echo "Item: $item"
        rm -fr ${item}
    done
}

remove_installation_stuff

echo "Installing build env..."
sudo apt update && sudo apt upgrade -y && sudo apt install -y \
    cmake \
    libpcap-dev \
    g++ \
    curl \
    build-essential \
    binutils-gold \
    bash \
    clang \
    llvm \
    libbpf-dev

echo "Installing Capstone..."
./.devcontainer/install-capstone.sh

echo "Download Basenine executable, verify the sha1sum"
rm -rf ./basenin*
GOARCH=$(go env GOARCH)
curl -LO https://github.com/up9inc/basenine/releases/download/v0.8.3/basenine_linux_"${GOARCH}"
curl -LO https://github.com/up9inc/basenine/releases/download/v0.8.3/basenine_linux_amd64.sha256
shasum -a 256 -c basenine_linux_"${GOARCH}".sha256
chmod +x ./basenine_linux_"${GOARCH}"
sudo mv ./basenine_linux_"${GOARCH}" /usr/local/bin/basenine

echo "Installing CobraCLI..."
go install github.com/spf13/cobra-cli@latest

remove_installation_stuff
