#!/bin/bash
# MIT License Copyright (c) 2023 Hecdin Farias

# Script setup ----------------------------------------------------------------

set -o errexit
set -o nounset
set -o pipefail
shopt -s globstar nullglob

# Script definition -----------------------------------------------------------

co_gray="\e[37m"
co_blue="\e[34m"
co_bold="\e[1m"
end="\e[0m"
space="  "


# Display help
function f_show_help() {
cat <<EOF

  USAGE
    lare [directory]

  VARIABLES
    directory : You can only write the name of a directory.
              : If no directory is specified, the current directory will be selected.
  FLAGS
    -h --help    : Display help.
    -v --version : Display version.

EOF
}

# Replace empty characters with (-)
function f_change_characters() {
  for elem in "${file_list[@]}"; do
    if [[ "$elem" == *" "* ]]; then
      local new_name=$(echo "$elem" | sed 's/ /-/g')
      mv "$elem" "$new_name"
    fi
  done
}

# Find files in the directory
function f_find_files() {
  echo -e "$space$co_gray Searching for files..."
  echo -e "$space"

  if [[ "$total_files" == 0 ]]; then
    echo -e "$space$co_gray No *.mp3 file found."
    echo -e "$space$co_yellow Please make sure there are files in this directory."
  else
    for elem in "${file_list[@]}"; do
      echo -e "$space${co_blue}*$end $elem"
    done
    echo -e "$space"
    echo -e "$space$co_gray There are $total_files files (MP3) in this directory."
    echo -e "$space"
    echo -e "$space$co_bold Is the expected number of files? (y/n) $end"
    echo -ne "$space$co_gray answer: "
    read -r res

    if [[ "$res" == "y" ]]; then
      f_change_characters
      f_convert_bitrate
    else
      echo -e "$space"
      echo -e "$space$co_gray The error might be due to the use of special characters in the files name."
      echo -e "$space$co_gray Replace these characters to ensure that the files can be properly read."
    fi
  fi
}

# Choise directory and change bitrate of the files
function f_convert_bitrate() {
  local list=$file_list
  local counter=0

  echo -e "$space"
  echo -e "$space$co_bold Please enter the name of the directory where you want to save the files. $end"
  echo -ne "$space$co_gray answer: "
  read -r new_directory

  if [[ -d "$new_directory" ]]; then
    echo -e "$space"
    echo -e "$space$co_gray The directory you entered already exists. Choose another one."
    f_convert_bitrate
  else
    mkdir "$new_directory"
  fi
  echo -e "$space"
  echo -e "$space$co_bold Specify the output bitrate you want to use (192 ~ 64). $end"
  echo -ne "$space$co_gray answer: "
  read -r new_bitrate
  echo -e "$space"

  for elem in "${file_list[@]}"; do
    local filename="${new_bitrate}Kbps $(basename $elem)"

    (( counter += 1 ))
    echo -e "$space$co_gray File:$co_blue $counter of $total_files $end"
    echo -e "$space"
    # Execute LAME
    # (https://lame.sourceforge.io/index.php)
    lame --mp3input -b "$new_bitrate" "$elem" "$filename"
    wait
    mv "$filename" "${new_directory}/"
    echo -e "$space"
  done
  echo -e "$space$co_gray Operation completed!"
}

# Check if the dependencies are installed
function f_check_dependencies() {
  if ! [[ $(command -v lame) ]]; then
    echo "LAME is not installed"
    exit
  fi
}

# Start script
function f_main() {
  f_check_dependencies

  echo -e "$space"
  echo -e "$space$co_bold **** Lare **** $end"
  echo -e "$space"
  echo -e "$space$co_bold What do you want to do? $end"
  echo -e "$space$co_gray 1) Reduce the bitrate of the files"
  echo -e "$space$co_gray 2) Exit the script"
  echo -e "$space"
  echo -ne "$space$co_gray answer: "
  read -r option
  echo -e "$space"

  if [[ "$option" == 1 ]]; then
    f_find_files
  elif [[ "$option" == 2 ]]; then
    echo -e "$space$co_gray Script canceled."
  fi
  echo -e "$space"
  exit
}

# Init
if [[ $# -gt 1 ]]; then
  echo "The script only accepts one parameter. (see --help)"
  exit
fi

IN_OPTION=${1:-"."}

case $IN_OPTION in
  --help|-h)
    f_show_help
    ;;
  --version|-v)
    echo "v0.1.7"
    ;;
  *)
    file_list=(${IN_OPTION}/*.mp3)
    total_files=${#file_list[@]}
    f_main
    ;;
esac
