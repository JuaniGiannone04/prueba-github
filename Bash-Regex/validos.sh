#!/bin/bash

# ESTE SCRIPT LISTA LOS USUARIOS QUE TENGAN UN FORMATO VALIDO: USERNAME SIN ESPACIOS
# Y CONTRASEÑAS CON NUMERO. ADEMAS GUARDA EN UN ARCHIVO DE ERRORES LOS USUARIOS 
# Y CONTRASEÑAS QUE NO CUMPLAN

grep -E "^[^, ]+,[^,]*[0-9][^,]*$" usuarios.csv

grep -v "^[^, ]+,[^,]*[0-9][^,]*$" usuarios.csv > errores.csv
