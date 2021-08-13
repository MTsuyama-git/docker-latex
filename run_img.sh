#!/bin/bash
docker run --rm -it --user $UID -e HOME=$HOME -e DISPLAY=$DISPLAY --net host -v $HOME:$HOME -w $PWD latex:v2.3 $*
