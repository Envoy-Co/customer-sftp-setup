#!/bin/bash
clear

cd ~/.ssh
ssh-keygen -P "" -f envoy-sftp-key >/dev/null 2>&1
echo "Envoy.co Customer SFTP Configuation Tool"
echo ""
echo "Please copy everything in this section and email it to: sftpacccess@goenvoy.co"
echo "------------------------------------------------"
echo ""
cat ~/.ssh/envoy-sftp-key.pub
echo ""
echo "------------------------------------------------"
