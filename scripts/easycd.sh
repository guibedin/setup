#!/usr/bin/env bash
dir=$(find ~/work ~/personal -mindepth 1 -maxdepth 3 -type d | fzf)
cd $dir
