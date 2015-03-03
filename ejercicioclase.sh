#/bin/bash
find /etc/rc?.d -name "S*" | while read f
do
  jose=$(dirname "$f")
  aux=$(basename "$f")
  echo "$jose ----> $aux"
done
