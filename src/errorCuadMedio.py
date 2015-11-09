#!/usr/bin/env python
# -*- coding: utf-8 -*-

from __future__ import division
import sys
import argparse
import os.path

video1 = open(sys.argv[1], 'r')
video2 = open(sys.argv[2], 'r')
salida = open(sys.argv[3], 'w')

cant_cuadros1 = int(video1.readline())
cant_cuadros2 = int(video2.readline())
cant_cuadros = min(cant_cuadros2, cant_cuadros2)

# paso los datos de cant_filas_cant_cols a dos ints sparados:
filas_cols = video1.readline().split(",")  # ahora en filas_cols tengo una lista de strings [filas, columnas]
cant_filas = int(filas_cols[0])
cant_cols = int(filas_cols[1])
N = cant_cols * cant_filas

# lecturas dummy para empezar a leer los datos
video1.readline()
video2.readline()
video2.readline()

cuad_med = [] # este va a ser el arreglo que devuelvo cuando me pasan los dos videos. En cada posicion tenemos la fierencia de cada cuadro

for k in range(0, cant_cuadros):
    dif = 0 #en dif voy a ir teniendo las diferencias de cada cuadro

    for i in range(0, cant_filas): # itero sobre las filas del video
        linea1 = video1.readline()
        linea2 = video2.readline()

        lista1 = linea1.split(",") # en lista1 tengo una lista que es la primer linea del cuadro de video 1 ["pixel1" , "pixel2" , ...] 
        lista2 = linea2.split(",") # en lista2 tengo una lista que es la primer linea del cuadro de video 2 ["pixel1" , "pixel2" , ...] 
        
        for j in range(0, cant_cols): # itero sobre las columnas de la fila
            p1 = int(lista1[j])
            p2 = int(lista2[j])
            dif = dif + (p1 - p2) ** 2

    cuad_med.append(dif / N)

tam = len(cuad_med)
salida.write(str(1))
salida.write("\n")

for i in range(0, tam):
    iadd = i + 1
    salida.write(str(iadd))
    salida.write(" ")
    salida.write(str(cuad_med[i]))
    salida.write("\n")

salida.close()
