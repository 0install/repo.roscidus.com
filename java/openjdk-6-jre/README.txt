These packages are created by a script that downloads the latest openjdk packages from Debian/stable (with security updates), unpacks them, moves the files around a bit
(to avoid symlinks with absolute paths and to make the layout look more like a normal Java release) and packages up the result.

The script is experimental and currently has to be run manually.
