#!/bin/bash

set -e

KERNEL=./popcorn_kernel

echo "========================================"
echo "Building Popcorn Kernel"
echo "========================================"

# 1. Clean previous build
echo "[1/5] Cleaning..."
make -C "$KERNEL" clean

# 2. Generate x86_64 default configuration
echo "[2/5] Generating x86_64 defconfig..."
make -C "$KERNEL" x86_64_defconfig

# Enter kernel directory
cd "$KERNEL"

# 3. Enable Popcorn
echo "[3/5] Enabling Popcorn..."
scripts/config --enable POPCORN

# 4. Enable CXL
echo "[4/5] Enabling CXL..."
scripts/config --enable CXL_BUS
scripts/config --enable CXL_PCI
scripts/config --enable CXL_ACPI
scripts/config --enable CXL_MEM
scripts/config --enable CXL_PORT
scripts/config --enable CXL_REGION

# Update configuration
make olddefconfig

echo
echo "Kernel configuration:"
grep -E '^CONFIG_(POPCORN|CXL_)' .config

# 5. Build
echo
echo "[5/5] Building kernel..."
make -j16

# Return to project root
cd ..

echo
echo "========================================"
echo "Build completed!"
echo "Kernel:"
echo "$KERNEL/arch/x86/boot/bzImage"
echo "========================================"

cp "$KERNEL/arch/x86/boot/bzImage" bzImage
