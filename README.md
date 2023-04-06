# Lare

Disminuye el bitrate de tus archivos MP3 desde la terminal.

## Descripción

> Este script fue creado con la motivación de ahorrar más espacio en la memoria de
> almacenamiento del teléfono para guardar archivos MP3.

Lare es un pequeño y útil script de Bash para __LAME MP3 Encoder__ creado con la
finalidad de automatizar la tarea de disminuir el bitrate de un lote de archivos
MP3 desde la terminal.

## Requisitos

Para que este script te funcione de forma correcta es necesario seguir los siguientes
pasos:

* Asegúrate de tener instalado [LAME MP3 Encoder](https://lame.sourceforge.io/).
* Ejecuta el archivo `./wizard.sh` y sigue las instrucciones.
* Escribe el comando ```lare``` e ingresa un directorio.
```bash
lare [DIRECTORIO]
```

### Nota

> Este error se solucionó a partir de la versión **v0.1.6**

Si experimentas un error al ejecutar el script puede que se deba a los espacios
en blanco en el nombre de los archivos. Esto es debido a que los nombres de
archivo con espacios en blanco se interpretan como separadores de palabras.

Por lo tanto, es importante que evites los espacios en blanco y los reemplaces
con guiones (-) para asegurar que los archivos se puedan leer correctamente.

## Próximas mejoras

- [x] Mejorar la experiencia de usuario.
- [x] Corregir los errores que surgen al trabajar con archivos que tienen nombres
que contienen espacios en blanco.
- [ ] Permite la búsqueda de archivos MP3 dentro de los subdirectorios.
