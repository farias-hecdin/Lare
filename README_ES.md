# Lare
Reduce el bitrate de tus archivos MP3 desde la terminal.

## Descripción
Lare es un script de Bash pequeño y útil diseñado para trabajar con **LAME MP3 Encoder**. El objetivo principal de este script es automatizar la reducción del bitrate de un lote de archivos MP3 a través de la terminal.

> Creé este script con la intención de reducir el bitrate de los archivos MP3 en mi teléfono, con el objetivo de optimizar el espacio de almacenamiento y poder guardar más canciones.

## Requisitos
Para utilizar Lare, debes asegúrate de tener instalado [LAME MP3 Encoder](https://lame.sourceforge.io/).

## Instalación
Sigue estos pasos para instalar Lare:

1. Clone este repositorio en su máquina local:
   ```sh
   git clone https://github.com/usuario/Lare.git
   ```
2. Añade este fragmento de codigo en tu archivo `.zshrc` o `bashrc` para poder ejecutar Lare desde cualquier directorio.
   ```sh
   # Lare
   export LARE_HOME="$HOME/.local/share/lare:$PATH"
   ```

3.  Ejecute el archivo `wizard.sh` para instalar Lare:
    ```sh
    cd Lare/
    bash wizard.sh
    ```

4. Una vez que haya instalado Lare, puede ejecutar el script escribiendo el siguiente comando y especificando un directorio:
    ```sh
    lare [directorio]
    ```

Para mostrar el texto de ayuda, puedes utilizar el comando `lare --help`.

## Notas

> Este error se solucionó a partir de la versión **v0.1.6**

Si experimentas un error al ejecutar el script puede que se deba a los espacios en blanco en el nombre de los archivos. Esto es debido a que los nombres de archivo con espacios en blanco se interpretan como separadores de palabras.
Por lo tanto, es importante que evites los espacios en blanco y los reemplaces con guiones (-) para asegurar que los archivos se puedan leer correctamente.

## Licencia

Lare se encuentra bajo la licencia MIT. Consulte el archivo `LICENSE` para obtener más información.
