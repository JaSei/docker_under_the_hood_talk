# unshare

```
sudo unshare --fork --uts --ipc --net --pid --mount --mount-proc bash
ps a
ip a
hostname
```

namespaces are other then `self`
```
ls -al /proc/$unshare_pid/ns
```
