#!/bin/sh -e

fetch=false
version=1.0.1

if [ $fetch = true ]; then
  cd source
  wget http://binaries.openttd.org/extra/opengfx/0.2.4/opengfx-0.2.4-all.zip
  wget http://binaries.openttd.org/extra/opensfx/0.2.3/opensfx-0.2.3-all.zip
  wget http://binaries.openttd.org/extra/openmsx/0.2.1/openmsx-0.2.1-all.zip

  for arch in amd64 i686; do
    wget http://binaries.openttd.org/releases/$version/openttd-$version-linux-generic-$arch.tar.bz2
  done
  cd ..
fi

for arch in amd64 i686; do
  dir=openttd-$version-linux-$arch
  rm -rf $dir
  mkdir $dir && cd $dir

  tar xf ../source/openttd-$version-linux-generic-$arch.tar.bz2 --strip-components=1
  unzip -d data/ ../source/opengfx-0.2.4-all.zip
  unzip -d data/ ../source/opensfx-0.2.3-all.zip
  unzip -d data/ ../source/openmsx-0.2.1-all.zip

  cd ..

  tar cjf $dir.tar.bz2 $dir
  rm -rf $dir
  echo Created $dir.tar.bz2
done
