#!/bin/bash
# ================================================================================
#
#       ARCHIVO: ejercicio3.sh
#
#   DESCRIPCION: Mostrar las horas, minutos y segundos que llevan conectados los 
#   				usuarios logueados.
#         AUTOR: Jose M. Marquez Matarin  i42marmj@uco.es
#
# ================================================================================

who | sort | while read f
do
  #almacenamos el nombre		
  nombre=$(echo "$f" | grep pts | sed -r -e 's/(.*) p.*/\1/' )
  #almacenamos la fecha
  fechausu=$(echo "$f" | grep pts | sed -r -e 's/.*  (2.*)\(.*/\1/')
  #le añadimos los segundos
  fechasg=$(date -d "$fechausu" +%s)
  #almacenamos la fecha del pc
  fechapc=$(date +%s)
  resultado=$[fechapc-fechasg]
  horas=$(date -d @${resultado} +%H)
  minutos=$(date -d @${resultado} +%M)
  segundos=$(date -d @${resultado} +%S)
  #mostramos el resultado
  echo "El usuario $nombre lleva $horas horas,$minutos minutos, $segundos segundos conectado"
done

