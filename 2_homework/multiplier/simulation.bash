#!/usr/bin/env bash

set -Eeuo pipefail

tb_files=( *_tb.sv )

if [ ${#tb_files[@]} -eq 0 ]; then
    printf '%s: cannot find any "*_tb.sv" files\n' "$(basename "$0")" 1>&2
    exit 1
fi

if [ ${#tb_files[@]} -eq 1 ]; then
    tb_file=${tb_files[0]}
else
    echo "Select a testbench to run:"

    select tb_file in "${tb_files[@]}"
    do
        [ -n "$tb_file" ] && break
    done
fi

echo "Running simulation: $tb_file"

module_name=${tb_file%.sv}

sources=()

for source in *.sv
do
    [[ "$source" == *_tb.sv ]] && continue
    sources+=( "$source" )
done

iverilog -g2012 \
    -s "$module_name" \
    -o "$module_name.vvp" \
    "$tb_file" "${sources[@]}"

vvp "$module_name.vvp"
