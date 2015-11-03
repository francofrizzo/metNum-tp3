#ifndef MNTP3_CONFIG_H
#define MNTP3_CONFIG_H

#include <ctime>     // clock
#include <iostream>  // istream, ostream
#include <vector>    // tipo vector
#include <string.h>  // tipo string

using namespace std;

#define ALG_VECINO    0
#define ALG_LINEAL    1
#define ALG_SPLINE    2
#define ES_ALG_VALIDO(cod) (cod == ALG_VECINO || cod == ALG_LINEAL || cod == ALG_SPLINE)

#define MEDIR_TIEMPO_INICIO(timer) timer = clock();
#define MEDIR_TIEMPO_FIN(timer) timer = clock() - timer;

#define SUMAR_ITERACION(count_iter) (*count_iter)++;

struct conf {
    int alg;                   // algoritmo a utilizar
    int cant_cuadros;          // cantidad de cuadros a agregar
    string ifile;              // path del archivo de entrada
    string ofile;              // path del archivo de salida

    bool timer_flag = false;   // determina si se calculará el tiempo de ejecución
    clock_t timer = 0;         // timer

    bool count_iter_flag = false;   // determina si se contarán las iteraciones
    int count_iter = 0;        // contador de iteraciones

    bool bloques_flag = false;  // determina si la interpolación por splines se hará por bloques
    int tamano_bloque = 0;      // tamaño del bloque
};

template<typename T>
ostream& operator<<(ostream& os, const vector<T>& vec) {
    os << "[";
    for (int i = 0; i < vec.size() - 1; i++) {
        os << vec[i] << ", ";
    }
    os << vec[vec.size() - 1] << "]";
    return os;
}

#endif
