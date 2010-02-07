#!/usr/bin/env python
import shutil, os, sys, subprocess
from glob import glob

src_zip = os.path.abspath(sys.argv[1])
assert src_zip.endswith('.zip')
version = os.path.basename(src_zip).split('-', 1)[1].rsplit('.', 1)[0]
print "(version %s)" % version

target_dir = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
os.chdir(target_dir)

# zip+extract attribute doesn't work in 0launch < 0.45, so use .tar.bz2
dest_zip = os.path.join(target_dir, 'hsqldb-bin-%s.tar.bz2' % version)

assert not os.path.exists(dest_zip), "%s already exists" % dest_zip

if os.path.isdir("tmp"):
	shutil.rmtree("tmp")
os.mkdir("tmp")
tmp_dir = os.path.abspath("tmp")

subprocess.check_call(['unzip', src_zip], cwd = tmp_dir)
dist_dir, = glob("tmp/hsqldb*")

os.chdir(dist_dir)

with open("hsqldb/README-ZeroInstall.txt", "w") as stream:
	stream.write("Note: To save space, this package contains just the runtime files (not sources).")

files = glob('hsqldb/*.html') +	\
	glob('hsqldb/*.txt') +	\
	['hsqldb/bin'] +	\
	glob('hsqldb/doc/*.txt') + \
	['hsqldb/lib/hsqldb.jar']

subprocess.check_call(['tar', 'cjf', dest_zip] + files)

print "Wrote", dest_zip
shutil.rmtree(tmp_dir)

os.chdir(target_dir)
subprocess.check_call(['0launch', 'http://0install.net/2006/interfaces/0publish',
			'feed.xml',
			'--add-version=' + version,
			'--set-released=today',
			'--archive-url=http://repo.roscidus.com/java/hsqldb/' + os.path.basename(dest_zip),
			'--archive-file=' + dest_zip,
			'--archive-extract=hsqldb'])
