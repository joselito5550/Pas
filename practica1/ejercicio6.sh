#/bin/bash
# ================================================================================
#
#       ARCHIVO: ejercicio6.sh
#
#   DESCRIPCION: Se copiaran todos los ficheros de codigo (compilandolos), ejecutables,
#                librerias y cabeceras que se contengan en los directorios pasados como
#                atributos
#         AUTOR: Jose M. Marquez Matarin  i42marmj@uco.es
#
# ================================================================================
#
# Funcion comprobara si existe el fichero en el directorio de destino y pedira
# confirmacion por teclado al usuario, y mediante el uso de la variable "contar"
# sabemos si se ha sobreescrito, para realizar la cuenta con el contador, o no
#
# ================================================================================
funcion(){
  if [ -e $2 ]
    then
    echo "¿Desea sobreescribir el archivo $1 en la ruta $2? s/n"
    read -n 1 opc
    if [ $opc == 's' ]
      then
        cp "$1" "$3"
        contar=1
      else
        echo "No se sobreescribirá"
        contar=0
    fi
  else
    cp "$1" "$3"
    contar=1
  fi
}

# ================================================================================
#
# La funcion "recursiva" recorrera todos los archivos y carpetas, de forma que,
# si se topa con un directorio se vuelve a llamar a si misma de forma que recorra
# todas las subcarpetas, dentro distinguiremos entre ejecutables, codigos...
#
# ================================================================================
recursiva(){
  cd $1
  #ls $x | while read f
  for f in *
  do
    if [ -d $f ]
      then
      recursiva $f
    else
    aux=$(basename $f)
    ejec=$(ls -l $f | cut -c 4)
  #  if [ $ejec == "x" ]   #aqui tratamos con los ejecutables
    if [ -x $f ]
      then
      #no debería de contar si ya existe
        funcion "$aux" "$ejecutables/$aux" $ejecutables
        if [ $contar == 1 ]
          then
          contadorej=$[$contadorej+1]
        fi
    fi

    lib="lib"
    if [[ $aux == lib* ]]
    then
      #no debería de contar si ya existe
      funcion "$aux" "$librerias/$aux" "$librerias"
      if [ $contar == 1 ]
        then
      contadorlib=$[$contadorlib+1]
      fi

    fi

    if [[ $aux == *.c ]]
      then
      funcion "$aux" "$codigos/$aux" $codigos
      if [ $contar == 1 ]
        then
        contadorcod=$[$contadorcod+1]
      fi
      otro=$(ls $aux | cut -f1 -d ".")
      touch "$otro.txt"
       gcc "$aux" -o "$ejecutables/$otro" &>> $HOME/log.txt
      if [ $? != 0 ]
        then
          echo "$aux dio error al compilar"
        else
          contadorej=$[$contadorej+1]
          #no debería de contar si ya existe
      fi
      #mv $otro.txt "$codigos/$otro.txt" $codigos
    fi
    if [[ $aux == *.cpp ]]
      then
        funcion "$f" "$codigos/$aux" $codigos
        if [ $contar == 1 ]
          then
            contadorcod=$[$contadorcod+1]
        fi

        otro=$(ls $aux | cut -f1 -d ".")
     #  g++ "$aux" -o "$ejecutables/$otro" &>> /dev/null
        g++ "$aux" -o "$ejecutables/$otro" &>> $HOME/log.txt
        if [ $? != 0 ]
          then
          echo "$aux dio error al compilar"
        else

          contadorej=$[$contadorej+1]
          #no debería de contar si ya existe

        fi

      #  mv $otro.txt "$codigos/$otro.txt" $codigosif [ -f "$ejecutables/$otro"]
    fi

    if [[ $aux == *.h ]]
      then
        funcion "$f" "$cabeceras/$aux" "$cabeceras"
        if [ $contar == 1 ]
          then
            contadorcabe=$[$contadorcabe+1]
        fi

    fi
  fi
  done
  cd ..
}
horainicio=$(date +%s)
#Pedimos los nombres de las carpetas

echo "Introduce el nombre y la direccion de la carpeta donde se almacenaran los ejecutables"
read -t 2 ejecutables
echo "Introduce el nombre y la direccion de la carpeta donde se almacenaran los librerias"
read -t 2 librerias
echo "Introduce el nombre y la direccion de la carpeta donde se almacenaran los codigos"
read -t 2 codigos
echo "Introduce el nombre y la direccion de la carpeta donde se almacenaran los cabeceras"
read -t 2 cabeceras

#Comprobamos que se ha escrito algo, si no se le apl ica
#el valor por defecto

if [ -z $ejecutables ]
  then ejecutables="$HOME/bin"

fi
if [ -z $librerias ]
  then librerias="$HOME/lib"

fi
if [ -z $codigos ]
  then codigos="$HOME/src"

fi
if [ -z $cabeceras ]
  then cabeceras="$HOME/include"

fi

mkdir $ejecutables &>> /dev/null
mkdir $librerias &>> /dev/null
mkdir $codigos &>> /dev/null
mkdir $cabeceras &>> /dev/null

echo "El directorio para almacenar ejecubales es: $ejecutables"
echo "El directorio para almacenar librerias es: $librerias"
echo "El directorio para almacenar codigos es: $codigos"
echo "El directorio para almacenar cabeceras es: $cabeceras"

#recorremos los archivos
contadorej=0
contadorlib=0
contadorcod=0
contadorcabe=0
contadordirectorios=0
touch "$HOME/log.txt"
fecha=$(date +%d/%s/%y)
hora=$(date +%h:%m:%s)
echo "Fecha: $fecha" >> "$HOME/log.txt"
echo "Hora: $hora" >> "$HOME/log.txt"

#Hacemos distincion entre si tenemos argumentos o no

if [ $# -ne 0 ]
  then
    for x in $*
      do
        recursiva $x
      done
  else
  recursiva .
fi
echo "Número de archivos procesados $[$contadorej+$contadorlib+$contadorcod+$contadorcabe]"
echo "numero de ejecutables: $contadorej"
echo "numero de librerias: $contadorlib"
echo "numero de codigos: $contadorcod"
echo "numero de cabeceras: $contadorcabe"
horafinal=$(date +%s)
echo "tiempo:$[horafinal-horainicio]"
