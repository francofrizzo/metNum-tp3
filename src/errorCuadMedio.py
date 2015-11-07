#!/usr/bin/env python
# -*- coding: utf-8 -*-

from __future__ import division
import sys
import argparse
import os.path


video1 = open(sys.argv[1], 'r')
video2 = open(sys.argv[2], 'r')


cant_cuadros = video1.readline()
cant_cuadros = int(cant_cuadros)
cant_filas_cant_cols = video1.readline()
framerate = video1.readline()
#estas cosas para los dos videos coinciden

#paso los datos de cant_filas_cant_cols a dos ints sparados:
filas_cols = cant_filas_cant_cols.split(",") #ahora en filas_cols tengo una lista de strings [filas, columnas]
cant_filas = filas_cols[0]
cant_cols = filas_cols[1]
cant_filas = int(cant_filas)
cant_cols = int(cant_cols)


cuad_med = [] #este va a ser el arreglo que devuelvo cuando me pasan los dos videos. En cada posicion tenemos la fierencia de cada cuadro
dif = 0 #en dif voy a ir teniendo las diferencias de cada cuadro

for k in range(0, cant_cuadros):

    for i in range(0, cant_filas):
        linea1 = video1.readline()
        linea2 = video2.readline()

        lista1 = linea1.split(",") #en lista1 tengo una lista que es la primer linea del cuadro de video 1 ["pixel1" , "pixel2" , ...] 
        lista2 = linea2.split(",") #en lista2 tengo una lista que es la primer linea del cuadro de video 2 ["pixel1" , "pixel2" , ...] 
        
        for j in range(0, cant_cols):
            p1 = int(lista1[j])
            p2 = int(lista2[j])
            dif = dif + (p1 - p2)**2 
    cuad_med[k] = dif / (cant_cols * cant_filas)


res = open(resultadoDif.txt, 'r')




    # algo = readline()
    # my_string = algo
    # my_list = my_string.split(",") # en my list esta la lista  ["1" , "2" ....]

    #>>> a = "545.2222"
    # >>> float(a)
    # 545.22220000000004
    # >>> int(float(a))
    # 545