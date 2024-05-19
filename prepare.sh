#!/bin/bash

# Download the "root" directory from the latest version of the repository linuxserver/docker-syncthing
mkdir -p root
curl -L https://github.com/linuxserver/docker-syncthing/tarball/master | tar xz --strip=1 --wildcards "*/root/*" -C root
# replace 8384 in file "root/etc/s6-overlay/s6-rc.d/svc-syncthing/run"  with "${PORT}"
sed -i 's/8384/${PORT}/g' root/etc/s6-overlay/s6-rc.d/svc-syncthing/run
# Download the "Dockerfile"
curl -L https://raw.githubusercontent.com/linuxserver/docker-syncthing/master/Dockerfile -o Dockerfile
# add a line "ENV PORT=8384" to the file "Dockerfile" after the line "ENV HOME="/config""
sed -i 's/8384/${PORT}/g' Dockerfile
sed -i '/ENV HOME="\/config"/a ENV PORT=8384' Dockerfile