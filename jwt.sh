#!/usr/bin/env bash

# Decode JWT using jq and base64

# Usage:
# $jwtd XXXXXX.YYYYYYY.ZZZZZZZ

jwtd() {
    if [[ -x $(command -v jq) ]]; then
         jq -R 'split(".") | .[0],.[1] | @base64d | fromjson' <<< "${1}"
         echo "Signature: $(echo "${1}" | awk -F'.' '{print $3}')"
    fi
}
