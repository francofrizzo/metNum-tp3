#ifndef MNTP3_INTERPOLACION_H
#define MNTP3_INTERPOLACION_H

#include "./config.h"
#include <vector>    // tipo vector
#include <string.h>  // tipo string

vector<int> interpolar_vecino(const vector<int> ipixel, const int cant_cuadros);

vector<int> interpolar_lineal(const vector<int> ipixel, const int cant_cuadros);

vector<int> interpolar_spline(const vector<int> ipixel, const int cant_cuadros);

#endif
