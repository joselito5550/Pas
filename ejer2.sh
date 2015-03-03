#!/bin/bash

convertir(){
  cd ./$1
  for x in *
    do
    if [ -d "$x" ]
      then
        echo "<ul><strong>$x</strong><br>" >> /tmp/fichero.html
        convertir $x
      else
        echo "<li>$x</li>" >> /tmp/fichero.html
    fi
  done
  echo "</ul>" >> /tmp/fichero.html
}

if [ $# -eq 0 ]
  then
    echo "Tienes que introducir como argumento el nombre de un directorio"
    exit 1
  else
    if [ -d $1 ]
      then
        rm /tmp/fichero.html
        #creamos el fichero.html
        touch /tmp/fichero.html
        #le metmos la cabecera
        echo "<html> <head> <title> $1 </title> </head>" >> /tmp/fichero.html
        echo "<h1>Listado del directorio $1</h1>" >> /tmp/fichero.html
        convertir $1

      else echo "no es un directorio"

    fi
fi
echo "</html>" >> /tmp/fichero.html
