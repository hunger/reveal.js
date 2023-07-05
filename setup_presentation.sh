#! /usr/bin/bash

sudo pacman -S --noconfirm vscode chromium qt6-base qt6-tools

/usr/bin/code --install-extension rust-lang.rust-analyzer --install-extension Slint.slint

HOME="/home/dev"
EX="/home/extra"

cd "${HOME}/src/reveal.js" || exit

# Clean up local:
( cd "${HOME}"/.local/bin \
  && find . -type l -exec rm \{\} \; )
( cd "${HOME}/.local/bin" \
  && ln -s "${EX}/bin/atuin" . \
  && ln -s "${EX}/bin/starship" . )

rm -rf "${HOME}/.cargo" "${HOME}/.rustup"

rm -rf ~/src/ui-project ~/src/reveal.js/ui-project

PATH="/usr/bin" curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
echo -e "[build]\nrustc-wrapper = \"${EX}/bin/sccache\"" > "${HOME}/.cargo/config.toml"

"${EX}/bin/sccache" -z

( cd "${HOME}/src/reveal.js/heater" && cargo build && cargo build --release )

npm install

npm start &

chromium "http://localhost:8000/" /dev/null 2>&1 &

echo "Run xhost + and make sure to have a terminal window to cxxdev!"

sleep 3600
