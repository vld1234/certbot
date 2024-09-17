#!/bin/bash

set -ex

GROUPID="sg-0XXXXXXXXXXXXX"

aws ec2 authorize-security-group-ingress \
    --group-id $GROUPID \
    --ip-permissions IpProtocol=tcp,FromPort=80,ToPort=80,IpRanges='[{CidrIp=0.0.0.0/0}]'

sleep 5

sudo certbot renew

sleep 5

aws ec2 revoke-security-group-ingress \
    --group-id $GROUPID \
    --ip-permissions IpProtocol=tcp,FromPort=80,ToPort=80,IpRanges='[{CidrIp=0.0.0.0/0}]'
