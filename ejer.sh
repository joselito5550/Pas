#!/bin/bash
funcion(){
  tiempocarpeta=$(stat -c%Y "$x")
  tiempopc=$(date +%s)
  if [ $[tiempopc-tiempocarpeta] -gt 20 ]
    then
      cp "$x" /tmp/auxiliar
    else
     echo "El archivo $x tiempo de creacion es menor a 20 segundos"
  fi
}


recorrer(){
  cd $x
  for x in *
  do
    if [ -d $x ]
      then
        recorrer $x
    else funcion $x
    fi
  done
  cd ..
}



if [ $# -eq 0 ]
  then
    echo "Tienes que introducir al menos un argumento"
    exit 1
  else
    mkdir /tmp/auxiliar
  if [ -d $1 ]
    then
      echo "Es un directorio"
      cd $1
    for x in *
      do
        echo "$x"
        if [ -d $x ]
          then
          recorrer $x
        else
          funcion $x
        fi
    done
    cd ..
    if [ $# -eq 2 ]
      then
        tar czvf "$2.tar.gz" /tmp/auxiliar
      else
        tar czvf "dir.tar.gz" /tmp/auxiliar
    fi
  else echo "no es un directorio"
  fi
fi
rm -r /tmp/auxiliar
