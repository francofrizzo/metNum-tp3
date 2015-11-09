#!/usr/bin/env python
# -*- coding: utf-8 -*-

from __future__ import division
import sys
import argparse
import os.path

#el video 0 tiene que tener la cantidad de cuadros de los generados. Es el arcivo 
#$(dirname $0)/exp2/exp2-2-0-texto.txt

video0 = open(sys.argv[1], 'r')
errores1 = open(sys.argv[2], 'r')
errores2 = open(sys.argv[3], 'r')
errores3 = open(sys.argv[4], 'r')
salida = open(sys.argv[5], 'w')

#leo el 1 del inicio:
errores1.readline()
errores2.readline()
errores3.readline()


cant_cuadros = video0.readline()
cant_cuadros = int(cant_cuadros)

suma1 = 0
suma2 = 0
suma3 = 0

for i in range(0, cant_cuadros - 1):

	linea1 = errores1.readline()
	valores1 = linea1.split('\n') #ahora en valores1 tengo una lista de strings ["indice, error"]
	valores1 = valores1[0]
	#print valores1
	valores1 = valores1.split(" ")
	print valores1
	#print valores1[1]
	#print float(valores1[1])
	suma1 = suma1 + float(valores1[1])

	linea2 = errores2.readline()
	valores2 = linea2.split('\n') #ahora en valores2 tengo una lista de strings [indice, error]
	valores2 = valores2[0]
	valores2 = valores2.split(" ")
	suma2 = suma2 + float(valores2[1])

	linea3 = errores3.readline()
	valores3 = linea3.split('\n') #ahora en valores2 tengo una lista de strings [indice, error]
	valores3 = valores3[0]
	valores3 = valores3.split(" ")
	suma3 = suma3 + float(valores3[1])
	

suma1 = suma1 / cant_cuadros
suma2 = suma2 / cant_cuadros
suma3 = suma3 / cant_cuadros

salida.write(str(suma1))
salida.write("\n")

salida.write(str(suma2))
salida.write("\n")

salida.write(str(suma3))

salida.close()


