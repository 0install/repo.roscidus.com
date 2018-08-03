# repo.roscidus.com

http://repo.roscidus.com/ provides [Zero Install](http://0install.net/) feeds for programs and libraries where the upstream authors do not provide feeds of their own. It also serves as a semi-official repository for basic infrastructure components such as libraries and runtime environments. Some packages are created by hand, others are generated automatically from Debian packages. It is kindly hosted by the [FSF](http://www.fsf.org/), and hosts only Free software.

This Git repository tracks changes to these feeds. We use a number of tools to help us manage the content:

[0template](https://github.com/0install/0template) is used to add new releases of applications. It takes a template (e.g., `ffmpeg.xml.template`) and values for placeholders (e.g., a version number) as input and generates a new feed (e.g., `ffmpeg-2.0.0.xml`) as output.

[0watch](https://github.com/0install/0watch) scrapes upstream websites to discover new versions of applications. It runs a watch file (e.g., `ffmpeg.watch.py`) and then automatically calls 0template as needed.

[0repo](https://github.com/0install/0repo) manages the feeds themselves. It merges feeds generated by 0template (e.g., `ffmpeg-2.0.0.xml`) into existing feeds (e.g., `ffmpeg.xml`). It then generates GPG-signed versions of the feeds for hosting.