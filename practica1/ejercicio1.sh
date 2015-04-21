#/bin/bash
# ================================================================================
#
#       ARCHIVO: ejercicio1.sh
#
#       DESCRIPCION: Comprimir en un .tar.gz el directorio pasado por el primer
#                    argumento, comprimiendo solo los archivos con mas
#                    de 20 segundos desde su ultima modificacion. Recibe por
#                    el segundo argumento (opcional) nombre del .tar.gz
#             AUTOR: Jose M. Marquez Matarin  i42marmj@uco.es
#
# ================================================================================
if [ $· -eq 0 ]
  then
    echo "Debes de introducir al menos un argumento, con la direccion de la carpeta, y opcionalmente
    un segundo argumento con el nombre del .tar.gz"
    exit 1
fi
if [ -d $1 ]
  then
    if [ $# -eq 2 ]
      then
        find $1 -not -newermt '-20 seconds' -type f -printf '%p\0' | tar --null -uf $2.tar.gz -T -
      else
    find $1 -not -newermt '-20 seconds' -type f -printf '%p\0' | tar --null -uf dir.tar.gz -T -
    fi

  else echo " $1 no es un directorio"
fi
