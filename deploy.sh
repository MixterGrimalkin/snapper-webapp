#!/usr/bin/env bash
scp * pi@192.168.0.51:snapper/webapp
scp -r app pi@192.168.0.51:snapper/webapp
scp -r bin pi@192.168.0.51:snapper/webapp
scp -r config pi@192.168.0.51:snapper/webapp
# database is skipped
scp -r lib pi@192.168.0.51:snapper/webapp
# log is skipped
scp -r public pi@192.168.0.51:snapper/webapp
scp -r test pi@192.168.0.51:snapper/webapp
# tmp is skipped
scp -r vendor pi@192.168.0.51:snapper/webapp
