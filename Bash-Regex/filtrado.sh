#!/bin/bash

# FILTRADO PARA MOSTRAR SOLO USUARIOS QUE CONTENGAN UN NUMERO

grep -E "^[^,]*[0-9][^,]*," usuarios.txt
