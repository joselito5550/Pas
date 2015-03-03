#!/bin/bash
echo "Introduce el nombre de usuario:"
read usuario
if [ $usuario == $USER ]
  then echo "Bienvenido $usuario"
else
  echo "Mentira"
fi
