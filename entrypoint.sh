#!/bin/sh
set -e

WIKI_NAME="${WIKI_NAME:-wiki}"
PORT="${PORT:-8080}"
HOST="${HOST:-0.0.0.0}"
WIKI_DIR="/data/${WIKI_NAME}"

if [ ! -f "${WIKI_DIR}/tiddlywiki.info" ]; then
    echo "Initializing new wiki at ${WIKI_DIR}"
    cd /data
    tiddlywiki "${WIKI_NAME}" --init server
fi

exec tiddlywiki "${WIKI_DIR}" --listen host="${HOST}" port="${PORT}" "$@"
