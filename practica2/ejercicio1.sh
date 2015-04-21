#!/bin/bash
# ================================================================================
#
#       ARCHIVO: ejercicio1.sh
#
#   DESCRIPCION: Script que muestra distintos ejercicios realizados con grep y sed
#         AUTOR: Jose M. Marquez Matarin  i42marmj@uco.es
#
# ================================================================================

echo "======================================"
echo "1) Lineas con la duracion de la peliculas"
cat peliculas.txt | grep min.$
echo "======================================"
echo "2) Lineas con el pais de las peliculas"
cat peliculas.txt | grep -E "\[.*\]"
echo "======================================"
echo "3) Solo el pais de las peliculas"
cat peliculas.txt | grep -E -o "\[.*\]"
echo "======================================"
conta14=$(cat peliculas.txt | grep -E -o "\(2014\)" | wc -l)
conta15=$(cat peliculas.txt | grep -E -o "\(2015\)" | wc -l)
echo "4) El numero de peliculas del año 2014 son $conta14, y del año 2015 $conta15"
echo "======================================"
echo "5) Eliminar lineas vacias"
cat peliculas.txt | grep -E -v ^$	
echo "======================================"
echo "6) Que empiece por C (Tenga o no espacios)"
cat peliculas.txt | grep -E ^" *C"
echo "======================================"
echo "7) Lineas que contienen d, l, o t una vocal y la misma letra"
cat peliculas.txt | grep '\([dlt]\)[aeiou]\1'
#\(\) para "almacenar la secuencia" y despues decimos \1 para que se repita
echo "======================================"
echo "8) Lienas que contiene ocho aes o mas"
cat peliculas.txt | grep '\([aA].*\)\{8,\}'
echo "======================================"
echo "9) Lineas que acaben en \"...\" y no empiecen por espacio"
cat peliculas.txt | grep -E '^[A-Z].*(\.\.\.)$'
echo "======================================"
echo "10) Mostrar entre comillas las vocales con tilde"
cat peliculas.txt | sed -e 's/\([áéíóú]\)/"\1"/g'
echo "======================================"
