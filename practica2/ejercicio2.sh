#!/bin/bash
# ================================================================================
#
#       ARCHIVO: ejercicio2.sh
#
#   DESCRIPCION: Mostrar solo los primeros 50 caracteres de una linea 
#        AUTOR: Jose M. Marquez Matarin  i42marmj@uco.es
#
# ================================================================================

echo "Solo se mostraran de 0 a 50 caracteres por linea"
cat peliculas.txt | sed -r -e 's/(.{50,50}).*/\1.../' | sed -r -e 's/\((.*)\)/\1,/' | sed -r -e 's/\[(.*)\]/\1/'

