#!/bin/bash

set -e

KERNEL=./popcorn_kernel
JOBS=16

echo "========================================"
echo "Building Popcorn Kernel"
echo "========================================"

echo "[1/5] Cleaning..."
make -C "$KERNEL" clean

echo "[2/5] Generating x86_64 defconfig..."
make -C "$KERNEL" x86_64_defconfig

echo "[3/5] Enabling Popcorn..."
"$KERNEL/scripts/config" --enable POPCORN

echo "[4/5] Enabling CXL..."
"$KERNEL/scripts/config" --enable CXL_BUS
"$KERNEL/scripts/config" --enable CXL_PCI
"$KERNEL/scripts/config" --enable CXL_ACPI
"$KERNEL/scripts/config" --enable CXL_MEM
"$KERNEL/scripts/config" --enable CXL_PORT
"$KERNEL/scripts/config" --enable CXL_REGION

echo
echo "Configuration before olddefconfig:"
grep -E '^CONFIG_(POPCORN|CXL_)' "$KERNEL/.config" || true

echo
echo "Running olddefconfig..."
make -C "$KERNEL" olddefconfig

echo
echo "Final kernel configuration:"
grep -E '^CONFIG_(POPCORN|CXL_)' "$KERNEL/.config" || true

echo
echo "[5/5] Building kernel..."
make -C "$KERNEL" -j"$JOBS"

echo
echo "Copying kernel image..."
cp "$KERNEL/arch/x86/boot/bzImage" ./bzImage

echo
echo "========================================"
echo "Build completed!"
echo "Kernel: ./bzImage"
echo "========================================"