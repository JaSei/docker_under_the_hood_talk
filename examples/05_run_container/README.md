# create container

## prepare (gentoo) image

wget http://ftp.fi.muni.cz/pub/linux/gentoo/releases/amd64/autobuilds/current-install-amd64-minimal/stage3-amd64-20170504.tar.bz2
sudo tar xz $HOME/Downloads/stage3-amd64-20170504.tar.bz2 --directory image

## prepare (apline) image

wget https://nl.alpinelinux.org/alpine/v3.5/releases/x86_64/alpine-minirootfs-3.5.2-x86_64.tar.gz
sudo tar -xf alpine-minirootfs-3.5.2-x86_64.tar.gz --directory image

## run container

### bash implementation
```
./create.sh 

#now in new container

mount --bind image image
cd image
mkdir old_root

pivot_root . old_root 

ps a #nothing print because no proc
mount -t proc proc /proc

exec sh
```

### perl implementation

run.pl doesn't work well yet!
