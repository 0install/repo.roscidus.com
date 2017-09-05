from urllib import request
import json

def convert(release):
    return {
        'version': release['tag_name'],
        'stability': 'testing' if release['prerelease'] else 'stable',
        'released': release['published_at'][0:10]
    }

data = request.urlopen('https://api.github.com/repos/docker/compose/releases').read()
releases = [convert(release) for release in json.loads(data)]