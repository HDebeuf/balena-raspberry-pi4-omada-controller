#!/bin/bash
ftp -p ftp.rent-a-guru.de <<EOF
    cd /private
    get omada-controller_3.2.1-1_all.deb
    bye
EOF