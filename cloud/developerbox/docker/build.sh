#!/bin/bash

CLOUD_SSH_FINGERPRINT=$(ssh-keygen -lf ~/.ssh/id_rsa.pub | awk '{print $2}')
