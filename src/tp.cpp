#include <iostream>  // istream, ostream
#include <iomanip>   // setw, setprecision
#include <fstream>   // ifstream, ofstream
#include <vector>    // tipo vector
#include <string.h>  // tipo string
#include <unistd.h>  // getopt

#include "./config.h"
#include "./interpolacion.h"

#define INTENTAR_PARSEO(funcion_parseo, nombre) \
    try { funcion_parseo } catch (exception e) { \
        cout << "El parámetro "#nombre" no es válido" << endl; \
        exit(1); \
    }

using namespace std;

void mostrar_ayuda(char*);
void parsear_argumentos(conf&, char**);
void imprimir_tiempo(clock_t);

int main(int argc, char* argv[]) {
    conf args;
    ifstream ifile;
    ofstream ofile;
    // int cant_nodos;
    // int cant_aristas;

    // Parseo de argumentos
    if (argc > 4) {
        parsear_argumentos(args, argv);
    } else {
        // En caso de faltar argumentos, mostrar ayuda y salir
        mostrar_ayuda(argv[0]);
        exit(1);
    }

    // Parseo de opciones especiales
    char opt;
    while ((opt = getopt(argc, argv, "htc")) != -1) {
        switch (opt) {
            case 'h': { // mostrar ayuda
                mostrar_ayuda(argv[0]);
                exit(0);
                break;
            }
            case 't': { // calcular tiempo de ejecución
                args.timer_flag = true;
                break;
            }
            case 'c': { // calcular cantidad de iteraciones
                args.count_iter_flag = true;
                break;
            }
            default: { // si las opciones son inválidas
                mostrar_ayuda(argv[0]);
                exit(1);
                break;
            }
        }
    }

    // Apertura de archivos de entrada y salida
    ifile.open(args.ifile, ios_base::in);  // archivo de entrada
    if (! ifile.good()) {
        cout << "Error al abrir el archivo de entrada" << endl;
        exit(1);
    }

    ofile.open(args.ofile, ios_base::app);  // archivo de salida
    if (! ofile.good()) {
        cout << "Error al abrir el archivo de salida" << endl;
        exit(1);
    }

    // Reviso que el algoritmo solicitado sea válido
    if (! ES_ALG_VALIDO(args.alg)) {
        cout << "Error: El algoritmo solicitado no es válido" << endl;
        exit(1);
    }

    // Declaracion de variables de datos
    int c, nuevo_c, height, width, f, pixel;
    vector<vector<vector<int> > > ivideo(height, vector<vector<int> >(width, vector<int>()));
    vector<vector<vector<int> > > ovideo(height, vector<vector<int> >(width, vector<int>()));

    // Parseo del archivo de entrada
    ifile >> c;
    ifile >> height;
    ifile >> width;
    ifile >> f;

    for (int t = 0; t < c; t++) {
        for (int i = 0; i < height; i++) {
            for (int j = 0; j < width; j++) {
                ifile >> pixel;
                ivideo[i][j].push_back(pixel);
            }
        }
    }

    // Ejecucion del algoritmo
    for (int i = 0; i < height; i++) {
        for (int j = 0; j < width; j++) {
            vector<int> ipixel = ivideo[i][j];
            vector<int> opixel;
            switch (args.alg) {
                case ALG_VECINO: {
                    opixel = interpolar_vecino(ipixel, args.cant_cuadros);
                }
                case ALG_LINEAL: {
                    opixel = interpolar_lineal(ipixel, args.cant_cuadros);
                }
                case ALG_SPLINE: {
                    opixel = interpolar_spline(ipixel, args.cant_cuadros);
                }
            }
            ovideo[i][j] = opixel;
        }
    }

    // Escritura en archivo de salida
    nuevo_c = c * (args.cant_cuadros + 1) - args.cant_cuadros;

    ofile << nuevo_c << endl;
    ofile << height << " " << width << endl;
    ofile << f << endl;

    for (int t = 0; t < nuevo_c; t++) {
        for (int i = 0; i < height; i++) {
            for (int j = 0; j < width - 1; j++) {
                ofile << ovideo[i][j][t] << " ";
            }
            ofile << ovideo[i][width - 1][t];
            ofile << endl;
        }
    }

    // Imprimir por pantalla tiempo de ejecución
    if (args.timer_flag) {
        cout << "Tiempo de ejecución (ticks de reloj): " << args.timer << endl;
    }

    // Imprimir por pantalla cantidad de iteraciones
    if (args.count_iter_flag) {
        cout << "Cantidad de iteraciones: " << args.count_iter << endl;
    }

    // Cierro los archivos
    ifile.close();
    ofile.close();

    return 0;
}


void mostrar_ayuda(char* s) {
    cout << "  Modo de uso: " << setw(12) << s <<" [-opción] [argumento] <archivo_entrada>" << endl;
    cout <<           "                            <archivo_salida> <algoritmo> <cant_cuadros>" << endl;
    cout << "  Parámetros:" << endl;
    cout << "    archivo_entrada   Ruta del archivo de entrada" << endl;
    cout << "    archivo_salida    Ruta donde se escribirá el resultado del proceso" << endl;
    cout << "    algoritmo         0 para vecino más cercano, 1 para lineal, 2 para splines" << endl;
    cout << "    cant_cuadros      Cantidad de cuadros que se agregarán entre cada par de" << endl;
    cout << "                        cuadros del video de entrada" << endl;
    cout << "  Opciones:" << endl;
    cout << "    -h          Muestra este texto de ayuda" << endl;
    cout << "    -t          Calcula e imprime en pantalla el tiempo insumido por la ejecu-" << endl;
    cout << "                  ción del método" << endl;
    cout << "    -c          Calcula e imprime en pantalla la cantidad de iteraciones del" << endl;
    cout << "                  algoritmo elegido que fueron ejecutadas" << endl;
}

void parsear_argumentos(conf& args, char* argv[]) {
    args.ifile = argv[1];
    args.ofile = argv[2];
    INTENTAR_PARSEO(args.alg = stoi(argv[3]);, <algoritmo>)
    INTENTAR_PARSEO(args.cant_cuadros = stod(argv[4]);, <cant_cuadros>)
}
