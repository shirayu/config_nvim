#!/usr/bin/env bash

ExistCmd() {
    echo "Checking $1"
    type "$1" || (echo "$2" && exit 1)
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

if [[ $1 == "load" ]]; then
    pnpm -C "${DIR_ROOT}/tools" install

elif [[ $1 == "update" ]]; then
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
        TAGERT=$(echo \
            coc-lua \
            coc-markdownlint \
            coc-diagnostic \
            coc-css \
            coc-json \
            coc-yaml \
            coc-texlab \
            coc-pyright \
            coc-tsserver \
            coc-sh \
            coc-biome \
            coc-toml \
            coc-go)
        nvim -c "CocInstall -sync ${TAGERT}" +qall
        npm i --package-lock-only -C "${COC_NODE_MODURLES_DIR}"
        SortJson <"${COC_NODE_MODURLES_DIR}/package.json" >"${DIR_ROOT}/lock/coc.package.json"
        SortJson <"${COC_NODE_MODURLES_DIR}/package-lock.json" >"${DIR_ROOT}/lock/coc.package-lock.json"
    )
fi
