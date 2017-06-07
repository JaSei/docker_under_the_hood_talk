#!/bin/sh

sudo unshare --fork --uts --ipc --net --pid --mount --mount-proc bash
