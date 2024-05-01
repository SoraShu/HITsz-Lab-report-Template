#!/usr/bin/env bash

set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd "$DIR"

NAMESPACE="${TYPST_LOCAL_NAMESPACE:-local}"
NAME=$(cat typst.toml | grep 'name' | cut -d '"' -f 2)
VERSION=$(cat typst.toml | grep 'version' | cut -d '"' -f 2)
DATA_DIR="${XDG_DATA_HOME:-$HOME/.local/share}"

PACKGET_DIR="${DATA_DIR}/typst/packages/${NAMESPACE}/${NAME}/${VERSION}"

read -p "Installing to ${PACKGET_DIR}, [y/n]: " -r
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Aborted."
    exit 1
fi

mkdir -p "$PACKGET_DIR"
cp -r ./* "$PACKGET_DIR"