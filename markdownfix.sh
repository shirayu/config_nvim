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

tmpfile=$(mktemp)

CONFIG_ARG=""
path_target=$(dirname "$1")
while [ "$path_target" != "/" ]; do
    for cfg in .markdownlint-cli2.jsonc .markdownlint-cli2.yaml .markdownlint-cli2.cjs .markdownlint-cli2.mjs .markdownlint.json .markdownlint.jsonc .markdownlint.yaml .markdownlint.yml .markdownlintrc; do
        if [ -f "${path_target}/${cfg}" ]; then
            CONFIG_ARG="--config ${path_target}/${cfg}"
            break 2
        fi
    done
    path_target=$(dirname "$path_target")
done
if [ -z "$CONFIG_ARG" ] && [ -f "${HOME}/.markdownlintrc" ]; then
    CONFIG_ARG="--config ${HOME}/.markdownlintrc"
fi

DIR_MAKDOWNLINT_PARENT=${SCRIPT_DIR}/tools
if [ -e "${path_target}/node_modules/markdownlint-cli2" ]; then
    DIR_MAKDOWNLINT_PARENT=${path_target}
fi

cat - >"$tmpfile"

# For debug
# eval "npx -C ${DIR_MAKDOWNLINT_PARENT} markdownlint-cli2 --fix ${CONFIG_ARG} ${tmpfile}" 2>&1 || :

eval "npx -C ${DIR_MAKDOWNLINT_PARENT} markdownlint-cli2 --fix ${CONFIG_ARG} ${tmpfile}" >/dev/null 2>&1 || :
cat "$tmpfile"
