#!/bin/bash

path=$1
if [ "$path" = "" ]; then
  path="."
fi

dirs=$(find $path -maxdepth 1 -mindepth 1 -type d -printf '%f;')
my_array=($(echo $dirs | tr ";" "\n"))

for i in "${!my_array[@]}"
do
  index=$i
  disk=$(du -s $path/${my_array[$index]} | cut -d'/' -f1)
  my_array[$index]="${my_array[$index]} $disk"
done

IFS=$'\n' sorted=($(sort -k2 -r -n <<<"${my_array[*]}")); unset IFS

for i in "${sorted[@]}" 
do 
  i=$(echo $i | cut -d' ' -f1) 
  disk=$(du -sh $path/$i | cut -d'/' -f1)
  printf '%s\t%s\t%s\n' "$i" "$disk"
done

