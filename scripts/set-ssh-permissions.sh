#!/usr/bin/env bash

chmod 700 ~/.ssh
chmod 600 ~/.ssh/*
test -f ~/.ssh/authorized_keys && chmod 644 ~/.ssh/authorized_keys
chmod 644 ~/.ssh/known_hosts
chmod 644 ~/.ssh/config
chmod 644 ~/.ssh/*.pub