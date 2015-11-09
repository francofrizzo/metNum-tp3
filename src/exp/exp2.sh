#!/bin/bash 

LC_NUMERIC="en_US.UTF-8"


while getopts 'ch' opt; do
  case $opt in
    h) echo ""
       echo "    Experimento 2. Vemos cual de los 3 metodos aproxima mejor la "
       echo "    imagen original."
       echo ""
       echo "    Opciones disponibles:"
       echo "        -c        Elimina los archivos generados por el experimento."
       echo "        -h        Imprime este texto de ayuda."
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
echo "Generando datos de entrada...";
mkdir -p $(dirname $0)/exp2 #crear carpeta
#python $(dirname $0)/../tools/videoToTextfile.py $(dirname $0)/../data/smelly-cat-2.avi $(dirname $0)/exp2/exp2-entrada.txt 

#NOTA: el archivo de entrada debe contener el video original pero borrando 3 de sus cuadros, para luego comparar con esos 3 que se borraron
# se tiene que llamar exp2-entrada.txt


#---------------#
#PARA EL EXP2-1:#
#---------------#


# paso el video a utilizar a texto:
python $(dirname $0)/../tools/videoToTextfile.py $(dirname $0)/../data/exp2-1.avi $(dirname $0)/exp2/exp2-1-textoOriginal.txt

#genero los archivos de texto en los que ya les saque cuadros y lo corri con un algoritmo:

python $(dirname $0)/../tp.py $(dirname $0)/../data/exp2-1.avi exp2/exp2-1-0-texto.txt 0 3 -s 4 --text-out

python $(dirname $0)/../tp.py $(dirname $0)/../data/exp2-1.avi exp2/exp2-1-1-texto.txt 1 3 -s 4 --text-out

python $(dirname $0)/../tp.py $(dirname $0)/../data/exp2-1.avi exp2/exp2-1-2-texto.txt 2 3 -s 4 --text-out

#genero el archivo donde estan los errores cuadraticos medios:

python $(dirname $0)/../errorCuadMedio.py $(dirname $0)/exp2/exp2-1-textoOriginal.txt $(dirname $0)/exp2/exp2-1-0-texto.txt $(dirname $0)/exp2/exp2-1-0-errorCuadMedio.txt

python $(dirname $0)/../errorCuadMedio.py $(dirname $0)/exp2/exp2-1-textoOriginal.txt $(dirname $0)/exp2/exp2-1-1-texto.txt $(dirname $0)/exp2/exp2-1-1-errorCuadMedio.txt

python $(dirname $0)/../errorCuadMedio.py $(dirname $0)/exp2/exp2-1-textoOriginal.txt $(dirname $0)/exp2/exp2-1-2-texto.txt $(dirname $0)/exp2/exp2-1-2-errorCuadMedio.txt

#---------------#
#PARA EL EXP2-2:#
#---------------#


# paso el video a utilizar a texto:
python $(dirname $0)/../tools/videoToTextfile.py $(dirname $0)/../data/exp2-2.avi $(dirname $0)/exp2/exp2-2-textoOriginal.txt

#genero los archivos de texto en los que ya les saque cuadros y lo corri con un algoritmo:

  python $(dirname $0)/../tp.py $(dirname $0)/../data/exp2-2.avi exp2/exp2-2-0-texto.txt 0 3 -s 4 --text-out

  python $(dirname $0)/../tp.py $(dirname $0)/../data/exp2-2.avi exp2/exp2-2-1-texto.txt 1 3 -s 4 --text-out

  python $(dirname $0)/../tp.py $(dirname $0)/../data/exp2-2.avi exp2/exp2-2-2-texto.txt 2 3 -s 4 --text-out

#genero el archivo donde estan los errores cuadraticos medios:

python $(dirname $0)/../errorCuadMedio.py $(dirname $0)/exp2/exp2-2-textoOriginal.txt $(dirname $0)/exp2/exp2-2-0-texto.txt $(dirname $0)/exp2/exp2-2-0-errorCuadMedio.txt 

python $(dirname $0)/../errorCuadMedio.py $(dirname $0)/exp2/exp2-2-textoOriginal.txt $(dirname $0)/exp2/exp2-2-1-texto.txt $(dirname $0)/exp2/exp2-2-1-errorCuadMedio.txt

python $(dirname $0)/../errorCuadMedio.py $(dirname $0)/exp2/exp2-2-textoOriginal.txt $(dirname $0)/exp2/exp2-2-2-texto.txt $(dirname $0)/exp2/exp2-2-2-errorCuadMedio.txt

#calculamos el error total:

#experimento 2_1):
python $(dirname $0)/../errorTotal-exp2.py exp2/exp2-1-0-texto.txt $(dirname $0)/exp2/exp2-1-0-errorCuadMedio.txt $(dirname $0)/exp2/exp2-1-1-errorCuadMedio.txt $(dirname $0)/exp2/exp2-1-2-errorCuadMedio.txt $(dirname $0)/exp2/exp2-1-erroresTotales.txt


#experimento 2_2):
python $(dirname $0)/../errorTotal-exp2.py exp2/exp2-2-0-texto.txt $(dirname $0)/exp2/exp2-2-0-errorCuadMedio.txt $(dirname $0)/exp2/exp2-2-1-errorCuadMedio.txt $(dirname $0)/exp2/exp2-2-2-errorCuadMedio.txt $(dirname $0)/exp2/exp2-2-erroresTotales.txt


# #experimento con foto gato-Phoebe:
# paso el video a utilizar a texto:


python $(dirname $0)/../tools/videoToTextfile.py $(dirname $0)/../data/exp2-3.avi $(dirname $0)/exp2/exp2-3-textoOriginal.txt


python $(dirname $0)/../tp.py $(dirname $0)/../data/exp2-3.avi $(dirname $0)/exp2/exp2-3-0-texto.txt 0 3 -s 4 --text-out

python $(dirname $0)/../tp.py $(dirname $0)/../data/exp2-3.avi $(dirname $0)/exp2/exp2-3-1-texto.txt 1 3 -s 4 --text-out

python $(dirname $0)/../tp.py $(dirname $0)/../data/exp2-3.avi $(dirname $0)/exp2/exp2-3-2-texto.txt 2 3 -s 4 --text-out


python $(dirname $0)/../errorCuadMedio.py $(dirname $0)/exp2/exp2-3-textoOriginal.txt $(dirname $0)/exp2/exp2-3-0-texto.txt $(dirname $0)/exp2/exp2-3-0-errorCuadMedio.txt 

python $(dirname $0)/../errorCuadMedio.py $(dirname $0)/exp2/exp2-3-textoOriginal.txt $(dirname $0)/exp2/exp2-3-1-texto.txt $(dirname $0)/exp2/exp2-3-1-errorCuadMedio.txt

python $(dirname $0)/../errorCuadMedio.py $(dirname $0)/exp2/exp2-3-textoOriginal.txt $(dirname $0)/exp2/exp2-3-2-texto.txt $(dirname $0)/exp2/exp2-3-2-errorCuadMedio.txt

#calculamos el error total:

python $(dirname $0)/../errorTotal-exp2.py $(dirname $0)/exp2/exp2-3-0-texto.txt $(dirname $0)/exp2/exp2-3-0-errorCuadMedio.txt $(dirname $0)/exp2/exp2-3-1-errorCuadMedio.txt $(dirname $0)/exp2/exp2-3-2-errorCuadMedio.txt $(dirname $0)/exp2/exp2-3-erroresTotales.txt
