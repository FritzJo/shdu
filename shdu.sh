#!/bin/bash

listdirs() {
  path=$1
  if [ "$path" = "" ]; then
    path="."
  fi
  dirs=$(find $path -maxdepth 1 -mindepth 1 -type d -printf '%f;')
  directories=($(echo "$dirs" | tr ";" "\n"))

  for i in "${!directories[@]}"; do
    index=$i
    disk=$(du -s $path/"${directories[$index]}" | cut -d'/' -f1)
    directories[$index]="${directories[$index]} $disk"
  done

  IFS=$'\n' sorted=($(sort -k2 -r -n <<<"${directories[*]}"))
  unset IFS

  for i in "${sorted[@]}"; do
    i=$(echo "$i" | cut -d' ' -f1)
    disk=$(du -sh $path/"$i" | cut -d'/' -f1)
    printf '%s\t%s\n' "$i" "$disk"
  done
}

target=$1
while true; do
  next=$(listdirs "$target" | fzf | cut -f1)
  target=$target/$next
  if [ -z "$next" ]; then
    exit 0
  fi
done
