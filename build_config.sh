KERNEL=./popcorn_kernel

make -C "$KERNEL" clean
make -C "$KERNEL" x86_64_defconfig

cd "$KERNEL"

scripts/config --enable POPCORN

scripts/config --enable CXL_BUS
scripts/config --enable CXL_PCI
scripts/config --enable CXL_ACPI
scripts/config --enable CXL_MEM
scripts/config --enable CXL_PORT
scripts/config --enable CXL_REGION

echo "Configuration before olddefconfig:"
grep -E '^CONFIG_(POPCORN|CXL_)' .config || true

make olddefconfig

echo "Final kernel configuration:"
grep -E '^CONFIG_(POPCORN|CXL_)' .config || true
