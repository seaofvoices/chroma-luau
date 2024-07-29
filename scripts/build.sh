#!/bin/sh

set -e

scripts/build-single-file.sh .darklua-bundle.json build/chroma.lua
scripts/build-roblox-model.sh .darklua.json build/chroma.rbxm
