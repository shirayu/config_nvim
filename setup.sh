#!/usr/bin/env bash

# Requirements:
#   sudo apt install fd-find ripgrep
#   mise (manages gopls and texlab via mise.toml), pnpm, npm, python3, nvim
#
# Usage: ./setup.sh [load|update]
set -euo pipefail

SCRIPT_DIR=$(
    cd "$(dirname "${BASH_SOURCE:-$0}")" || exit 1
    pwd
)
cd "${SCRIPT_DIR}"

C_RED='\033[31m'
C_END='\033[m'

MODE="${1:-}"
case "${MODE}" in
    load | update) ;;
    *)
        echo -e "\nUsage: $0 [load|update]" >&2
        exit 1
        ;;
esac

ExistCmd() {
    echo "Checking $1"
    if ! type "$1"; then
        echo -e "${C_RED}Not found: $1${C_END}\n" >&2
        exit 1
    fi
}

SortJson() {
    python3 -c "import sys,json;print(json.dumps(json.loads(sys.stdin.read()),indent=2,ensure_ascii=False,sort_keys=True))" \
        | npx biome format --stdin-file-path=dummy.json
}

DIR_ROOT="${HOME}/.config/nvim"
mkdir -p "${DIR_ROOT}/lock"

ExistCmd mise
ExistCmd npm
ExistCmd pnpm
ExistCmd pip
ExistCmd python3
ExistCmd nvim

# For nvim-telescope/telescope.nvim
ExistCmd rg
ExistCmd fdfind

AVANTE_SETTING_FILE="${DIR_ROOT}/lua/plugins/settings/avante_setting.lua"
if [[ ! -e ${AVANTE_SETTING_FILE} ]]; then
    echo "Creating ${AVANTE_SETTING_FILE} from the example file"
    cp "${DIR_ROOT}/lua/plugins/settings/avante_setting.example.lua" "${AVANTE_SETTING_FILE}"
fi

COC_EXTENSIONS_DIR="${HOME}/.config/coc/extensions"

case "${MODE}" in
    load)
        mise trust
        mise install
        pnpm install
        pnpm -C "${DIR_ROOT}/tools" install
        nvim --headless "+Lazy restore" "+Lazy clean" +qa

        mkdir -p "${COC_EXTENSIONS_DIR}"
        cp "${DIR_ROOT}/lock/coc.package.json" "${COC_EXTENSIONS_DIR}/package.json"
        cp "${DIR_ROOT}/lock/coc.package-lock.json" "${COC_EXTENSIONS_DIR}/package-lock.json"
        npm i -C "${COC_EXTENSIONS_DIR}"
        ;;
    update)
        mise trust
        mise up
        nvim --headless "+Lazy! sync" "+Lazy clean" +qa
        pnpm up --latest
        pnpm -C "${DIR_ROOT}/tools" up --latest

        nvim -c 'CocUpdateSync|q'
        rm -f "${COC_EXTENSIONS_DIR}/package-lock.json"
        npm i --package-lock-only -C "${COC_EXTENSIONS_DIR}"
        python3 -c 'import sys, json; d=json.load(sys.stdin); d.pop("lastUpdate", None); print(json.dumps(d))' \
            <"${COC_EXTENSIONS_DIR}/package.json" \
            | SortJson >"${DIR_ROOT}/lock/coc.package.json"
        SortJson <"${COC_EXTENSIONS_DIR}/package-lock.json" >"${DIR_ROOT}/lock/coc.package-lock.json"
        ;;
esac
