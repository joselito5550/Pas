#/bin/bash
# ================================================================================
#
#       ARCHIVO: ejercicio5.sh
#
#   DESCRIPCION: Se listarán los archivos de un directorio, pasado por el primer
#                argumento, mostrando algunas de sus caracteristicas. Opcionalmente
#                se recibira por el segundo argumento una cadena que filtrara los
#                archivos
#         AUTOR: Jose M. Marquez Matarin  i42marmj@uco.es
#
# ================================================================================
if [ $# -eq 0 ]
  then
    echo "Debes de introducir al menos un argumento que sea un directorio, y como segundo argumento una cadena"
    exit 1
fi
if [ -d $1 ]
  then
    if [ $# -eq 2 ]
      then
# ============================================================================================
#         los recorremos ya ordenados mediante el find -ls nos recorre recursivamente
#         todos los ficheros, con sort los ordenamos por la linea 7 (la del tamaño)
#         y con el comando awk solo imprimimos la columna numero 11, que contiene
#         la ruta para poder ir recorriendolos ya ordenados
# ============================================================================================
        find "$1" -name "*$2*" -ls | sort -n -k 7 | awk -F ' ' '{print $11}'| while read f
        do
            if [ -f "$f" ]
              then

            if [ -x "$f" ]
              then otro=1
            else otro=0
            fi
            #mostramos lo que nos pide
            echo "$f;$(stat -c%s "$f");$(stat -c%i "$f");$(ls -l "$f" | cut -d " " -f 1);$otro"
            fi
        done
      else
        find $1 -ls | sort -n -k 7 | awk -F ' ' '{print $11}'| while read f
        do
            if [ -f "$f" ]
              then

              if [ -x "$f" ]
                then
                  otro=1
                else
                  otro=0
              fi
              echo "$f;$(stat -c%s "$f");$(stat -c%i "$f");$(ls -l "$f" | cut -d " " -f 1);$otro"
            fi
        done

  fi
fi
