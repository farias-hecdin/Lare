#! /bin/bash
#! /data/data/com.termux/files/usr/bin/bash

set -o errexit
set -o nounset
set -o pipefail


# Variables globales
CURR_DIR=$(pwd)
FILES=($(ls $CURR_DIR -F | grep -P ".mp3"))



# Contar el total de archivos
function fn_CounterFiles() {
  local COUNTER_TOTAL=0

  for elem_FILES in "${FILES[@]}"
  do
    let COUNTER_TOTAL=COUNTER_TOTAL+1
  done

  printf $COUNTER_TOTAL
}



# Imprimir una lista de archivo y mostrar el total
function fn_ListFiles() {
  local TOTAL=$(fn_CounterFiles)
  
  printf "\n"

  for elem_FILES in "${FILES[@]}"
  do
    printf " ${elem_FILES} \n"
  done

  printf "\n"
  printf "\n Hay [${TOTAL}] archivos MP3 en total."
  printf "\n ¿Es la cantidad esperada de archivos MP3?"
  printf "\n"
  printf "\n De no ser asi, puede que debas eliminar o reemplazar"
  printf "\n los espacio en blanco en el nombre de los archivo"
  printf "\n por un '_'"
  printf "\n\n"
}



# Trasformar los archivos
function fn_Lame() {
  local COUNTER=0

  printf "\n"
  printf "Directorio de salida: "
    read directorio
  printf "Bitrate de salida: "
    read bitrate
  printf "\n"

  mkdir $directorio

  for elem_ITEM in "${FILES[@]}"
  do
    let COUNTER=COUNTER+1

    # Ejecutando: lame (https://lame.sourceforge.io/index.php)
    printf " Archivo ($COUNTER de $(fn_CounterFiles))."
    printf "\n\n"

      lame --mp3input -b $bitrate $elem_ITEM "$directorio/(new) $elem_ITEM"

    printf "\n ¡Operación completada!"
    printf "\n"

      wait
    sleep 1
  done

  printf "\n ¡Listo!"
  printf "\n\n"
}



# Main
function fn_Main() { 
  printf "\n **** LARE Reduce Bitrate (Lare) v0.1.4 ****"
  printf "\n"
  printf "\n Disminuye el bitrate de sus archivos MP3."
  printf "\n"
  printf "\n NOTA:"
  printf "\n * Asegurase de tener archivos MP3"
  printf "\n   en este directorio."
  printf "\n * Antes de convertir los archivos,"
  printf "\n   te recomendamos verificar su"
  printf "\n   estado (opcion 2)."
  printf "\n\n"

  local option_a="Disminuir_el_bitrate"
  local option_b="Chequear_archivos"
  local option_c="Salir"
  
  OPTIONS=($option_a $option_b $option_c)

  select elem_OPTIONS in ${OPTIONS[0]} ${OPTIONS[1]} ${OPTIONS[2]}
  do
    # Salir del script
    if [[ "$elem_OPTIONS" = ${OPTIONS[2]} ]]; then
      printf "\n Hasta luego :)"
      printf "\n"
      exit

    # Mostrar los archivos
    elif [[ "$elem_OPTIONS" = ${OPTIONS[1]} ]]; then
      fn_ListFiles
      exit

    # Inicializar LAME
    elif [[ "$elem_OPTIONS" = ${OPTIONS[0]} ]]; then
      fn_Lame
      exit

    fi
  done
}


fn_Main
