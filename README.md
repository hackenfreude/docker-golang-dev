## What Is This?
This is a Docker image meant for Golang development. It extends [this](https://github.com/hackenfreude/docker-devenv). The dotfiles come from [here](https://github.com/hackenfreude/dotfiles). This is meant to feed other images that are purpose-built to specific development scenarios.

## What Do I Need To Know?
* `$ docker run --rm -it hackenfreude/golang-dev:latest` will run this.
* `-e GITNAME='<your name>'` and `-e GITMAIL='<your email>'` will update .gitconfig appropriately.
* `-v $PWD:<path>` will volume mount your working directory so you can write code from within the container.
