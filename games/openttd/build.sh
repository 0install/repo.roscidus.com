#!/bin/bash

set -eux

fetch=false
version=1.2.3

if [ $fetch = true ]; then
  cd source
  wget http://binaries.openttd.org/extra/opengfx/0.4.4/opengfx-0.4.4-all.zip
  wget http://binaries.openttd.org/extra/opensfx/0.2.3/opensfx-0.2.3-all.zip
  wget http://ftp.snt.utwente.nl/pub/games/openttd/binaries/extra/openmsx/0.3.1/openmsx-0.3.1-all.zip

  for arch in amd64 i686; do
    wget http://ftp.snt.utwente.nl/pub/games/openttd/binaries/releases/$version/openttd-$version-linux-generic-$arch.tar.xz
  done
  wget http://ftp.snt.utwente.nl/pub/games/openttd/binaries/releases/$version/openttd-$version-macosx-universal.zip
  cd ..
fi

for arch in linux-generic-amd64 linux-generic-i686 macosx-universal; do
  dir=openttd-$version-$arch
  rm -rf $dir
  mkdir $dir && cd $dir

  archive=../source/openttd-$version-$arch.tar.xz
  if [ -f "$archive" ]; then
    tar xf $archive --strip-components=1
  else
    archive=../source/openttd-$version-$arch.zip
    unzip $archive
  fi
  unzip -d data/ ../source/opengfx-0.4.4-all.zip
  unzip -d data/ ../source/opensfx-0.2.3-all.zip
  unzip -d data/ ../source/openmsx-0.3.1-all.zip

  cd ..

  tar cjf $dir.tar.bz2 $dir
  rm -rf $dir
  echo Created $dir.tar.bz2
done
