#!/bin/bash
# Inspired by @jessfraz https://github.com/jessfraz/.vim/blob/master/gen-readme.sh
set -e

git submodule --quiet foreach bash -c "echo -e \"- [\$(git config --get remote.origin.url | sed 's/https:\/\///' | sed 's/git:\/\///' | sed 's/.git$//')](\$(git config --get remote.origin.url))\"" | sort --ignore-case
