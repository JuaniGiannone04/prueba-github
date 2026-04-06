#!/bin/bash

# VALIDAR FORMATO
# GUARDAR IPS, METODOS Y CODIGOS
# DETECTAR IPS SOSPECHOSAS (MAS DE 3 ERRORES)

archivo="$1"

if [ -f "$archivo" ]; then

        > errores.txt
        > ips.txt
        > metodos.txt
        > codigos.txt
        > errores_ip.txt
        > sospechosos.txt

        while IFS= read -r linea; do

                if echo "$linea" | grep -Eq '^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+ - - \[[0-9]{2}/[A-Za-z]+/[0-9]{4}:[0-9]{2}:[0-9]{2}:[0-9]{2}\] "(GET|POST) /[^ ]+" [0-9]{3}$'; then

                        ip=$(echo "$linea" | cut -d' ' -f1)
                        metodo=$(echo "$linea" | grep -oE '"(GET|POST)' | cut -d'"' -f2)
                        codigo=$(echo "$linea" | grep -oE '[0-9]{3}$')

                        echo "$ip" >> ips.txt
                        echo "$metodo" >> metodos.txt
                        echo "$codigo" >> codigos.txt 

                        # DETECTAR ERRORES
                        if [ "$codigo" -ne 200 ]; then
                                echo "$ip" >> errores_ip.txt
                        fi

                else
                        echo "$linea" >> errores.txt
                fi

        done < "$archivo"

        # ESTADISTICAS
        sort ips.txt | uniq -c | sort -nr > ips_final.txt
        sort metodos.txt | uniq -c | sort -nr > metodos_final.txt
        sort codigos.txt | uniq -c | sort -nr > codigos_final.txt

        # DETECTAR SOSPECHOSOS
        sort errores_ip.txt | uniq -c | while read cantidad ip; do
                if [ "$cantidad" -gt 3 ]; then
                        echo "$ip" >> sospechosos.txt
                fi
        done

else
        echo "EL ARCHIVO NO EXISTE"
fi
