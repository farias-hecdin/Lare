#! /bin/bash
# MIT License Copyright (c) 2023 Hecdin Farias

# Module setup =======================================================================
set -o errexit
set -o nounset
set -o pipefail
shopt -s globstar nullglob

# Global variables
C="\e[32m# \e[0m"
W="  "
IN_DIR=$1
FILES_LIST=("$IN_DIR"/*.mp3)
FILES_TOTAL=${#FILES_LIST[@]}


# Module config ===============================================================

# Replace empty characters with (-)
function f_change_characters() {
  for ELE in "${FILES_LIST[@]}"; do
    if [[ "$ELE" == *" "* ]]; then
      local NEWNAME="$(echo $ELE | sed 's/ /-/g')"
      mv "$ELE" "$NEWNAME"
    fi
  done
}

# Find files in the directory
function f_find_files() {
  echo -e "$C Buscando archivos..."
  echo -e "$W"
  sleep 1s

  if [[ "$FILES_TOTAL" == "0" ]]; then
    echo -e "$C No se han encontrado archivos *.mp3"
    echo -e "$C Por favor, asegúrate de que que haya archivos en este directorio."
  else
    for ELE in "${FILES_LIST[@]}"; do
      echo -e "$W $ELE"
    done
    echo -e "$W"
    echo -e "$C En este directorio, hay $FILES_TOTAL archivos *.mp3"
    echo -e "$C"
    echo -e "$C ¿Es la cantidad esperada de archivos? (y/n)"
    echo -ne "$C respuesta: "
    read -r RES

    if [[ "$RES" == "y" ]]; then
      f_change_characters
      f_convert_bitrate
    else
      echo -e "$W"
      echo -e "$C Puede que el error se deba al uso de caracteres extraños en los nombre de los archivos."
      echo -e "$C Reemplace estos caracteres para asegurarse de que los archivos se puedan leer correctamente."
    fi
  fi
}

# Choise directory and change bitrate of the files
function f_convert_bitrate() {
  local LIST=("$IN_DIR"/*.mp3)
  local COUNTER=0

  echo -e "$W"
  echo -e "$C Por favor, escriba el nombre del directorio donde deseas guardar los archivos."
  echo -ne "$C respuesta: "
  read -r NEW_DIR

  if [[ -d $NEW_DIR ]]; then
    echo -e "$W"
    echo -e "$C El directorio que has escrito ya existe. Elija otro."
    f_convert_bitrate
  else
    mkdir $NEW_DIR
  fi

  echo -e "$C"
  echo -e "$C Indique el bitrate de salida que deseas usar (192 / 128 / 112 / 96 / 64)."
  echo -ne "$C respuesta: "
  read -r NEW_BIT
  echo -e "$W"

  for ELE in "${LIST[@]}"; do
    (( COUNTER = COUNTER+1 ))
    echo -e "$C Archivo: ${COUNTER}/${FILES_TOTAL}"
    echo -e "$W"

    # execute LAME (https://lame.sourceforge.io/index.php)
    lame --mp3input -b "$NEW_BIT" "$ELE" "${NEW_DIR}/${NEW_BIT}Kbps $(basename $ELE)"
    echo -e "$W"
    wait
    sleep 1s
  done
  echo -e "$C Operación terminada."
  echo -e "$W"
  exit
}

# Start script
function f_main() {
  echo -e "$W"
  echo -e "$C **** Lare v0.1.6 ****"
  echo -e "$C"
  echo -e "$C ¿Qué deseas hacer?"
  echo -e "$C$W 1) Reducir el bitrate de los archivos"
  echo -e "$C$W 2) Salir del script"
  echo -e "$C"
  echo -ne "$C respuesta: "
  read -r OPTIONS
  echo -e "$W"

  if [[ "${OPTIONS}" == 1 ]]; then
    f_find_files
  elif [[ "${OPTIONS}" == 2 ]]; then
    echo -e "$C Operación cancelada."
  fi
  echo -e "$W"
  exit
}

f_main
