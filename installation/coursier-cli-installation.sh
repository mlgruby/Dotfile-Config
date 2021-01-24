#!/bin/bash

# dowbload temporary coursier native-image to bootstrap the installation
curl -fLo cs https://git.io/coursier-cli-"$(uname | tr LD ld)"

# make it executable
chmod +x cs

# install cs and coursier
./cs install cs coursier

# remove the temporary native-image
rm cs