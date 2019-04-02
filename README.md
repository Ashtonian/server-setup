# Homelab Notes

This is a my homelab notes.

## Internal Deliverables

- docker readonly sock proxy for security
- docker-swarm + stacks
- webmin (:10000)
- portainer (:9000)
- docker visualizer (:8080)

## External Devlierables

- ddns (ddns.domain)
- https:// via lets-encrypt via traefik
- plex (plex.domain)
- ombi (requests.domain)
- nextcloud (reqeusts.domain)

## Manual Pre Installs

- /etc/default/grub boot time
- Git
- Webmin
- Caps -> ctrl
- oh my zsh
- vs code
- 1password
- Docker, compose, swarm

zfs:

- /etc/default/zfs delay start
- create data sets, update recordset size, enable compression
- take snapshot

Docker:

```shell
# dependencies
sudo apt install apt-transport-https ca-certificates curl software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

sudo apt update
sudo apt install docker-ce

# add user to docker to avoid using sudo
sudo usermod -aG docker $USER
```

Docker-Compose

- may not be needed with eventually with docker swarm

```shell
# must be done with bash, zsh reports parse error due to unescaped regex char
#!/bin/bash
VERSION=$(curl --silent https://api.github.com/repos/docker/compose/releases/latest | jq .name -r)
DESTINATION=/usr/local/bin/docker-compose
sudo curl -L https://github.com/docker/compose/releases/download/${VERSION}/docker-compose-$(uname -s)-$(uname -m) -o $DESTINATION
sudo chmod +x $DESTINATION
```

Docker-Swarm:

```shell
sudo docker swarm init
```

## Additional Expectations

- related cname records point to ddns record

## Stacks

### public net

```shell
docker network create --driver=overlay --attachable public
docker network create --driver=overlay --attachable dockersock
```

### mgmt

Intended to be for internal infrastructure utilities and docker management.

```shell
cd mgmt/
sudo docker stack deploy --compose-file=docker-compose.yml mgmt
```

### plex

Intended for plex and related images. NOTE: plex server will still need manual configuration for dns entry before available.

Manual:

- MUST FULLY QUALIFY https://domain:port in both 'Custom certificate domain' and 'Custom server access URLs' in settings -> network.
- VERIFY HW TRANSCODE

```shell
cd plex/
sudo docker stack deploy --compose-file=docker-compose.yml plex
```

### public

Intended for public services sub plex related.

```shell
cd public/
sudo docker stack deploy --compose-file=docker-compose.yml public
```

## Workspace

One Day Maybe

- vpn
- auto encrypt+backup
- investigate syncthing, glances, external facing dashboard (muximux?), docker sec, smokeping, voip
- script out initial installs and cert authorities
- internal proxy + dns + webmin cert + pfsense cert
- jackett, sonarr, radarr, qbit ect
- log rotation driver with limits

TODO

- https://hub.docker.com/r/linuxserver/unifi-controller
- watchtower
- move docker root to workspace ssd update startexec @ lib/systemd/system/docker.service with --data-root /new_location/
- volume map (plex media)
- plex permissions
- VERIFY plex HW acceleration map
- ssh, sftp, network share

Next

- traefik rate limits https://docs.traefik.io/configuration/commons/#rate-limiting
- traefik default 404 error behavior https://docs.traefik.io/v1.6/configuration/commons/#custom-error-pages
- traefik security mailing for updates

volumes:
dbdata:
driver: local
driver_opts:
type: 'none'
o: 'bind'ro
device: '/srv/db-data'
read_only: true

      version: '3.4'

x-logging:
&default-logging
options:
max-size: '12m'
max-file: '5'
driver: json-file

services:
web:
image: myapp/web:latest
logging: *default-logging
db:
image: mysql:latest
logging: *default-logging

Special Volumes

Pathed Volumes:

- plex config
- tatuti pointed to plex config
- ro tv
- ro movies
- rw nextcloud

Permissions groups:
RW_MEDIA
R_MEDIA

Expected ENV Var:

- NB_DB_ROOT_PASS
- NC_DB_PASS
- CF_API_KEY
