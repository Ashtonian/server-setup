sudo zfs set sharenfs="sec=sys,rw=10.0.0.40" \
lutece/apps

sudo zfs set sharenfs="sec=sys,rw=10.0.0.40" \
lutece/media

sudo zfs set sharenfs="sec=sys,rw=10.0.0.40" \
lutece/public

sudo zfs set sharenfs="sec=sys,rw=10.0.0.40" \
lutece/scripts

sudo zfs set sharenfs="sec=sys,rw=10.0.0.40" \
lutece/fam

sudo zfs set sharenfs="sec=sys,rw=10.0.0.40" \
lutece/drop

sudo zfs set sharenfs="sec=sys,rw=10.0.0.40" \
lutece/backup

sudo zfs set sharenfs="sec=sys,rw=10.0.0.40" \
lutece/docs

sudo zfs set sharenfs=on lutece/apps
sudo zfs set sharenfs=on lutece/media
sudo zfs set sharenfs=on lutece/public
sudo zfs set sharenfs=on lutece/scripts
sudo zfs set sharenfs=on lutece/fam
sudo zfs set sharenfs=on lutece/drop
sudo zfs set sharenfs=on lutece/backup
sudo zfs set sharenfs=on lutece/docs
