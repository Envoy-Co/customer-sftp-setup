#!/bin/bash
clear

echo "Envoy.co Customer SFTP Configuation Tool"
echo "----------------------------------------"
echo ""
echo "This script will create a new SSH key pair to use when connecting to "
echo "Envoy.co's SFTP Server."
echo ""
echo "The generated keypair will be in your ~/.ssh/ folder and will not"
echo "overrwite or disrupt any existing keypairs."
echo ""
while true; do
    read -p "Do you want to continue? " yn
    case $yn in
    [Yy]*)
        break
        ;;
    [Nn]*) exit ;;
    *) echo "Please answer yes or no." ;;
    esac
done

[ ! -d "~/.ssh" ] && mkdir ~/.ssh
cd ~/.ssh

ssh-keygen -P "" -f envoy-sftp-key 2>&1
echo ""
echo ""
echo "We will now send the public key to Envoy to complete your account creation."
echo ""
read -p "What is your name? " name
read -p "What is your email address? " email
KEY=$(cat ~/.ssh/envoy-sftp-key.pub)
STR='{"request": {"requester": {"name": "'$name'","email":"'$email'"}, "subject": "SFTP User Request", "comment": {"body": "Name: '$name'\nEmail: '$email'\n\n------------------------------------------------\n\n'$KEY'\n\n------------------------------------------------\n\n" }}}'

RESP=$(curl https://con-ericenvoy.zendesk.com/api/v2/requests.json \
    -d "$STR" \
    -X POST -H "Content-Type: application/json")

SUB='request'
if [[ "$RESP" == *"$SUB"* ]]; then
    echo ""
    echo "Public key sent to Envoy.  Someone will be in touch soon."
else
    echo ""
    echo "Error sending key to Envoy."
    echo ""
    echo "Please copy everything in this section and email it to: support@con-ericenvoy.zendesk.com"
    echo "------------------------------------------------"
    echo ""
    echo "$KEY"
    echo ""
    echo "------------------------------------------------"
fi
