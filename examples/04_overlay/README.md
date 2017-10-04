# demo #04 - overlay (layers, ephemeral)

## steps to reproduce

1. use image from previous [example 03_image](../03_image)

```
docker save dockershell -o dockershell.tar
tar xf dockershell.tar
rm dockershell.tar
```

2. recursive untar

```
for f in `find . -name "*.tar"`; do dir=`dirname $f`/layer; mkdir $dir; tar xvf $f -C $dir; done
```

3. use first two layers (`FROM alpine` + `RUN touch /test`) and mount it as `merge_a`

```
mkdir work_a merge_a
sudo mount -t overlay -o lowerdir=30784cae2b30e82860239f7de81fc755f69bc58a77d52c2d8318ac1162247f66/layer,upperdir=fe9fa45f2c6c5ae2548dc9b6ce824293401d8852914fd1cc03bb96a082274d0a/layer,workdir=work_a none merge_a
```

4. use all layers (`FROM alpine` + `RUN touch /test` + `RUN rm /test`) and mount it as final image called `image`

```
mkdir w_image image
sudo mount -t overlay -o lowerdir=merge_a,upperdir=8ec888c88d3e284cecf7a477edc3f37324bfec32658aa1a09b525c7a28eb74de/layer,workdir=w_image none image
```

5. IMAGE + ephemeral = container

```
mkdir container_layer w_container_layer container
sudo mount -t overlay -o lowerdir=image,upperdir=container_layer,workdir=w_container_layer none container
```

6. but this return

```
overlayfs: maximum fs stacking depth exceeded
```

7. we must stacking some layers (overlay), or we can use overlay2

```
sudo mount -t overlay -o lowerdir=8ec888c88d3e284cecf7a477edc3f37324bfec32658aa1a09b525c7a28eb74de/layer/:fe9fa45f2c6c5ae2548dc9b6ce824293401d8852914fd1cc03bb96a082274d0a/layer/:30784cae2b30e82860239f7de81fc755f69bc58a77d52c2d8318ac1162247f66/layer,upperdir=container_layer,workdir=w_container_layer none container
```
