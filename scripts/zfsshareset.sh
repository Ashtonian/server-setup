
sudo zfs set \share="name=apps,path=/lutece/apps,prot=nfs,sec=sys,rw=10.0.0.40" \
lutece/apps

sudo zfs set \share="name=media,path=/lutece/media,prot=nfs,sec=sys,rw=10.0.0.40" \
lutece/media

sudo zfs set \share="name=public,path=/lutece/public,prot=nfs,sec=sys,rw=10.0.0.40" \
lutece/public

sudo zfs set \share="name=scripts,path=/lutece/scripts,prot=nfs,sec=sys,rw=10.0.0.40" \
lutece/scripts

sudo zfs set \share="name=fam,path=/lutece/fam,prot=nfs,sec=sys,rw=10.0.0.40" \
lutece/fam

sudo zfs set \share="name=drop,path=/lutece/drop,prot=nfs,sec=sys,rw=10.0.0.40" \
lutece/drop

sudo zfs set \share="name=backup,path=/lutece/backup,prot=nfs,sec=sys,rw=10.0.0.40" \
lutece/backup

sudo zfs set \share="name=docs,path=/lutece/docs,prot=nfs,sec=sys,rw=10.0.0.40" \
lutece/docs
