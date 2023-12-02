#!/bin/bash

dir=$(find ~/work -maxdepth 3 -type d | fzf)
cd $dir
pwd
