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

# 3. Enable Popcorn
echo "[3/5] Enabling Popcorn..."
"$KERNEL/scripts/config" --enable POPCORN

# 4. Enable CXL
echo "[4/5] Enabling CXL..."
"$KERNEL/scripts/config" --enable CXL_BUS
"$KERNEL/scripts/config" --enable CXL_PCI
"$KERNEL/scripts/config" --enable CXL_ACPI
"$KERNEL/scripts/config" --enable CXL_MEM
"$KERNEL/scripts/config" --enable CXL_PORT
"$KERNEL/scripts/config" --enable CXL_REGION

# Update configuration
make -C "$KERNEL" olddefconfig

echo
echo "Kernel configuration:"
grep -E '^CONFIG_(POPCORN|CXL_)' "$KERNEL/.config"

# 5. Build
echo
echo "[5/5] Building kernel..."
make -C "$KERNEL" -j16

echo
echo "========================================"
echo "Build completed!"
echo "Kernel:"
echo "$KERNEL/arch/x86/boot/bzImage"
echo "========================================"

cp $KERNEL/arch/x86/boot/bzImage bzImage