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
    
    opixel.push_back(ipixel[ipixel.size() - 1]);

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
    
    opixel.push_back(ipixel[ipixel.size() - 1]);

    return opixel;
}

vector<int> interpolar_spline_bloques(const vector<int> ipixel, const int cant_cuadros, const int tamano_bloque) {
    vector<int> opixel;

    for (int i = 0; i < ipixel.size(); i = i + tamano_bloque) {
        vector<int>::const_iterator first = ipixel.begin() + i;
        vector<int>::const_iterator last;
        if (i + tamano_bloque < ipixel.size()) {
            last = ipixel.begin() + (i + tamano_bloque + 1);
        } else {
            last = ipixel.end();
        }
        vector<int> bloque = vector<int>(first, last);

        cout << bloque << endl;

        bloque = interpolar_spline(bloque, cant_cuadros);

        for (int j = 0; j < bloque.size() - 1; j++) {
            opixel.push_back(bloque[j]);
        }
    }

    opixel.push_back(ipixel[ipixel.size() - 1]);

    cout << opixel << endl;

    return opixel;
}

vector<int> interpolar_spline(const vector<int> a, const int cant_cuadros) {
    vector<int> res;

    int n = a.size() - 1;

    if (n < 1) {
        res = a;
    } else {
        vector<double> alpha(n, 0);
        vector<double> l(n+1, 0);
        vector<double> mu(n, 0);
        vector<double> z(n+1, 0);
        vector<double> b(n, 0);
        vector<double> c(n, 0);
        vector<double> d(n, 0);

        // Burden, paso 1: lo omitimos porque h siempre vale 1

        // Burden, paso 2
        for (int i = 1; i < n; i++) {
            alpha[i] = 3 * (a[i+1] - 2 * a[i] + a[i-1]);
        }

        // Burden, paso 3
        l[0] = 1;
        mu[0] = 0;
        z[0] = 0;

        // Burden, paso 4
        for (int i = 1; i < n; i++) {
            l[i] = 4 - mu[i-1];
            mu[i] = 1 / l[i];
            z[i] = (alpha[i] - z[i-1]) / l[i];
        }

        // Burden, paso 5
        z[n] = 0;
        c[n] = 0;

        // Burden, paso 6
        for (int j = n - 1; j >= 0; j--) {
            c[j] = z[j] - mu[j] * c[j+1];
            b[j] = (a[j+1] - a[j]) - (c[j+1] + 2 * c[j]) / 3;
            d[j] = (c[j+1] - c[j]) / 3;
        }

        // Evaluacion de las splines

        double inc = (double) 1 / (cant_cuadros + 1);
        for (int i = 0; i < n; i++) {
            res.push_back(a[i]);
            for (int j = 1; j <= cant_cuadros; j++) {
                double x = j * inc;
                int eval = round(a[i] + b[i] * x + c[i] * x * x + d[i] * x * x * x);
                if (eval > 255) {
                    eval = 255;
                }
                if (eval < 0) {
                    eval = 0;
                }
                res.push_back(eval);
            }
        }
        res.push_back(a[n]);
    }
    cout << res << endl;

    return res;
}
