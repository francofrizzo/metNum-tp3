#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import argparse
import os.path
from subprocess import call

# Settings
video_to_textfile = "tools/videoToTextfile.py"
textfile_to_video = "tools/textfileToVideo.py"
tp_exec = "./tp"

# Parametros de entrada

parser = argparse.ArgumentParser(description = 'Pasa un video a cámara lenta')
parser.add_argument('ifile', metavar = 'archivo_entrada', type = str,
                    help = 'ruta del archivo de entrada')
parser.add_argument('ofile', metavar = 'archivo_salida', type = str,
                    help = 'ruta del archivo de salida')
parser.add_argument('algoritmo', metavar = 'algoritmo', type = str,
                    help = '0 para vecino más cercano, 1 para lineal, 2 para splines')
parser.add_argument('cant_cuadros', metavar = 'cant_cuadros', type = str,
                    help = 'cantidad de cuadros que se agregarán entre cada par de cuadros del video de entrada')
parser.add_argument('--text-in', action = "store_true",
                    help = 'toma la entrada desde un archivo de texto')
parser.add_argument('--text-out', action = "store_true",
                    help = 'escribe la entrada a un archivo de texto')
parser.add_argument('-s', '--saltar', metavar = 'step', type = int, default = 1,
                    help = 'saltea <step> cuadros al leer el video de entrada')
parser.add_argument('-b', '--bloques', metavar = 'tam', type = str,
                    help = 'si la interpolación se realiza usando splines, aplica el algoritmo de a bloques con el tamaño indicado por parámetro')
parser.add_argument('-t', '--timer', action = "store_true",
                    help = 'calcula e imprime en pantalla el tiempo insumido por la ejecución del método')

args = parser.parse_args()

# Si es necesario, convertimos el video a texto
if not args.text_in:
    print "Convirtiendo video a texto para ser procesado..."
    itextfile = args.ifile + ".txt"
    if not os.path.isfile(itextfile):
        conv_call = call(["python", video_to_textfile, args.ifile, itextfile, "1"])
        if conv_call != 0:
            print "Ocurrió un error durante la conversión del video a texto"
            exit(1)
    else:
        print "El video ya había sido convertido a texto. Se utilizará la versión existente"
else:
    itextfile = args.ifile

# Decidimos el nombre del archivo de salida
if not args.text_out:
    otextfile = args.ofile + ".txt"
else:
    otextfile = args.ofile

# Pasaje a camara lenta
print "Ejecutando el algoritmo solicitado..."
tp_args = []
if args.bloques != None:
    tp_args.extend(["-b", args.bloques])
if args.timer:
    tp_args.append("-t")
tp_args.extend([itextfile, otextfile, args.algoritmo, args.cant_cuadros])

tp_call = call(["./tp"] + tp_args)
if tp_call != 0:
    print "Ocurrió un error durante la ejecución del algoritmo"
    exit(1)

# Si es necesario, convertimos la salida a video
if not args.text_out:
    print "Convirtiendo la salida del algoritmo a video..."
    conv_call = call(["python", textfile_to_video, otextfile, args.ofile])
    if conv_call != 0:
        print "Ocurrió un error durante la conversión de la salida a video"
        exit(1)