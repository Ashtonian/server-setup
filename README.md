# Homelab Notes

This is a my homelab notes.

## Internal Deliverables

- docker readonly sock proxy for security
- docker-swarm + stacks
- webmin (:10000)
- portainer (:9000)
- docker visualizer (:8080)
- organizer
- jackett
- lidarr
- radarr
- sonarr
- tautulli

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
- enable ubuntu auto updates
- mkvtools
- lftp
- delete ubuntu spam from store

zfs:

- /etc/default/zfs delay start
- create data sets, update recordset size, enable compression
- enable zed and test with scrub
- import using dev-id verify with zpool status
- take snapshot

```shell
sudo zfs set compression=lz4 lutece
sudo zfs create lutece/media
sudo zfs set recordsize=1m lutece/media
sudo zfs create lutece/media/movies
sudo zfs create lutece/media/movies4k
sudo zfs create lutece/media/tv
sudo zfs create lutece/media/pictures
sudo zfs create lutece/media/books
sudo zfs set compression=gzip-9 lutece/media/books
sudo zfs create lutece/media/music
sudo mkdir /lutece/media/ringtones
sudo zfs create lutece/docs
sudo zfs set compression=gzip-9 lutece/docs
sudo zfs create lutece/proj
sudo zfs set compression=gzip-9 lutece/proj
sudo zfs create lutece/apps
sudo mkdir /lutece/apps/nextcloud
sudo zfs create lutece/backup
sudo zfs create lutece/tmp
sudo zfs create lutece/public
sudo zfs create lutece/drop
sudo zfs create lutece/fam
```

Permissions:

```shell

#sudo groupadd mediaro
sudo groupadd mediarw

sudo chmod o=rX,g=rwX,u=--- -R /lutece/media/
sudo chown :mediarw -R /lutece/media/

sudo adduser --system --no-create-home --group --disabled-login --shell=/bin/false --uid 5000 plex
#sudo usermod -a -G mediaro plex
#sudo mkdir /mnt/workspace/plex
sudo chmod o=r,g=rwX,u=rwX -R /mnt/workspace/plex
sudo chown plex:plex -R /mnt/workspace/plex

sudo groupadd apps

sudo adduser --system --no-create-home --group --disabled-login --shell=/bin/false --uid 5001 nextcloud
sudo usermod -a -G apps nextcloud
sudo chown :apps /lutece/apps/

sudo adduser --system --no-create-home --group --disabled-login --shell=/bin/false --uid 5002 tautulli

sudo adduser --system --no-create-home --group --disabled-login --shell=/bin/false --uid 5003 ombi

sudo adduser --system --no-create-home --group --disabled-login --shell=/bin/false --uid 5004 radarr
sudo adduser --system --no-create-home --group --disabled-login --shell=/bin/false --uid 5005 sonarr
sudo adduser --system --no-create-home --group --disabled-login --shell=/bin/false --uid 5006 lidarr
sudo adduser --system --no-create-home --group --disabled-login --shell=/bin/false --uid 5007 jackett
sudo adduser --system --no-create-home --group --disabled-login --shell=/bin/false --uid 5009 organizr
sudo adduser --system --no-create-home --group --disabled-login --shell=/bin/false --uid 5011 bazarr
sudo usermod -a -G radarr,sonarr bazarr


sudo adduser --system --no-create-home --group --disabled-login --shell=/bin/false --uid 5008 lftp


sudo usermod -a -G lftp radarr # would be cool to not have to do this if lftp could respect parent dir permissions
sudo usermod -a -G lftp sonarr
sudo usermod -a -G lftp lidarr



sudo mkdir /mnt/temp/lftp
sudo chmod o=rX,g=rwX,u=rwX -R /mnt/temp/lftp
sudo chown lftp:lftp -R /mnt/temp/lftp

sudo mkdir /mnt/temp/lftp/radarr
sudo chmod o=rX,g=rwX,u=rwX -R /mnt/temp/lftp/radarr
sudo chown radarr:lftp -R /mnt/temp/lftp/radarr

sudo mkdir /mnt/temp/lftp/sonarr
sudo chmod o=rX,g=rwX,u=rwX -R /mnt/temp/lftp/sonarr
sudo chown radarr:lftp -R /mnt/temp/lftp/sonarr

sudo mkdir /mnt/temp/lftp/lidarr
sudo chmod o=rX,g=rwX,u=rwX -R /mnt/temp/lftp/lidarr
sudo chown radarr:lftp -R /mnt/temp/lftp/lidarr

sudo chmod o=rX,g=rwX,u=--- -R /lutece/media
sudo chown :mediarw -R /lutece/media

sudo chmod o=rX,g=rwX,u=rwX -R /lutece/media/movies
sudo chown radarr:mediarw -R /lutece/media/movies

sudo chmod o=rX,g=rwX,u=rwX -R /lutece/media/movies4k
sudo chown radarr:mediarw -R /lutece/media/movies4k

sudo chmod o=rX,g=rwX,u=rwX -R /lutece/media/tv
sudo chown sonarr:mediarw -R /lutece/media/tv

sudo chmod o=rX,g=rwX,u=rwX -R /lutece/media/music
sudo chown lidarr:mediarw -R /lutece/media/music

sudo chmod o=rX,g=rwX,u=--- -R /lutece/apps/nextcloud
sudo chown :nextcloud -R /lutece/apps/nextcloud


sudo chmod o=rX,g=rwX,u=--- -R /lutece/media/
sudo chown :mediarw -R /lutece/media/

sudo chmod o=-w-,g=rwx,u=rwx -R /lutece/drop/
sudo chown ashtonian:mediarw -R /lutece/drop/

sudo chmod o=---,g=rwx,u=rwx -R /lutece/fam/
sudo chown ashtonian: -R /lutece/fam/

sudo chmod o=---,g=r--,u=rwx -R /lutece/proj/
sudo chown ashtonian: -R /lutece/proj/

sudo chmod o=---,g=r--,u=rwx -R /lutece/backup/
sudo chown ashtonian: -R /lutece/backup/

sudo chmod o=rwx,g=r--,u=--- -R /lutece/public/
sudo chown : -R /lutece/public/

sudo chmod o=---,g=rwx,u=rwx -R /lutece/tmp/
sudo chown ashtonian: -R /lutece/tmp/

sudo chmod o=---,g=r--,u=rwx -R /lutece/scripts/
sudo chown ashtonian: -R /lutece/scripts/

sudo chmod o=---,g=r--,u=rwx -R /lutece/docs/
sudo chown ashtonian: -R /lutece/docs/
```

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

#sudo vi lib/systemd/system/docker.service # add --data-root ssd/new_location/
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
docker swarm update --task-history-limit 2zs
```

## Additional Expectations

- related cname records point to ddns record

## Stacks

### public net

```shell
docker network create --driver=overlay --attachable public
docker network create --driver=overlay --attachable dockersock
docker network create --driver=overlay --attachable dl
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
- VERIFY HW TRANSCODE - requires docker-compose pending device handling for swarm

```shell
cd plex/
#sudo docker stack deploy --compose-file=docker-compose.yml plex
sudo docker-compose up -d # must use compose due to network issue with swarm? DNS issues
```

```shell
cd dl/
#sudo docker stack deploy --compose-file=docker-compose.yml plex
sudo docker-compose up -d # must use compose due to network issue with swarm? DNS issues
```

### public

Intended for public services sub plex related.

```shell
# export CF_API_KEY=
cd public/
sudo docker stack deploy --compose-file=docker-compose.yml public
```

### nextcloud

```shell
# export NC_DB_ROOT_PASS=
# export NC_DB_PASS=
```

## Workspace

One Day Maybe

- vpn
- auto encrypt+backup
- investigate glances, docker sec, smokeping, voip, qbit
- internal proxy + dns + webmin cert + pfsense cert
- traefik rate limits https://docs.traefik.io/configuration/commons/#rate-limiting
- traefik default 404 error behavior https://docs.traefik.io/v1.6/configuration/commons/#custom-error-pages
- traefik security mailing for updates
- https://hub.docker.com/r/linuxserver/unifi-controller

Next

- reg radarr settings + radarrsync + job
- flac to mp3
- post import cleanup https://github.com/jayrox/clnd
- adjust quality profiles
- redis ui
- network share
- watchtower
- delete cleanup script for after download
