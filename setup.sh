#!/usr/bin/env bash

# sudo apt install fd-find ripgrep

C_RED='\033[31m'
C_END='\033[m\n'

ExistCmd() {
    echo "Checking $1"
    type "$1" || (echo -e "${C_RED}Not found: $1${C_END}" && exit 1)
}

SortJson() {
    python3 -c "import sys,json;print(json.dumps(json.loads(sys.stdin.read()),indent=2,ensure_ascii=False,sort_keys=True))"
}

DIR_ROOT="${HOME}/.config/nvim"
mkdir -p "${DIR_ROOT}/lock"

ExistCmd npm || exit 1
ExistCmd pnpm || exit 1
ExistCmd pip || exit 1
ExistCmd python || exit 1
ExistCmd nvim || exit 1

# For nvim-telescope/telescope.nvim
ExistCmd rg
ExistCmd fdfind

if [[ $1 == "load" ]]; then
    pnpm -C "${DIR_ROOT}/tools" install
    nvim --headless "+Lazy restore" "+Lazy clean" +qa

elif [[ $1 == "update" ]]; then
    nvim --headless "+Lazy! sync" "+Lazy clean" +qa
    pnpm -C "${DIR_ROOT}/tools" up --latest
else
    echo -e "\nUsage: $0 [load|update]" >&2
    exit 1
fi

COC_NODE_MODURLES_DIR="$HOME/.config/coc/extensions"
if [[ $1 == "load" ]]; then
    (
        mkdir -p "${COC_NODE_MODURLES_DIR}"
        cp "${DIR_ROOT}/lock/coc.package.json" "${COC_NODE_MODURLES_DIR}/package.json"
        cp "${DIR_ROOT}/lock/coc.package-lock.json" "${COC_NODE_MODURLES_DIR}/package-lock.json"
        npm i -C "${COC_NODE_MODURLES_DIR}"
    )
else
    (
        nvim -c 'CocUpdateSync|q'
        npm i --package-lock-only -C "${COC_NODE_MODURLES_DIR}"
        python -c 'import sys, json; d=json.load(sys.stdin); d.pop("lastUpdate", None); print(json.dumps(d))' \
            <"${COC_NODE_MODURLES_DIR}/package.json" \
            | SortJson >"${DIR_ROOT}/lock/coc.package.json"
        SortJson <"${COC_NODE_MODURLES_DIR}/package-lock.json" >"${DIR_ROOT}/lock/coc.package-lock.json"
    )
fi
