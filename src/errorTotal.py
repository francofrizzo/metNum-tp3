#!/usr/bin/env python
# -*- coding: utf-8 -*-

from __future__ import division
import sys
import os.path

#el video 0 tiene que tener la cantidad de cuadros de los generados. Es el arcivo 
#$(dirname $0)/exp2/exp2-2-0-texto.txt

video   = open(sys.argv[1], 'r')
errores = open(sys.argv[2], 'r')

#leo el 1 del inicio:
errores.readline()

cant_cuadros = int(video.readline())
cant_a_generar = 3

cuentita = ((cant_cuadros - 1) / (cant_a_generar + 1)) * cant_a_generar

suma = 0

for i in range(0, cant_cuadros - 1):
	linea = errores.readline()
	valores = linea.split('\n') #ahora en valores1 tengo una lista de strings ["indice, error"]
	valores = valores[0]
	valores = valores.split(" ")
	suma = suma + float(valores[1])

suma = suma / cant_cuadros

print suma

video.close()
errores.close()
