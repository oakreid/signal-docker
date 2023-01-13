#!/bin/bash

cd "$(dirname "$0")"
docker build . -t signal-docker
docker run --rm -e DISPLAY -v /tmp/.X11-unix -v $HOME/.Xauthority:/home/signal/.Xauthority -v signal-docker-data:/home/signal/.config/Signal --ipc host --net host signal-docker
