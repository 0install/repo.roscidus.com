#!/bin/sh
args="-rlvt --itemize-changes --omit-dir-times --progress --exclude debs --exclude *.sw* --exclude build index.html git e devel java lib shell.sugarlabs.org:/srv/www-roscidus/repo/"

rsync --dry-run $args

echo Press Return to upload...
read foo
rsync $args
