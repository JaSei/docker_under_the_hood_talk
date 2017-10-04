# demo #01 - container exec (setns)

## steps to reproduce

1. run some container eg. `nginx` on background

```
LAST_CONTAINER_ID=`docker run -d nginx`
```

2. find his pid

```
LAST_CONTAINER_PID=`docker inspect $LAST_CONTAINER_ID | jq ".[0].State.Pid"`
```

3. run exec.pl

```
carton exec perl exec.pl $LAST_CONTAINER_PID
```

## how to setup perl syscall.ph (perl system headers)
```
cd /usr/include
sudo h2ph -r -l .
```

## what is carton?

[carton](https://metacpan.org/pod/distribution/Carton/script/carton) is perl module dependency manager (aka bundler for ruby)
