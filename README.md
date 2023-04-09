# Lare

Disminuye el bitrate de tus archivos MP3 desde la terminal.

## Descripción

> Este script fue creado con la motivación de ahorrar más espacio en la memoria de
> almacenamiento del teléfono para guardar archivos MP3.

Lare es un pequeño y útil script de Bash para __LAME MP3 Encoder__ creado con la
finalidad de automatizar la tarea de disminuir el bitrate de un lote de archivos
MP3 desde la terminal.

## Requisitos

Para utilizar Lare, asegúrate de tener instalado [LAME MP3 Encoder](https://lame.sourceforge.io/).

## Instalación

Siga estos pasos para instalar y configurar Lare:

1. Clone este repositorio en su máquina local:

```
git clone https://github.com/usuario/Lare.git
```

2.  Ejecute el archivo `wizard.sh` para instalar Lare:

```bash
cd Lare
./wizard.sh
```

3. Una vez que haya instalado Lare, puede ejecutar el script escribiendo el 
siguiente comando y especificando un directorio:

```bash
lare [DIRECTORIO]
```

## Notas

> Este error se solucionó a partir de la versión **v0.1.6**

Si experimentas un error al ejecutar el script puede que se deba a los espacios
en blanco en el nombre de los archivos. Esto es debido a que los nombres de
archivo con espacios en blanco se interpretan como separadores de palabras.

Por lo tanto, es importante que evites los espacios en blanco y los reemplaces
con guiones (-) para asegurar que los archivos se puedan leer correctamente.

## Licencia

Luatiny se encuentra bajo la licencia MIT. Consulte el archivo LICENSE para 
obtener más información.
