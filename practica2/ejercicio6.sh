#!/bin/bash
# ================================================================================
#
#       ARCHIVO: ejercicio6.sh
#
#   DESCRIPCION: Mostrar distintas caracteristicas almacenadas en /etc/passwd
#        AUTOR: Jose M. Marquez Matarin  i42marmj@uco.es
#
# ================================================================================
cat /etc/passwd | grep $1$ | while read f
do
  #almacenamos el logname
  logname=$(echo "$f" | sed -r -e 's/([a-z]*):.*/\1/')
  #para saber si esta logueado
  aux=$(who | grep $logname)
  if [ -z "$aux" ]
  then
  	logueado=0
  else
	logueado=1
  fi
  #es necesario marcar en el comando sed todos los ":" ya que si solo indicamos uno nos coge la cadena mas larga
  #asi no damos cabida a error
  UiD=$(echo "$f" | sed -r -e 's/.*:.*:(.*):.*:.*:.*:.*/\1/')
  gid=$(echo "$f" | sed -r -e 's/.*:.*:.*:(.*):.*:.*:.*/\1/')
  gecos=$(echo "$f" | sed -r -e 's/.*:.*:.*:.*:(.*):.*:.*/\1/')
  home=$(echo "$f" | sed -r -e 's/.*:.*:.*:.*:.*:(.*):.*/\1/')
  echo "logname: $logname , UID:$UiD , GID:$gid , GECOS:$gecos , SHELL POR DEFECTO:$1 , HOME:$home , LOGUEADO:$logueado"
		
done
#=================================================================================
#Se podria haber hecho mas facil con awk indicando que se separan por ":" y coger 
#la columna que necesitemos
#awk -F ':' '{print $3}'
#=================================================================================