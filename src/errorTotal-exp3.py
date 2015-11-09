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
errores4 = open(sys.argv[5], 'r')
errores5 = open(sys.argv[6], 'r')
errores6 = open(sys.argv[7], 'r')
errores7 = open(sys.argv[8], 'r')
errores8 = open(sys.argv[9], 'r')
errores9 = open(sys.argv[10], 'r')
errores10 = open(sys.argv[11], 'r')
errores11 = open(sys.argv[12], 'r')
errores12 = open(sys.argv[13], 'r')
salida = open(sys.argv[5], 'w')

#leo el 1 del inicio:
errores1.readline()
errores2.readline()
errores3.readline()
errores4.readline()
errores5.readline()
errores6.readline()
errores7.readline()
errores8.readline()
errores9.readline()
errores10.readline()
errores11.readline()
errores12.readline()



cant_cuadros = video0.readline()
cant_cuadros = int(cant_cuadros)

suma1 = 0
suma2 = 0
suma3 = 0
suma4 = 0
suma5 = 0
suma6 = 0
suma7 = 0
suma8 = 0
suma9 = 0
suma10 = 0
suma11 = 0
suma12 = 0


for i in range(0, cant_cuadros - 1):

	linea1 = errores1.readline()
	valores1 = linea1.split('\n') #ahora en valores1 tengo una lista de strings ["indice, error"]
	valores1 = valores1[0]
	valores1 = valores1.split(" ")
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

	# linea4 = errores4.readline()
	# print linea4
	# valores4 = linea4.split('\n') #ahora en valores1 tengo una lista de strings ["indice, error"]
	# print valores4
	# valores4 = valores4[0]
	# valores4 = valores4.split(" ")
	# suma4 = suma4 + float(valores4[1])

	linea5 = errores5.readline()
	valores5 = linea5.split('\n') #ahora en valores1 tengo una lista de strings ["indice, error"]
	valores5 = valores5[0]
	valores5 = valores5.split(" ")
	suma5 = suma5 + float(valores5[1])

	linea6 = errores6.readline()
	valores6 = linea6.split('\n') #ahora en valores1 tengo una lista de strings ["indice, error"]
	valores6 = valores6[0]
	valores6 = valores6.split(" ")
	suma6 = suma6 + float(valores6[1])

	linea7 = errores7.readline()
	valores7 = linea7.split('\n') #ahora en valores1 tengo una lista de strings ["indice, error"]
	valores7 = valores7[0]
	valores7 = valores7.split(" ")
	suma7 = suma7 + float(valores7[1])

	linea8 = errores8.readline()
	valores8 = linea8.split('\n') #ahora en valores1 tengo una lista de strings ["indice, error"]
	valores8 = valores8[0]
	valores8 = valores8.split(" ")
	suma8 = suma8 + float(valores8[1])

	linea9 = errores9.readline()
	valores9 = linea9.split('\n') #ahora en valores1 tengo una lista de strings ["indice, error"]
	valores9 = valores9[0]
	valores9 = valores9.split(" ")
	suma9 = suma9 + float(valores9[1])

	linea10 = errores10.readline()
	valores10 = linea10.split('\n') #ahora en valores1 tengo una lista de strings ["indice, error"]
	valores10 = valores10[0]
	valores10 = valores10.split(" ")
	suma10 = suma10 + float(valores10[1])

	linea11 = errores11.readline()
	valores11 = linea11.split('\n') #ahora en valores1 tengo una lista de strings ["indice, error"]
	valores11 = valores11[0]
	valores11 = valores11.split(" ")
	suma11 = suma11 + float(valores11[1])

	linea12 = errores12.readline()
	valores12 = linea12.split('\n') #ahora en valores1 tengo una lista de strings ["indice, error"]
	valores12 = valores12[0]
	valores12 = valores12.split(" ")
	suma12 = suma12 + float(valores12[1])
	

suma1 = suma1 / cant_cuadros
suma2 = suma2 / cant_cuadros
suma3 = suma3 / cant_cuadros
suma4 = suma4 / cant_cuadros
suma5 = suma5 / cant_cuadros
suma6 = suma6 / cant_cuadros
suma7 = suma7 / cant_cuadros
suma8 = suma8 / cant_cuadros
suma9 = suma9 / cant_cuadros
suma10 = suma10 / cant_cuadros
suma11 = suma11 / cant_cuadros
suma12 = suma12 / cant_cuadros

salida.write('10')
salida.write(" ")
salida.write(str(suma1))
salida.write("\n")

salida.write(str(suma2))
salida.write("\n")

salida.write(str(suma3))
salida.write("\n")

salida.write(str(suma4))
salida.write("\n")

salida.write(str(suma5))
salida.write("\n")

salida.write(str(suma6))
salida.write("\n")

salida.write(str(suma7))
salida.write("\n")

salida.write(str(suma8))
salida.write("\n")

salida.write(str(suma9))
salida.write("\n")

salida.write(str(suma10))
salida.write("\n")

salida.write(str(suma11))
salida.write("\n")

salida.write(str(suma12))

salida.close()

