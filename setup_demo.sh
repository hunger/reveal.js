#! /usr/bin/bash

HOME="/home/dev"
DEMO_DIR="${HOME}/src/akademy";

rm -rf "${DEMO_DIR}"

mkdir -p "${DEMO_DIR}/ui-project2"
cd "${DEMO_DIR}/ui-project2" || exit

tar -cf - -C "${HOME}/src/reveal.js/heater/" . | tar -xf - -C "${DEMO_DIR}/"

( cd "${DEMO_DIR}/ui-project2" && cargo build && cargo build --release && cargo test && cargo doc )

cd "${DEMO_DIR}" || exit 1

clear
fish
