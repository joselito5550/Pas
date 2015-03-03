#/bin/bash

find jose -not -newermt '-20 seconds' -type f -printf '%p\0' | tar --null -uf archive.tar.gz -T -
