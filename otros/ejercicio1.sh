#/bin/bash
if [ $# -eq 2 ]
  then
    find $1 -not -newermt '-20 seconds' -type f -printf '%p\0' | tar --null -uf $2.tar.gz -T -
  else
    find $1 -not -newermt '-20 seconds' -type f -printf '%p\0' | tar --null -uf dir.tar.gz -T -
fi
