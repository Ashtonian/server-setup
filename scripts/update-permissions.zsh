#! /usr/bin/zsh
sudo chmod o=rX,g=rwX,u=--- -R /lutece/media
sudo chown :mediarw -R /lutece/media

sudo chmod o=rX,g=rwX,u=rwX -R /lutece/media/movies
sudo chown radarr:mediarw -R /lutece/media/movies

sudo chmod o=rX,g=rwX,u=rwX -R /lutece/media/tv
sudo chown sonarr:mediarw -R /lutece/media/tv

sudo chmod o=rX,g=rwX,u=rwX -R /lutece/media/music
sudo chown lidarr:mediarw -R /lutece/media/music