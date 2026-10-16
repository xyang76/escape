#!/bin/bash

popcorn=./popcorn-kernel
text="$1"

grep -R -n "$text" "$popcorn"