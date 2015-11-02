#include "./interpolacion.h"

vector<int> interpolar_vecino(const vector<int> ipixel, const int cant_cuadros) {
    vector<int> opixel;
    
    for (int i = 0; i < ipixel.size(); i++){
        opixel.push_back(ipixel[i]);

        for (int j = 0; j < (cant_cuadros / 2); j++){ //el del medio queda igual que el de la derecha
            opixel.push_back(ipixel[i]);
        }
        
        for (int j = (cant_cuadros / 2); j < cant_cuadros; j++){
            opixel.push_back(ipixel[i + 1]);
        }

    }    
    
    opixel.push_back(ipixel[ipixel.size()]);

    return opixel;
}

vector<int> interpolar_lineal(const vector<int> ipixel, const int cant_cuadros) {
    vector<int> opixel;

    for (int i = 0; i < ipixel.size() - 1; i++) {
        opixel.push_back(ipixel[i]);

        double frame_actual = (double) ipixel[i];
        double ultimo_frame = (double) ipixel[i + 1];
        double inc = (ultimo_frame - frame_actual) / (cant_cuadros + 1);
        for (int j = 0; j < cant_cuadros; j++) {
            frame_actual = frame_actual + inc;
            opixel.push_back((int) round(frame_actual));
        }
    }
    
    opixel.push_back(ipixel[ipixel.size()]);

    return opixel;
}

vector<int> interpolar_spline(const vector<int> ipixel, const int cant_cuadros) {
    vector<int> opixel;
    opixel = ipixel;
    return opixel;
}
