# overlay

use image from previous [example 03_image](../03_image)

```
docker save dockershell -o dockershell.tar
tar xf dockershell.tar
rm dockershell.tar
```

recursive untar:

```
for f in `find . -name "*.tar"`; do dir=`dirname $f`/layer; mkdir $dir; tar xvf $f -C $dir; done
```

FROM alpine + RUN touch /test

```
mkdir work_a merge_a
sudo mount -t overlay -o lowerdir=30784cae2b30e82860239f7de81fc755f69bc58a77d52c2d8318ac1162247f66/layer,upperdir=fe9fa45f2c6c5ae2548dc9b6ce824293401d8852914fd1cc03bb96a082274d0a/layer,workdir=work_a none merge_a
```

FROM alpine + RUN touch /test + RUN rm /test => IMAGE

```
mkdir w_image image
sudo mount -t overlay -o lowerdir=merge_a,upperdir=8ec888c88d3e284cecf7a477edc3f37324bfec32658aa1a09b525c7a28eb74de/layer,workdir=w_image none image
```

IMAGE + container

```
mkdir container_layer w_container_layer container
sudo mount -t overlay -o lowerdir=image,upperdir=container_layer,workdir=w_container_layer none container
```

but this return

```
overlayfs: maximum fs stacking depth exceeded
```

well we must stacking some layers, or use overlay2

```
sudo mount -t overlay -o lowerdir=8ec888c88d3e284cecf7a477edc3f37324bfec32658aa1a09b525c7a28eb74de/layer/:fe9fa45f2c6c5ae2548dc9b6ce824293401d8852914fd1cc03bb96a082274d0a/layer/:30784cae2b30e82860239f7de81fc755f69bc58a77d52c2d8318ac1162247f66/layer,upperdir=container_layer,workdir=w_container_layer none container
```
