#!/bin/sh -e

if [ ! -d "$1" ]; then
	echo "Usage: $0 section/package"
	exit 1
fi

#args="-rlvt --chmod=ugo=rwX --itemize-changes --omit-dir-times --progress --exclude debs --exclude *.sw* --exclude build index.html style.css git e devel java keys lib interface.xsl shell.sugarlabs.org:/srv/www-roscidus/repo/"

args="-rlvt --chmod=ugo=rwX --itemize-changes --omit-dir-times --progress --exclude debs --exclude build $1/*.tar.bz2 shell.sugarlabs.org:/srv/www-roscidus/repo/$1"

rsync --dry-run $args

echo Press Return to upload...
read foo
rsync $args
