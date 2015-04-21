#/bin/bash
if [ $# -eq 0 ]
  then
    echo "Debes de introducir al menos un argumento que sea un directorio, y como segundo argumento una cadena"
    exit 1
fi
if [ -d $1 ]
  then
    if [ $# -eq 2 ]
      then
        find "$1" -name "*$2*" -ls | sort -n -k 7 | awk -F ' ' '{print $11}'| while read f
        do
            if [ -d "$f" ]
              then
                echo "$f"
            else
            var=$(ls -l "$f" | cut -c 4)
            if [ $var == "x" ]
              then otro=1
            else otro=0
            fi
            echo "$f;$(stat -c%s "$f");$(stat -c%i "$f");$(ls -l "$f" | cut -d " " -f 1);$otro"
            fi
        done
      else
        find $1 -ls | sort -n -k 7 | awk -F ' ' '{print $11}'| while read f
        do
            if [ -d "$f" ]
              then
                echo "$f"
            else
              var=$(ls -l "$f" | cut -c 4)
              if [ $var == "x" ]
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
