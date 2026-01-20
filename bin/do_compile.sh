#!/bin/bash

args=("$@")

# parse args to grab output file
while [[ $# -gt 0 ]]; do
    case $1 in
    -o|--output)
        shift
        OUTPUT_FILE="$1"
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

OUTPUT_FILE_MD5=""
if [ -f "${OUTPUT_FILE}" ]; then
    OUTPUT_FILE_MD5="$(md5sum "${OUTPUT_FILE}" | cut -d' ' -f1)"
fi

# filter out standard happy output lines, because tailwindcss can't do --quiet or similar
tailwindcss "${args[@]}" 2>&1 | grep -v -e '^Done in' -e '^≈ tailwindcss' -e '^\$'

# fail when output file changed
NEW_OUTPUT_FILE_MD5="$(md5sum "${OUTPUT_FILE}" | cut -d' ' -f1)"
if [ "${OUTPUT_FILE_MD5}" != "${NEW_OUTPUT_FILE_MD5}" ]; then
    echo "${OUTPUT_FILE} changed!"
    exit 1
fi
