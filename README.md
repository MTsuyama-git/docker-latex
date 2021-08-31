# Docker-Latex
Docker Image for latex with tgif and tgif2tex
## Pull Image
```
$ docker pull mtsuyama/docker-latex:v2.4
```
## Build Image (manual build)
```
$ ./build_img.sh
```
## Usage
platex
```
$ docker run --rm -it --user $UID -v $PWD:$PWD -w $PWD latex:v2.4 platex
```
dvipdfmx
```
$ docker run --rm -it --user $UID -v $PWD:$PWD -w $PWD latex:v2.4 dvipdfmx
```
This docker image also has make
```
$ docker run --rm -it --user $UID -v $PWD:$PWD -w $PWD latex:v2.4 make
```
tgif
```
$ docker run --rm -it --user $UID -e HOME=$HOME -e DISPLAY=$DISPLAY --net host -v $HOME:$HOME -w $PWD latex:v2.4 tgif
```
net option is for remote XWindow
