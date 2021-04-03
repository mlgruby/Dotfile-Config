#!/bin/bash

# ssh-key generation
ssh-keygen -t rsa -b 4096 -N 'pass-phrase' -C "you@mail.com" -f ~/.ssh/id_rsa
ssh-keygen -t rsa -b 4096 -N 'pass-phrase' -C "you@mail.com" -f ~/.ssh/github_rsa
ssh-keygen -t rsa -b 4096 -N 'pass-phrase' -C "you@mail.com" -f ~/.ssh/mozilla_rsa

# ssh-key addition
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa
ssh-add ~/.ssh/github_rsa
ssh-add ~/.ssh/mozilla_rsa

# ssh-key permission
chmod 700 ~/.ssh
chmod 644 ~/.ssh/authorized_keys
chmod 644 ~/.ssh/known_hosts
chmod 644 ~/.ssh/config
chmod 600 ~/.ssh/id_rsa
chmod 644 ~/.ssh/id_rsa.pub
chmod 600 ~/.ssh/github_rsa
chmod 644 ~/.ssh/github_rsa.pub
chmod 600 ~/.ssh/mozilla_rsa
chmod 644 ~/.ssh/mozilla_rsa.pub
