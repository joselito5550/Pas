#!/bin/bash

# Imprimir todos los ficheros que se encuentren
# con extensi´on .sh
for x in $( find -name "*.sh")
  do
    echo $x
done
