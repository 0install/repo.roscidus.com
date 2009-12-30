#!/bin/sh
args="-rlvt --itemize-changes --progress --exclude debs --exclude build index.html e java shell.sugarlabs.org:/srv/www-roscidus/repo/"

rsync --dry-run $args

echo Press Return to upload...
read foo
rsync $args
