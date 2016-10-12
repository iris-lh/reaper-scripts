#!/bin/bash

script_name=$1

moon_dir="./moon"

if [ -d "$moon_dir" ] && [ ! -d "$moon_dir/$script_name" ]; then
  mkdir $moon_dir/$script_name
  touch $moon_dir/$script_name/main.moon
  printf "external:\nlocal:\n  - main" >> $moon_dir/$script_name/build.yml
fi
