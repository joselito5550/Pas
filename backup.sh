#!/bin/bash
if [ $# -eq 0 ]
  then echo "Tienes que introducir el nombre del fichero"
else
  if [ -f "$1" ];
    then  fecha="$(date +%d-%m-%y)"
          cp "$1" "$1.back_$fecha"
          echo "todo ok"
  else echo "No existe el fichero"
  fi
fi
