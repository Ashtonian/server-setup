# Server Setup

### Initial Update
```sudo apt-get update && apt-get dist-upgrade -y && reboot```

If there is problems deal with IPv6 default - [linksy](https://askubuntu.com/questions/574569/apt-get-stuck-at-0-connecting-to-us-archive-ubuntu-com):
``` vi /etc/gai.conf``` Uncomment line #54 - ```precedence ::ffff:0:0/96 100```.

### Install SSH Server
``` sudo apt-get install openssh-server ```

Reboot and verify ssh connectivity. Run ```ssh-copy-id user@ip``` on work machine.

### Install Webmin
Open apt sources with ```vi /etc/apt/sources.list``` and add  ```deb http://download.webmin.com/download/repository sarge contrib```.
```
wget -q http://www.webmin.com/jcameron-key.asc -O- | sudo apt-key add -
sudo apt-get update
sudo apt-get install webmin
```
Log into ip:10000 and verify it works. Reboot and make sure it auto-starts.
[linksay](http://www.webmin.com/deb.html)

### Install Docker


```
sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
sudo apt-add-repository 'deb https://apt.dockerproject.org/repo ubuntu-xenial main'
sudo apt-get update
sudo apt-get install -y docker-engine
```

If there is a permissions issue on first image run ``` sudo usermod -a -G docker <username> ``` - [Linkwardo](https://github.com/moby/moby/issues/5314)

### Install Portainer

```
docker run --restart=always -d -p 9000:9000 -v /var/run/docker.sock:/var/run/docker.sock portainer/portainer
```
Finish setup at ip:9000. Reboot and verify autostart.

### Install MergerFS
```
sudo -i
wget https://github.com/trapexit/mergerfs/releases/download/2.20.0/mergerfs_2.20.0.ubuntu-xenial_amd64.deb
dpkg -i mergerfs_2.20.0.ubuntu-xenial_amd64.deb
rm mergerfs*.deb
sudo -i
cd
apt-get install g++ pkg-config git git-buildpackage pandoc debhelper libfuse-dev libattr1-dev -y
git clone https://github.com/trapexit/mergerfs.git
cd mergerfs
make clean
make deb
cd ..
dpkg -i mergerfs*_amd64.deb
rm mergerfs*_amd64.deb mergerfs*_amd64.changes mergerfs*.dsc mergerfs*.tar.gz
```
[Linkanie](https://github.com/trapexit/mergerfs)

### Setup fstab

``` sudo vi /etc/fstab```

Add the following:
```
# 4TB Media
UUID=ea2e3faa-f963-4c5d-8073-60a8831b9b87       /media/Fitzroy  ext4    errors=continue 0       0
UUID=33d180de-0ffb-47d3-8518-4b8a391b0fe4       /media/Atlas    ext4    errors=continue 0       0
UUID=5ba0563f-c9fc-4cdf-bc2d-b7b0553b9e21       /media/Fontaine ext4    errors=continue 0       0

# 4TB Parity
UUID=7416a3ff-8d0e-4891-8e85-b96613dbb050       /media/Ryan     ext4    errors=continue 0       0

# 6TB Media

# 6TB Parity

# MergerFS
/media/Atlas:/media/Fontaine:/media/Fitzroy /media/Lutece fuse.mergerfs  direct_io,defaults,allow_other,minfreespace=200G 0 0
```
Reboot and verify drives work with auto-mount. Shutdown, pull drives and verify boot. Replace drives and reboot.

### Install Plex
```
sudo docker create \
--name=plex \
--net=host \
--restart=always \
-e VERSION=latest \
-v /media/Lutece:/data/lutece \
-v /media/Atlas/Plex:/config \
-e PGID=0 \
-e PUID=0 \
linuxserver/plex
```
Verify at ip:32400.


### Install Duplicati
```
docker run --rm -it \
-v /media/Lutece/Apps/Config/Duplicati/:/root/.config/Duplicati/ \
-v /media/Lutece:/data/lutece \
-e DUPLICATI_PASS=duplicatiPass \
-e MONO_EXTERNAL_ENCODINGS=UTF-8 \
-p 8200:8200 \
intersoftlab/duplicati:canary
```
Verify at ip:8200.


### Setup minecraft
```
docker run --restart=always \
-e OPS=ashtonian \
-e 'JVM_OPTS=-Xmx27000M -Xms1024M' \
-e EULA=true\
-v /media/Fitzroy/Applications/MineCraft:/data \
-d -p 25565:25565 \
--name minecraft \
itzg/minecraft-server
```
Verify in game.

### TODO:
* packages like vim
* Snapraid/Snapraid Runner
* New Drives
* Https proxy for things like https://plex.example.com
* NIC LAGG
* Samba other FS shares including dropbox folder 
* Own cloud
* SFTP
* Quick host
* Finalize copy / filebot scripts 
