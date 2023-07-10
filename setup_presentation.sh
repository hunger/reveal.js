#! /usr/bin/bash

sudo pacman -S --noconfirm chromium

HOME="/home/dev"

cd "${HOME}/src/reveal.js" || exit

npm install

npm start &

chromium "http://localhost:8000/" /dev/null 2>&1 &

echo "Run xhost + and make sure to have a terminal window to cxxdev!"

sleep 3600
