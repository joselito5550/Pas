#/bin/bash
var=$[$(ls -l | grep -v ^d | wc -l)-1]
echo "El numero de archivos en la carpeta actual es $var"
#Con el who se muestran todos los usuarios logueados y con cut
#Extraemos la parte que queremos, la columna 1 declarando con -d ' ' los espacios
echo "------------------------------------------------"
who | cut -f1 -d ' '
echo "------------------------------------------------"
echo "Introduce el caracter que desea buscar:"

read -t 5 car
vacio=""
if [ -z $car ]
then car="a"
fi
num=$(find . -name "*$car*" | wc -l)
echo "El caracter $car aparece $num veces en nombres de ficheros o carpetas contenidos en la carpeta actual"
