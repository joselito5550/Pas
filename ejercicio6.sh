#/bin/bash
#como argumentos se le pasa la ruta de los dos ficheros
funcion(){
  if [ -e $2 ]
    then
    cp -i "$1" "$3"
  else
    cp "$1" "$3"
  fi
}


numarg=$#
#mkdir /home/jose/ejecutables
#mkdir /home/jose/librerias
#mkdir /home/jose/codigo
#mkdir /home/jose/cabeceras

#Pedimos los nombres de las carpetas

echo "Introduce el nombre y la direccion de la carpeta donde se almacenaran los ejecutables"
read -t 2 ejecutables
echo "Introduce el nombre y la direccion de la carpeta donde se almacenaran los librerias"
read -t 2 librerias
echo "Introduce el nombre y la direccion de la carpeta donde se almacenaran los codigos"
read -t 2 codigos
echo "Introduce el nombre y la direccion de la carpeta donde se almacenaran los cabeceras"
read -t 2 cabeceras

#Comprobamos que se ha escrito algo, si no se le aplica
#el valor por defecto

if [ -z $ejecutables ]
  then ejecutables="/home/jose/ejecutables"
  #"$HOME/bin"
fi
if [ -z $librerias ]
  then librerias="/home/jose/librerias"
  #"$HOME/lib"
fi
if [ -z $codigos ]
  then codigos="/home/jose/codigo"
  #"$HOME/src"
fi
if [ -z $cabeceras ]
  then cabeceras="/home/jose/cabeceras"
  #"$HOME/include"
fi

echo "El directorio para almacenar ejecubales es: $ejecutables"
echo "El directorio para almacenar librerias es: $librerias"
echo "El directorio para almacenar codigos es: $codigos"
echo "El directorio para almacenar cabeceras es: $cabeceras"

#Comprobamos si existe,

#if [ -d $ejecutables ]
#  then
#fi

#recorremos los archivos
contadorej=0
contadorlib=0
contadorcod=0
contadorcabe=0
for x in $*
do
  #ls $x | while read f
  for f in *
  do
    aux=$(basename $f)
    ejec=$(ls -l $f | cut -c 4)
    if [ $ejec == "x" ]   #aqui tratamos con los ejecutables
      then
        contadorej=$[$contadorej+1]
        funcion "$f" "$ejecutables/$ayuda" $ejecutables
    fi
    echo "$aux"
    lib="lib"
    if [[ $aux == lib* ]]
    then
      contadorlib=$[$contadorlib+1]
      funcion "$f" "$librerias/$ayuda" $librerias
    fi

    if [[ $aux == *.c ]]
      then
      contadorcod=$[$contadorcod+1]
        funcion "$f" "$codigos/$aux" $codigos
    fi
    if [[ $aux == *.cpp ]]
      then
      contadorcod=$[$contadorcod+1]
        funcion "$f" "$codigos/$aux" $codigos
    fi

    if [[ $aux == *.h ]]
      then
      contadorcabe=$[$contadorcabe+1]
        funcion "$f" "$cabeceras/$aux" "$cabeceras"
    fi
  done

done
echo "numero de ejecutables: $contadorej"
echo "numero de librerias: $contadorlib"
echo "numero de codigos: $contadorcod"
echo "numero de cabeceras: $contadorcabe"
