# Homelab Notes

This is a my homelab notes.

## Internal Deliverables

* webmin (:10000)
* portainer (:9000)
* docker visualizer (:8080)

## External Devlierables

* ddns (ddns.domain)
* plex (plex.domain)
* ombi (requests.domain)
* nextcloud (reqeusts.domain)

## Manual Pre Installs

* Git
* Webmin
* Caps -> ctrl
* oh my zsh
* vs code
* 1password
* Docker, compose, swarm

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

* may not be needed with eventually with docker swarm

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

* related cname records point to ddns record

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

* MUST FULLY QUALIFY https://domain:port in both 'Custom certificate domain' and 'Custom server access URLs' in settings -> network.
* VERIFY HW TRANSCODE

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

* vpn
* auto encrypt+backup
* https://hub.docker.com/r/linuxserver/unifi-controller
* investigate syncthing, glances, external facing dashboard (muximux?), watchtower, docker sec, smokeping, voip
* script out initial installs and cert authorities
* internal proxy + dns + webmin cert + pfsense cert
* jackett, sonarr, radarr, qbit ect
* log rotation driver with limits

TODO

* cpu limits/prioritization
* tautulli volume issue
* move docker root to workspace ssd
* volume map (plex media)
* plex permissions
* VERIFY plex HW acceleration map
* ssh, sftp, network share

Next
* zfs
* traefik rate limits
* traefik default 404 error behavior
* traefik security mailing for updates
* reduce grub boot wait time from 30