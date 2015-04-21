#!/bin/bash
# ================================================================================
#
#       ARCHIVO: ejer2.sh
#
#   DESCRIPCION: Mostrar en un HTML archivos y directorios contenidos en el
#                directorio pasado por el primer argumento
#         AUTOR: Jose M. Marquez Matarin  i42marmj@uco.es
#
# ================================================================================

# Funcion mediante la que añadimos al HTML el nombre de los archivos, si es
# una carpeta esta se añadirá en negrita y como primer elemento de una lista
# no ordenada

convertir(){
  cd $1
  for x in *
    do
    if [ -d "$x" ]
      then
        echo "<ul><strong>$x</strong><br>" >> $HOME/"$nombre.html"
        convertir $x
#       Si es un directorio se vuelve a llamar a si misma

      else
        echo "<li>$x</li>" >> $HOME/"$nombre.html"
    fi
  done
  echo "</ul>" >> $HOME/"$nombre.html"
  cd ..
}



if [ $# -eq 0 ]
  then
    echo "Tienes que introducir como argumento el nombre de un directorio"
    exit 1
  else
    if [ -d $1 ]
      then
        #creamos el dir.html
        nombre=$(basename $1)
        touch $HOME/"$nombre.html"
        #le metmos la cabecera
        echo "<html> <head> <title> $1 </title> </head>" >> $HOME/"$nombre.html"
        echo "<h1>Listado del directorio $1</h1>" >> $HOME/"$nombre.html"
        convertir $1

      else echo "$1 no es un directorio"

    fi
fi
echo "</html>" >> $HOME/"$nombre.html"
