# Docker-Latex
Docker Image for latex with tgif and tgif2tex
## Build Image
```
$ ./build_img.sh
```
## Usage
platex
```
$ docker run --rm -it --user $UID -v $PWD:$PWD -w $PWD latex:v2.3 platex
```
dvipdfmx
```
$ docker run --rm -it --user $UID -v $PWD:$PWD -w $PWD latex:v2.3 dvipdfmx
```
This docker image also has make
```
$ docker run --rm -it --user $UID -v $PWD:$PWD -w $PWD latex:v2.3 make
```
tgif
net option is for remote XWindow
```
$ docker run --rm -it --user $UID -e HOME=$HOME -e DISPLAY=$DISPLAY --net host -v $HOME:$HOME -w $PWD latex:v2.3 tgif
```
