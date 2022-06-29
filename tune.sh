#!/bin/bash

echo "
[Manager]
DefaultLimitNOFILE=65535
" > /etc/systemd/system.conf

echo "
[Manager]
DefaultLimitNOFILE=65535
" > /etc/systemd/user.conf
