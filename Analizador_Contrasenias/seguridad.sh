#!/bin/bash

# ESTE SCRIPT DEBE:
# VALIDAR QUE SE CUMPLA FORMATO: USUARIO, CONTRASENIA
# USUARIO TENGA SOLO LETRAS Y CONTRA SIN ESPACIOS
# SI NO CUMPLE GUARDA EN errores.txt
# CLASIFICAR CONTRAS EN:
# DEBIL: MENOS DE 6 CARACTERES Y SOLO NUMEROS O SOLO LETRAS
# MEDIA: LETRAS Y NUMEROS SIN CONDICIONES FUERTES
# FUERTE: AL MENOS 8 CARACTERES CON MAYUSCULAS, MINUSCULAS Y NUMEROS
# GENERA ARCHIVOS: debiles.txt, medias.txt, fuertes.txt, errores.txt
# MUESTRA POR PANTALLA LA CANTIDAD DE DEBILES, MEDIAS Y FUERTES


archivo="$1"

archivo="$1"

if [ -f "$archivo" ]; then

        > debiles.txt
        > medias.txt
        > fuertes.txt
        > errores.txt

        while IFS= read -r linea; do

                if echo "$linea" | grep -Eq "^[a-zA-Z]+,[^ ]+$"; then

                        contrasenia=$(echo "$linea" | cut -d',' -f2)

                        longitud=${#contrasenia}

                        if [ "$longitud" -lt 6 ] || echo "$contrasenia" | grep -Eq "^[a-zA-Z]+$" || echo "$contrasenia" | grep -Eq "^[0-9]+$"; then
                                echo "$linea" >> debiles.txt 

                        elif [ "$longitud" -ge 8 ] && echo "$contrasenia" | grep -Eq "[A-Z]" && echo "$contrasenia" | grep -Eq "[a-z]" && echo "$contrasenia" | grep -Eq "[0-9]"; then
                                echo "$linea" >> fuertes.txt

                        else
                                echo "$linea" >> medias.txt 

                        fi

                else
                        echo "$linea" >> errores.txt
                fi

        done < "$archivo"

else
        echo "EL ARCHIVO NO EXISTE"

fi
