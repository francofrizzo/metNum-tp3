#!/bin/bash 

LC_NUMERIC="en_US.UTF-8"

tamBloques="$(seq 2 2 15) 20 50 70 80 100 170"


mkdir -p $(dirname $0)/exp3/ecm

for i in 1 2; do
	for j in $tamBloques; do
		python $(dirname $0)/../errorCuadMedio.py $(dirname $0)/exp3/exp3-$i-$j-texto.txt $(dirname $0)/exp3/exp3-$i-sinBloque-texto.txt $(dirname $0)/exp3/ecm/exp3-$i-$j-errorCuadMedio.txt
	done
done
