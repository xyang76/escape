#!/bin/bash
set -e

KERNEL="./popcorn_kernel"
SOURCE="./update_kernel"
INPUT="$1"

if [ -z "$INPUT" ]; then
    echo "Usage: $0 <relative-path>"
    exit 1
fi

if [ ! -f "$SOURCE/$INPUT" ]; then
    echo "Source file not found: $SOURCE/$INPUT"
    exit 1
fi

mkdir -p "$(dirname "$KERNEL/$INPUT")"

cp "$SOURCE/$INPUT" "$KERNEL/$INPUT"

echo "Updated: $KERNEL/$INPUT"