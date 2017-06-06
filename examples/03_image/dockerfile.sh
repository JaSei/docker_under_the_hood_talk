#!/bin/sh

image=dockershell

#FROM alpine
#RUN touch /test
cid=$(docker run -d alpine touch /test)
docker commit $cid $image

#RUN rm /test 
id=$(docker run -d $image rm /test)
docker commit $id $image
