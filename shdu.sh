#!/bin/bash

human_print(){
while read B ; do
  [ "$B" -lt 1024 ] && echo "${B}" B && break
  KB=$(((B+512)/1024))
  [ $KB -lt 1024 ] && echo ${KB} KB && break
  MB=$(((KB+512)/1024))
  [ $MB -lt 1024 ] && echo ${MB} MB && break
  GB=$(((MB+512)/1024))
  [ $GB -lt 1024 ] && echo ${GB} GB && break
  echo $(((GB+512)/1024)) TB
done
}

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
    currentdir=$(echo "$i" | cut -d' ' -f1)
    disk=$(echo "$i" | cut -d' ' -f2 | human_print)
    printf '%s\t%s\n' "$disk" "$currentdir" #"$disk"
  done
  printf '%s\t%s\n' "0" ".."
}

target=$1
while true; do
  next=$(listdirs "$target" | fzf | cut -f2)
  target=$target/$next
  if [ -z "$next" ]; then
    exit 0
  fi
done

