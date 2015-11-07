#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import argparse
import os.path
from subprocess import call

# Settings
pathname = os.path.dirname(sys.argv[0])
if len(pathname) == 0:
    pathname = "."

video_to_textfile = pathname + "/tools/videoToTextfile.py"
textfile_to_video = pathname + "/tools/textfileToVideo.py"
tp_exec = pathname + "/tp"

dev_null = open(os.devnull, 'w') #leer el archivo, w=escritura r=lectura

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
parser.add_argument('-q', '--quiet', action = "store_true",
                    help = 'no emite comentarios innecesarios')

args = parser.parse_args()

# Si es necesario, convertimos el video a texto
if not args.text_in:
    if not args.quiet:
        print "Convirtiendo video a texto para ser procesado..."
    if args.saltar == 1:
        itextfile = args.ifile + ".txt"
    else:
        itextfile = args.ifile + "." + str(args.saltar) + ".txt"
    if not os.path.isfile(itextfile):
        if args.quiet:
            conv_call = call(["python", video_to_textfile, args.ifile, itextfile, str(args.saltar)], stdout=dev_null)
        else:
            conv_call = call(["python", video_to_textfile, args.ifile, itextfile, str(args.saltar)])
        if conv_call != 0:
            print "Ocurrió un error durante la conversión del video a texto"
            exit(1)
    else:
        if not args.quiet:
            print "El video ya había sido convertido a texto. Se utilizará la versión existente"
else:
    itextfile = args.ifile

# Decidimos el nombre del archivo de salida
if not args.text_out:
    otextfile = args.ofile + ".txt"
else:
    otextfile = args.ofile

# Pasaje a camara lenta
if not args.quiet:
    print "Ejecutando el algoritmo solicitado..."
tp_args = []
if args.bloques != None:
    tp_args.extend(["-b", args.bloques])
if args.timer:
    tp_args.append("-t")
tp_args.extend([itextfile, otextfile, args.algoritmo, args.cant_cuadros])

tp_call = call([tp_exec] + tp_args)
if tp_call != 0:
    print "Ocurrió un error durante la ejecución del algoritmo"
    exit(1)

# Si es necesario, convertimos la salida a video
if not args.text_out:
    if not args.quiet:
        print "Convirtiendo la salida del algoritmo a video..."
    if args.quiet:
        conv_call = call(["python", textfile_to_video, otextfile, args.ofile], stdout=dev_null)
    else:
        conv_call = call(["python", textfile_to_video, otextfile, args.ofile])
    if conv_call != 0:
        print "Ocurrió un error durante la conversión de la salida a video"
        exit(1)