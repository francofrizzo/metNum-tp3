#!/bin/bash 

LC_NUMERIC="en_US.UTF-8"

expnum="exp3"

iteraciones=1

#tamBloques="$(seq 10 10 120)"
tamBloques="$(seq 2 2 15) 170"

while getopts 'cha:' opt; do
  case $opt in
    a) iteraciones=$OPTARG ;;
    h) echo ""
       echo "    Experimento 3"
       echo ""
       echo "    Opciones disponibles:"
       echo "        -c        Elimina los archivos generados por el experimento."
       echo "        -h        Imprime este texto de ayuda."
       echo "        -a <núm>  Cantidad de iteraciones - por defecto 1"
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

mkdir -p $(dirname $0)/$expnum  #crear carpeta

for i in 1 2 ; do

  echo "EXPERIMENTO 3.$i"

  # paso el video a utilizar a texto:
  echo "Pasando a texto el video original..."
  if ! [ -f $(dirname $0)/../data/$expnum-$i.avi.txt ]; then
    python $(dirname $0)/../tools/videoToTextfile.py $(dirname $0)/../data/$expnum-$i.avi $(dirname $0)/../data/$expnum-$i.avi.txt
  else
    echo "El video '$(dirname $0)/../data/$expnum-$i.avi' ya había sido convertido a texto. Se utilizará la versión existente"
  fi

  echo $iteraciones >> $(dirname $0)/$expnum/$expnum-$i-tiempo.txt 
  echo "1" >> $(dirname $0)/$expnum/$expnum-$i-erroresTotales.txt

  for j in $tamBloques; do

    echo "Corriendo con bloques de tamaño $j..."

    # genero los archivos de texto en los que ya les saque cuadros y lo corri con un algoritmo:
    echo -n "$j" >> $(dirname $0)/$expnum/$expnum-$i-tiempo.txt 

    for k in $(seq $iteraciones); do
      python $(dirname $0)/../tp.py $(dirname $0)/../data/$expnum-$i.avi $(dirname $0)/$expnum/$expnum-$i-$j-texto.txt 2 3 -s 4 -b $j -t --text-out -q | 
        sed 's/.*: //' |
        while IFS=' ' read -r line; do
          printf " %d" $line >> $(dirname $0)/$expnum/$expnum-$i-tiempo.txt 
        done
    done

    printf "\n" $line >> $(dirname $0)/$expnum/$expnum-$i-tiempo.txt 

    # genero el archivo donde estan los errores cuadraticos medios:

    echo "Calculando error cuadrático medio..."

    python $(dirname $0)/../errorCuadMedio.py $(dirname $0)/../data/$expnum-$i.avi.txt $(dirname $0)/$expnum/$expnum-$i-$j-texto.txt $(dirname $0)/$expnum/$expnum-$i-$j-errorCuadMedio.txt

    echo "Calculando error total..."
  
    echo -n "$j " >> $(dirname $0)/$expnum/$expnum-$i-erroresTotales.txt

    python $(dirname $0)/../errorTotal.py $(dirname $0)/$expnum/$expnum-$i-$j-texto.txt $(dirname $0)/$expnum/$expnum-$i-$j-errorCuadMedio.txt >> $(dirname $0)/$expnum/$expnum-$i-erroresTotales.txt

  done
  
  #Ahora miramos el que es spline sin bloques:
    
  echo "Corriendo sin utilizar bloques..."

  cantCuadros=$(head -n 1 $(dirname $0)/../data/$expnum-$i.avi.txt)

  printf "%d" $cantCuadros >> $(dirname $0)/$expnum/$expnum-$i-tiempo.txt

  for k in $(seq $iteraciones); do
    python $(dirname $0)/../tp.py $(dirname $0)/../data/$expnum-$i.avi $(dirname $0)/$expnum/$expnum-$i-sinBloque-texto.txt 2 3 -s 4 -t --text-out -q | 
      sed 's/.*: //' |
      while IFS= read -r line; do
        printf " %d" $line >> $(dirname $0)/$expnum/$expnum-$i-tiempo.txt 
      done 
  done

  printf "\n" $line >> $(dirname $0)/$expnum/$expnum-$i-tiempo.txt 

  echo "Calculando error cuadrático medio..."

  python $(dirname $0)/../errorCuadMedio.py $(dirname $0)/../data/$expnum-$i.avi.txt $(dirname $0)/$expnum/$expnum-$i-sinBloque-texto.txt $(dirname $0)/$expnum/$expnum-$i-sinBloques-errorCuadMedio.txt

  echo "Calculando error total..."

  echo -n "$cantCuadros " >> $(dirname $0)/$expnum/$expnum-$i-erroresTotales.txt

  python $(dirname $0)/../errorTotal.py $(dirname $0)/$expnum/$expnum-$i-sinBloque-texto.txt $(dirname $0)/$expnum/$expnum-$i-sinBloques-errorCuadMedio.txt >> $(dirname $0)/$expnum/$expnum-$i-erroresTotales.txt

done
