#! /bin/bash
# MIT License Copyright (c) 2023 Hecdin Farias

# Module setup ================================================================
set -o errexit
set -o nounset
set -o pipefail

# Global Variables
C="\e[33m? \e[0m"
W="  "
SCRIPT_NAME="lare"
PATH="/data/data/com.termux/files/usr/bin" # If you're using Termux, please use
# ...this path as is. Only modify it if you are not using Termux


# Module config ===============================================================

# Installer
function f_install_script() {
  if [[ -f $PATH/$SCRIPT_NAME ]]; then
    # Delete old files
    echo -e "$C Eliminando los archivos de la previa instalación..."
    echo -e "$W"
    rm -r $PATH/$SCRIPT_NAME
  fi
  # Copy files
  echo -e "$C Instalación: Copiando los archivos en: $PATH"
  ln -s $(pwd)/${SCRIPT_NAME}.sh $PATH/$SCRIPT_NAME
  sleep 1s

  echo -e "$C Operación terminada."
}

# Desinstaller
function f_uninstall_script() {
  if [[ -f $PATH/$SCRIPT_NAME ]]; then
    # Delete files
    echo -e "$C Desinstalación: Eliminando los archivos."
    rm -r $PATH/$SCRIPT_NAME
  else
    echo -e "$C $SCRIPT_NAME no instalado."
  fi
  sleep 1s
  echo -e "$C Operación terminada."
}

# Start script
function f_main() {
  echo -e "$W"
  echo -e "$C **** Wizard: \e[4mLare\e[0m ****"
  echo -e "$C"
  echo -e "$C ¿Qué deseas hacer?"
  echo -e "$C$W 1) Instalar script"
  echo -e "$C$W 2) Desinstalar script"
  echo -e "$C$W 3) Salir"
  echo -e "$C"
  echo -ne "$C respuesta: "
  read -r OPTIONS
  echo -e "$W"

  if [[ "${OPTIONS}" == 1 ]]; then
    f_install_script
  elif [[ "${OPTIONS}" == 2 ]]; then
    f_uninstall_script
  else
    echo -e "$C Operación cancelada."
  fi
  echo -e "$W"
  exit
}

# Check $PATH
if [[ -d $PATH ]]; then
  f_main
else
  echo -e "No esta usando Termux-Android"
  echo -e "Debes editar este archivo y cambiar el PATH="
  exit
fi
