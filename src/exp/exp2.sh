#!/bin/bash 

LC_NUMERIC="en_US.UTF-8"

iteraciones=1

tamBloques="$(seq 5 5 60)"

while getopts 'cha:' opt; do
  case $opt in
    a) iteraciones=$OPTARG ;;
    h) echo ""
       echo "    Experimento 1. Calculamos cuantos ciclos ejecuta para llegar a tener menor"
       echo "    tolerancia que la pasada para distintos C."
       echo ""
       echo "    Opciones disponibles:"
       echo "        -c        Elimina los archivos generados por el experimento."
       echo "        -h        Imprime este texto de ayuda."
       echo "        -a <núm>  Cantidad de iteraciones- por defecto 1"
       echo ""
       exit 0 ;;
    c) if [ -d $(dirname $0)/exp2 ]; then rm $(dirname $0)/exp2 -R; fi
       exit 0 ;;
  esac
done

echo "Compilando..."

make -s -C $(dirname $0)/..
if [ $? -ne 0 ]; then
    echo "ERROR: Error de compilación."
    exit 1
fi
#echo "Generando datos de entrada...";
#mkdir -p $(dirname $0)/exp2 #crear carpeta
#python $(dirname $0)/../tools/videoToTextfile.py $(dirname $0)/../data/smelly-cat-2.avi $(dirname $0)/exp2/exp2-entrada.txt 

#NOTA: el archivo de entrada debe contener el video original pero borrando 3 de sus cuadros, para luego comparar con esos 3 que se borraron
# se tiene que llamar exp2-entrada.txt

$(dirname $0)/../tp $(dirname $0)/exp2/exp2-entrada.txt $(dirname $0)/exp2/exp2-salida-algoritmo-0.txt 0 3
  
$(dirname $0)/../tp $(dirname $0)/exp2/exp2-entrada.txt $(dirname $0)/exp2/exp2-salida-algoritmo-1.txt 1 3

$(dirname $0)/../tp $(dirname $0)/exp2/exp2-entrada.txt $(dirname $0)/exp2/exp2-salida-algoritmo-2.txt 2 3

#octave -q $(dirname $0)/exp2.m

