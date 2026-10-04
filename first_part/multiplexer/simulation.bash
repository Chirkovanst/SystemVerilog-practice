#!/usr/bin/env bash
set -Eeuo pipefail

tb_files=( *_tb.sv )

if [ ${#tb_files[@]} -eq 0 ]; then
    echo "Ошибка: В текущей папке не найдено файлов *_tb.sv" >&2
    exit 1
fi

if [ ${#tb_files[@]} -eq 1 ]; then
    selected_tb="${tb_files[0]}"
else
    echo "Выберите тестбенч для запуска:"
    select selected_tb in "${tb_files[@]}"; do
        [ -n "$selected_tb" ] && break
    done
fi

echo "Запуск симуляции: $selected_tb"

module_name="${selected_tb%.sv}"
iverilog -g2012 -o "${module_name}.vvp" *.sv

vvp "${module_name}.vvp"

if [ -f "dump.vcd" ]; then
    gtkwave dump.vcd &
fi