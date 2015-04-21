#!/bin/bash
# ================================================================================
#
#       ARCHIVO: ejercicio4.sh
#
#   DESCRIPCION: Busca una cadena pasada como segundo argumento en un fichero
#                pasado como primer argumento
#         AUTOR: Jose M. Marquez Matarin  i42marmj@uco.es
#
# ================================================================================
if [ $# -ne 2 ]
  then
    echo "Tienes que introducir dos argumentos, en primer lugar el fichero, y en segundo lugar, la cadena que deseas buscar en el fichero"
    exit 1
fi
contador=0
#recorremos el numero de lineas en las que aparece
for x in $(grep -n $2 $1 | cut -f1 -d ":")
do
  echo "----------------------------------------------------"
  contador=$[contador+1]
  echo "Emparejamiento numero: $contador"
  antes=$[$x-1]
  despues=$[$x+1]
  #recogemos las lineas que queremos sacar por pantalla
  echo "$(head -$antes $1 | tail -1)"
  echo "$(head -$x $1 | tail -1)"
  echo "$(head -$despues $1 | tail -1)"
    echo "----------------------------------------------------"
done
