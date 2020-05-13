#!/bin/bash

cd ~/.ssh
ssh-keygen -P "" -f envoy-sftp-key
cat envoy-sftp-key
