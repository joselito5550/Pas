#!/bin/bash
# ================================================================================
#
#       ARCHIVO: ejercicio4.sh
#
#   DESCRIPCION:Mostrar tiempo que tardan en contestar las IPs 
#        AUTOR: Jose M. Marquez Matarin  i42marmj@uco.es
#
# ================================================================================

if [ $# -ne 2 ]
	then
	echo "Debes de introducir como primer argumento el fichero donde esten las IPs, y como segundo argumento el tiempo antes de cortar la conexion con el servidor"
fi
cat $1 | while read x
do
	#almacenamos el tiempo que tarda en responder la ip, si este no aparece significa que no ha respondido
	aux=$(ping -c1 -w$2 $x | grep time | sed -r -e 's/.*(..)received.*/\1/' | grep time | sed -r -e 's/.*time=(.*) ms.*/\1/')
	#aux=$(ping -c1 -w$2 $x | grep time | sed -n -r -e 's/.*time=([^ ]+) ms/\1/p')
	if [ -z $aux ]
		then
		echo "La ip $x no respondió tras $2 segundos"
	else
		echo "La ip $x respondió en $aux milisegundos"
	fi
	done | sort -k6 
	#para ordenarlo
