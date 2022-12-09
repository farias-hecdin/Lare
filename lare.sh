#! /data/data/com.termux/files/usr/bin/bash

set -o errexit
set -o nounset
set -o pipefail

printf "\n**** Lame: Reduce Bitrate (LRB) v0.1.3 ****\n\n"
printf " Disminuya el bitrate de sus archivos MP3. \n\n"
printf " NOTA: \n"
printf " * Asegurece de tener archivos MP3 \n   en este directorio.\n"
printf " * Antes de convertir sus archivos \n   debe escoger la opcion (1). \n\n"

opcion_a="Disminuir_el_bitrate"
opcion_b="Chequear_archivos"
opcion_c="Salir"

conteo=0
conteoTotal=0

OPCIONES=($opcion_a $opcion_b $opcion_c)
ARCHIVOS=( $(ls -F | grep -P ".mp3") )

# CONTADOR TOTAL DE ARCHIVO
for listFiles in ${ARCHIVOS[*]}
do
  let conteoTotal=conteoTotal+1
done

select elem in ${OPCIONES[0]} ${OPCIONES[1]} ${OPCIONES[2]}
do
  # SALIR
  if [[ "$elem" = ${OPCIONES[2]} ]]; then
    printf "\n Adios :)"
    exit

  # MOSTRAR ARCHIVOS
  elif [[ "$elem" = ${OPCIONES[1]} ]]; then
    printf "\n"
    for files in ${ARCHIVOS[*]}
    do
      printf " $files \n"
    done
    printf "\n Hay [${conteoTotal}] archivos MP3 en total."
    printf "\n ¿Es la cantidad esperada de archivos MP3?\n"
    printf "\n De no ser asi, puede que deba eliminar o reemplazar"
    printf '\n los espacio en blanco en el nombre del archivo\n por un "_" \n'
    exit

  # CONVERTIR ARCHIVOS
  elif [[ "$elem" = ${OPCIONES[0]} ]]; then
    printf "\nDirectorio de salida: "
    read directorio
    printf "Bitrate de salida: "
    read bitrate
    
    mkdir $directorio
    for files in ${ARCHIVOS[*]}
    do
      let conteo=conteo+1
      # EJECUTANDO lame (https://lame.sourceforge.io/index.php)
      lame --mp3input -b $bitrate $files "$directorio/(new) $files"
      printf "\n Archivo completados ($conteo de $conteoTotal).\n\n"
      wait
      sleep 2
    done
    printf "Listo..."
    exit
  fi
done
