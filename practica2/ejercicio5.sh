#!/bin/bash
# ================================================================================
#
#       ARCHIVO: ejercicio5.sh
#
#   DESCRIPCION: Mostrar precio, combustible, direccion y ciudad que obtenemos de
#				https://twitter.com/GeoPortalMityc  
#        AUTOR: Jose M. Marquez Matarin  i42marmj@uco.es
#
# ================================================================================

#lo descargamos siempre ya que puede tener actualizaciones
wget https://twitter.com/GeoPortalMityc &>> /dev/null
cat GeoPortalMityc | grep EcoPrecio | sed -r -e 's/.*EcoPrecio(.*)<.*/\1/' | while read f
do
  #almacenamos las variables
  precio=$(echo "$f" | sed -r -e 's/.*(.....)€.*/\1/')
  combustible=$(echo "$f" | sed -r -e 's/(Gasóleo A|Gasolina 95).*/\1/' )
  direccion=$(echo $f | sed -r -e 's/.*en(.*)/\1/')
  ciudad=$(echo "$f" | sed -r -e "s/$combustible(.*)es.*/\1/")


  echo "Precio: $precio Ciudad: $ciudad Combustible: $combustible Direccion: $direccion"
done | sort -k2
#lo podemos borrar el archivo una vez hemos acabado de usarlo
rm GeoPortalMityc