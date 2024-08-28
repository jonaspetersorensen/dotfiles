#!/bin/bash

### PURPOSE
# ERROR: "list file for package 'dpkg-dev' is missing final newline" when running an update
# If you check the specific package files you will see that the ones that fail are all binary when they should have been clean text.
# This script will go through all the list files and append "_DAMAGED" to the damaged files,
# and finally it will reinstall those packages.

cd /var/lib/dpkg/info/;
for i in *; do
  if (file $i|grep -P '(?<!__DAMAGED:)[\s]data$'); then
    sudo mv -v "$i" "${i}__DAMAGED";
  fi;
done;
ls *__DAMAGED | cut -d'.' -f1 - | uniq | xargs -I'{}' sudo apt-get install {} --reinstall
