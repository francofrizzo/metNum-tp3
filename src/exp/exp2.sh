#!/bin/bash 

LC_NUMERIC="en_US.UTF-8"

expnum="exp2"

while getopts 'ch' opt; do
  case $opt in
    h) echo ""
       echo "    Experimento 2"
       echo ""
       echo "    Opciones disponibles:"
       echo "        -c        Elimina los archivos generados por el experimento."
       echo "        -h        Imprime este texto de ayuda."
       echo ""
       exit 0 ;;
    c) if [ -d $(dirname $0)/$expnum ]; then rm $(dirname $0)/$expnum -R; fi
       exit 0 ;;
  esac
done

echo "Compilando..."

make -s -C $(dirname $0)/..
if [ $? -ne 0 ]; then
    echo "ERROR: Error de compilación."
    exit 1
fi

if [ -d $(dirname $0)/$expnum ]; then  # si la carpeta existe la borramos
  echo "Borrando directorio $(dirname $0)/$expnum"
  rm -r $(dirname $0)/$expnum
fi

mkdir -p $(dirname $0)/$expnum  # crear carpeta
#python $(dirname $0)/../tools/videoToTextfile.py $(dirname $0)/../data/smelly-cat-2.avi $(dirname $0)/$expnum/$expnum-entrada.txt 

# NOTA: el archivo de entrada debe contener el video original pero borrando 3 de sus cuadros, para luego comparar con esos 3 que se borraron
# se tiene que llamar exp2-entrada.txt

echo "Corriendo experimentos..."

for i in 1 2 3; do

  echo "EXPERIMENTO 2.$i"

  # paso el video a utilizar a texto:
  echo "Pasando a texto el video original..."
  if ! [ -f $(dirname $0)/../data/$expnum-$i.avi.txt ]; then
    python $(dirname $0)/../tools/videoToTextfile.py $(dirname $0)/../data/$expnum-$i.avi $(dirname $0)/../data/$expnum-$i.avi.txt
  else
    echo "El video '$(dirname $0)/../data/$expnum-$i.avi' ya había sido convertido a texto. Se utilizará la versión existente"
  fi

  echo "1" >> $(dirname $0)/$expnum/$expnum-$i-erroresTotales.txt

  for j in 0 1 2; do

    # genero los archivos de texto en los que ya les saque cuadros y lo corri con un algoritmo:

    echo "Corriendo con algoritmo $j..."

    python $(dirname $0)/../tp.py $(dirname $0)/../data/$expnum-$i.avi $expnum/$expnum-$i-$j-texto.txt $j 3 -s 4 --text-out

    # genero el archivo donde estan los errores cuadraticos medios:

    echo "Calculando error cuadrático medio..."

    python $(dirname $0)/../errorCuadMedio.py $(dirname $0)/../data/$expnum-$i.avi.txt $(dirname $0)/$expnum/$expnum-$i-$j-texto.txt $(dirname $0)/$expnum/$expnum-$i-$j-errorCuadMedio.txt

    #calculamos el error total:
    
    echo "Calculando error total..."

    echo -n "$j " >> $(dirname $0)/$expnum/$expnum-$i-erroresTotales.txt

    python $(dirname $0)/../errorTotal.py $(dirname $0)/$expnum/$expnum-$i-$j-texto.txt $(dirname $0)/$expnum/$expnum-$i-$j-errorCuadMedio.txt >> $(dirname $0)/$expnum/$expnum-$i-erroresTotales.txt
  
  done

done
