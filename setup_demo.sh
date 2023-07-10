#! /usr/bin/bash

HOME="/home/dev"
DEMO_DIR="${HOME}/src/akademy";
EX="/home/extra"

sudo pacman -S --noconfirm vscode qt6-base qt6-tools

rm -rf ~/.vscode*
/usr/bin/code --install-extension rust-lang.rust-analyzer --install-extension Slint.slint

cd "${HOME}/src/reveal.js" || exit

# Clean up local:
( cd "${HOME}"/.local/bin \
  && find . -type l -exec rm \{\} \; )

rm -rf "${HOME}/.cargo" "${HOME}/.rustup"

PATH="/usr/bin" curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
echo -e "[build]\nrustc-wrapper = \"${EX}/bin/sccache\"" > "${HOME}/.cargo/config.toml"

"${EX}/bin/sccache" -z

rm -rf "${DEMO_DIR}"

mkdir -p "${DEMO_DIR}/ui-project2"
cd "${DEMO_DIR}/ui-project2" || exit

tar -cf - -C "${HOME}/src/reveal.js/heater/" . | tar -xf - -C "${DEMO_DIR}/ui-project2"

( cd "${DEMO_DIR}/ui-project2" && cargo build && cargo build --release && cargo test && cargo doc )

cd "${DEMO_DIR}" || exit 1

clear
fish
