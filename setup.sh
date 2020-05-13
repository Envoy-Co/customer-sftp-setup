#!/bin/bash

cd ~/.ssh
ssh-keygen -P "" -f envoy-sftp-key
echo cat ~/.ssh/envoy-sftp-key.pub
