# demo #03 - image

## steps to reproduce

1. docker build

```
docker build -t dockerfile .
docker history dockerfile
docker save dockerfile -o dockerfile.tar
```

2. "own" docker build (via docker commit)
```
./dockerfile.sh
docker history dockershell
docker save dockershell -o dockershell.tar
```
