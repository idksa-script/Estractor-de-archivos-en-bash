#!/bin/bash

# Verfica si es que el usuario ha ingresado un argumento 
# Si no lo ingresa imprime un ejemplo de como deberia de usarlo
if [ -z "$1" ]; then
    echo "ejemplo de como usar:"
    echo "Masivo.sh <argumento1> <argumento2>"
    exit 1
fi

#Se guarda en una lista todos los argumentos ingresados
lista=("$@")

#Se inicializa una variable para guardar la contraseña si es que tiene
password=""

#verfica si tiene contraseña el archivo dado
if unrar l "${lista}" &>/dev/null; then
    read -p "Ingresa la contraseña: " password

else 
    echo ""
fi

#Creamos un bucle for para iterar sobre la lista
for i in ${lista[@]}; do
    #Verifica si es un archivo rar
    if [[ "${i: -4}" == ".rar" ]]; then
        #Si es un rar hace otra verificacion si es que tiene o no contraseña
        if unrar l "$i" &>/dev/null; then
            #Si es asi ejecuta unrar con la contraseña dada
            unrar x -p"$password" "$i"
            #Si no lo ejecuta sin contraseña
        else 
            unrar x "$i"
        fi

    #Si el archivo no es rar ejecuta el siguiente echo
    else
        echo "$i Es un archivo desconocido"
    fi
done

#Fin
