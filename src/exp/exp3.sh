#!/bin/bash 

LC_NUMERIC="en_US.UTF-8"


#tamBloques="$(seq 5 5 60)"
tamBloques="$(seq 10 10 120)"


while getopts 'ch' opt; do
  case $opt in
    a) iteraciones=$OPTARG ;;
    h) echo ""
       echo "    Experimento 1. Calculamos cuantos ciclos ejecuta para llegar a tener menor"
       echo "    tolerancia que la pasada para distintos C."
       echo ""
       echo "    Opciones disponibles:"
       echo "        -c        Elimina los archivos generados por el experimento."
       echo "        -h        Imprime este texto de ayuda."
       echo ""
       exit 0 ;;
    c) if [ -d $(dirname $0)/exp3 ]; then rm $(dirname $0)/exp3 -R; fi
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
mkdir -p $(dirname $0)/exp3 #crear carpeta


#---------------#
#PARA EL EXP3-1:#
#---------------#

# paso el video a utilizar a texto:
python $(dirname $0)/../tools/videoToTextfile.py $(dirname $0)/../data/exp2-1.avi $(dirname $0)/exp3/exp3-1-textoOriginal.txt

for i in $tamBloques; do

  #genero los archivos de texto en los que ya les saque cuadros y lo corri con un algoritmo:
  python $(dirname $0)/../tp.py $(dirname $0)/../data/exp2-1.avi $(dirname $0)/exp3/exp3-1-$i-texto.txt 2 3 -s 4 -b $i --text-out

  #genero el archivo donde estan los errores cuadraticos medios:
  python $(dirname $0)/../errorCuadMedio.py $(dirname $0)/exp3/exp3-1-textoOriginal.txt $(dirname $0)/exp3/exp3-1-$i-texto.txt $(dirname $0)/exp3/exp3-1-$i-errorCuadMedio.txt
done

#---------------#
#PARA EL EXP2-2:#
#---------------#


# paso el video a utilizar a texto:
python $(dirname $0)/../tools/videoToTextfile.py $(dirname $0)/../data/exp2-2.avi $(dirname $0)/exp3/exp3-2-textoOriginal.txt


for i in $tamBloques; do

  #genero los archivos de texto en los que ya les saque cuadros y lo corri con un algoritmo:
  python $(dirname $0)/../tp.py $(dirname $0)/../data/exp2-2.avi $(dirname $0)/exp3/exp3-2-$i-texto.txt 2 3 -s 4 -b $i --text-out

  #genero el archivo donde estan los errores cuadraticos medios:
  python $(dirname $0)/../errorCuadMedio.py $(dirname $0)/exp3/exp3-2-textoOriginal.txt $(dirname $0)/exp3/exp3-2-$i-texto.txt $(dirname $0)/exp3/exp3-2-$i-errorCuadMedio.txt
done

#calculamos el error total:
# experimento 3_1):

python $(dirname $0)/../errorTotal-exp3.py $(dirname $0)/exp3/exp3-1-10-texto.txt $(dirname $0)/exp3/exp3-1-10-errorCuadMedio.txt $(dirname $0)/exp3/exp3-1-20-errorCuadMedio.txt $(dirname $0)/exp3/exp3-1-30-errorCuadMedio.txt $(dirname $0)/exp3/exp3-1-40-errorCuadMedio.txt $(dirname $0)/exp3/exp3-1-50-errorCuadMedio.txt $(dirname $0)/exp3/exp3-1-60-errorCuadMedio.txt $(dirname $0)/exp3/exp3-1-70-errorCuadMedio.txt $(dirname $0)/exp3/exp3-1-80-errorCuadMedio.txt $(dirname $0)/exp3/exp3-1-90-errorCuadMedio.txt $(dirname $0)/exp3/exp3-1-100-errorCuadMedio.txt $(dirname $0)/exp3/exp3-1-110-errorCuadMedio.txt $(dirname $0)/exp3/exp3-1-120-errorCuadMedio.txt $(dirname $0)/exp3/exp3-1-erroresTotales.txt

# experimento 3_2):

python $(dirname $0)/../errorTotal-exp3.py $(dirname $0)/exp3/exp3-2-10-texto.txt $(dirname $0)/exp3/exp3-2-10-errorCuadMedio.txt $(dirname $0)/exp3/exp3-2-20-errorCuadMedio.txt $(dirname $0)/exp3/exp3-2-30-errorCuadMedio.txt $(dirname $0)/exp3/exp3-2-40-errorCuadMedio.txt $(dirname $0)/exp3/exp3-2-50-errorCuadMedio.txt $(dirname $0)/exp3/exp3-2-60-errorCuadMedio.txt $(dirname $0)/exp3/exp3-2-70-errorCuadMedio.txt $(dirname $0)/exp3/exp3-2-80-errorCuadMedio.txt $(dirname $0)/exp3/exp3-2-90-errorCuadMedio.txt $(dirname $0)/exp3/exp3-2-100-errorCuadMedio.txt $(dirname $0)/exp3/exp3-2-110-errorCuadMedio.txt $(dirname $0)/exp3/exp3-2-120-errorCuadMedio.txt $(dirname $0)/exp3/exp3-2-erroresTotales.txt
