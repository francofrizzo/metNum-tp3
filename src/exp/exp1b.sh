#!/bin/bash 

LC_NUMERIC="en_US.UTF-8"

iteraciones=1
tam="1 2 3"
algoritmos="0 1"

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
    c) if [ -d $(dirname $0)/exp1 ]; then rm $(dirname $0)/exp1 -R; fi
       exit 0 ;;
  esac
done

echo "Compilando..."

make -s -C $(dirname $0)/..
if [ $? -ne 0 ]; then
    echo "ERROR: Error de compilación."
    exit 1
fi
echo "Generando datos de entrada...";
mkdir -p $(dirname $0)/exp1 #crear carpeta

for i in $algoritmos; do
  printf "%d\n" "$iteraciones" >> $(dirname $0)/exp1/exp1-b-$i.txt
  for k in $tam; do 

    printf "%d" "$k" >> $(dirname $0)/exp1/exp1-b-$i.txt

    for j in $(seq 1 $iteraciones); do 
        python $(dirname $0)/../tp.py $(dirname $0)/../data/exp1-b-$k.avi $(dirname $0)/exp1/exp1-b-$k-out$i.txt $i 3 -t --text-out -q |
    sed 's/.*: //' |
        while IFS= read -r line; do
          printf " %d" "$line" >> $(dirname $0)/exp1/exp1-b-$i.txt 
        done
    done
    printf "\n" >> $(dirname $0)/exp1/exp1-b-$i.txt
  done
done

octave -q $(dirname $0)/exp1b.m
