#!/usr/bin/env bash

if [[ -n $ZSH_VERSION ]]; then
    emulate -R ksh
    set -o BSD_ECHO
fi

set -e

SCRIPT_DIR=$(
    cd "$(dirname "${BASH_SOURCE:-$0}")" || exit 1 \
        && pwd
)
unset tmpfile

atexit() {
    [[ -n ${tmpfile-} ]] && rm -f "$tmpfile"
}

trap atexit EXIT
trap 'rc=$?; trap - EXIT; atexit; exit $?' INT PIPE TERM

tmpfile=$(mktemp "/tmp/${0##*/}.tmp.XXXXXX")

CONFIG_ARG="${HOME}/.markdownlintrc"
path_target=$(dirname "$1")
while [ "$path_target" != "/" ]; do
    if [ -f "${path_target}/.markdownlint.json" ]; then
        CONFIG_ARG="${path_target}/.markdownlint.json"
        break
    fi
    path_target=$(dirname "$path_target")
done

DIR_MAKDOWNLINT_PARENT=${SCRIPT_DIR}/tools
if [ -e "${path_target}/node_modules/markdownlint-cli" ]; then
    DIR_MAKDOWNLINT_PARENT=${path_target}
fi

cat - >"$tmpfile"
eval "npx -C ${DIR_MAKDOWNLINT_PARENT} markdownlint -f ${tmpfile} ${CONFIG_ARG}" 2>/dev/null || :
cat "$tmpfile"
