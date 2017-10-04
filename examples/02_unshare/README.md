# demo - #02 unshare

## steps to reproduce

1. unshare process (bash) 
```
sudo unshare --fork --uts --ipc --net --pid --mount --mount-proc bash
```

2. look to process table (host vs unshared process)

```
ps a
```

3. check interfaces (host vs unshared process)

```
ip a
```

4. try to change hostname (and check host vs unshared process)

```
hostname container
hostname
```

5. namespaces of unshare bash are other then `self` (host)

```
ls -al /proc/$unshare_pid/ns
# vs
ls -al /proc/self/ns
```
