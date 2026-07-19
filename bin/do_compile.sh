#!/bin/bash

args=("$@")

# parse args to grab output file
while [[ $# -gt 0 ]]; do
    case $1 in
    -o|--output)
        shift
        OUTPUT_FILE="$1"
        ;;
    --cwd)
        shift
        CWD="$1"
        ;;
    *)
        break
        ;;
    esac
    shift
done

if [ -z "${OUTPUT_FILE}" ]; then
    echo "You must provide an output file with -o or --output in args"
    exit 1
fi

if [ -n "${CWD}" ]; then
    OUTPUT_FILE="${CWD}/${OUTPUT_FILE}"
fi

OUTPUT_FILE_MD5=""
if [ -f "${OUTPUT_FILE}" ]; then
    OUTPUT_FILE_MD5="$(md5sum "${OUTPUT_FILE}" | cut -d' ' -f1)"
fi

# filter out standard happy output lines, because tailwindcss can't do --quiet or similar
tailwindcss "${args[@]}" 2>&1 | grep -v -e '^Done in' -e '^≈ tailwindcss' -e '^\$'

# add a newline to the end of the output file if it doesn't already have one
if [ -f "${OUTPUT_FILE}" ]; then
    if [ -n "$(tail -c 1 "${OUTPUT_FILE}")" ]; then
        echo "" >>"${OUTPUT_FILE}"
    fi
fi

# fail when output file changed
NEW_OUTPUT_FILE_MD5="$(md5sum "${OUTPUT_FILE}" | cut -d' ' -f1)"
if [ "${OUTPUT_FILE_MD5}" != "${NEW_OUTPUT_FILE_MD5}" ]; then
    echo "${OUTPUT_FILE} changed!"
    exit 1
fi
