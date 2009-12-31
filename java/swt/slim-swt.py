#!/usr/bin/env python

# The SWT "binary" zips contain source code and a debug jar, wasting a lot of space.
# Remove them.

import sys, os, subprocess, shutil

def clean(dirpath):
	if os.path.isdir(dirpath):
		shutil.rmtree(dirpath)
	os.mkdir(dirpath)
	return dirpath

for zip in sys.argv[1:]:
	target_archive, ext = os.path.splitext(zip)
	assert ext == '.zip'
	target_archive += '.tar.bz2'
	if os.path.exists(target_archive):
		print "Target %s already exists; skipping" % target_archive
		continue

	build = clean('swt')
	subprocess.check_call(['unzip', os.path.abspath(zip)], cwd = 'swt')

	for unneeded in ['.classpath', '.project', 'src.zip', 'swt-debug.jar']:
		os.unlink(os.path.join(build, unneeded))
	
	subprocess.check_call(['tar', 'cjf', target_archive, 'swt'])

shutil.rmtree('swt')
