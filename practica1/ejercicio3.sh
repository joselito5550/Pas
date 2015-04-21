#/bin/bash

# ================================================================================
#
#       ARCHIVO: ejercicio3.sh
#
#   DESCRIPCION: Muestra el numero de archivos del directorio actual, una lista
#                ordenada de los usuarios que hay logueados en ese
#                e imprimer el numero de veces que aparece un determinado
#                caracter de forma recursiva
#         AUTOR: Jose M. Marquez Matarin  i42marmj@uco.es
#
# ================================================================================

# Restamos uno, porque cuenta tambien la linea de "total"
var=$[$(ls -l | grep -v ^d | wc -l)-1]
echo "El numero de archivos en la carpeta actual es $var"
#Con el who se muestran todos los usuarios logueados y con cut
#Extraemos la parte que queremos, la columna 1 declarando con -d ' ' los espacios
echo "------------------------------------------------"
who -u | cut -f1 -d ' ' | sort | uniq
echo "------------------------------------------------"
echo "Introduce el caracter que desea buscar:"

read -t 5 car
if [ -z $car ]
then car="a"
fi
##cuenta tambien el caracter en los archivos ocultos
num=$(find . -name "*$car*" | grep -o $car | wc -l)
echo "El caracter $car aparece $num veces en nombres de ficheros o carpetas contenidos en la carpeta actual"
