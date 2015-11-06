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
void parsear_argumentos(conf&, char**, int);
void imprimir_tiempo(clock_t);

conf args;

int main(int argc, char* argv[]) {
    ifstream ifile;
    ofstream ofile;
    // int cant_nodos;
    // int cant_aristas;

    // Parseo de opciones especiales
    char opt;
    while ((opt = getopt(argc, argv, "htcb:")) != -1) {
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
            case 'b': { // realiza por bloques la interpolación por splines
                args.bloques_flag = true;
                INTENTAR_PARSEO(args.tamano_bloque = stoi(optarg);, <tam> de la opción -b);
                if (args.tamano_bloque <= 0) {
                    cout << "El parámetro <tam> de la opción -b debe ser un número positivo" << endl;
                    exit(1);
                }
                break;
            }
            default: { // si las opciones son inválidas
                mostrar_ayuda(argv[0]);
                exit(1);
                break;
            }
        }
    }

    // Parseo de argumentos
    if (argc > 4) {
        parsear_argumentos(args, argv, argc);
    } else {
        // En caso de faltar argumentos, mostrar ayuda y salir
        mostrar_ayuda(argv[0]);
        exit(1);
    }

    // Apertura de archivos de entrada y salida
    ifile.open(args.ifile, ios_base::in);  // archivo de entrada
    if (! ifile.good()) {
        cout << "Error al abrir el archivo de entrada" << endl;
        exit(1);
    }

    ofile.open(args.ofile, ios_base::out);  // archivo de salida
    if (! ofile.good()) {
        cout << "Error al abrir el archivo de salida" << endl;
        exit(1);
    }

    // Reviso que el algoritmo solicitado sea válido
    if (! ES_ALG_VALIDO(args.alg)) {
        cout << "Error: El algoritmo solicitado no es válido" << endl;
        exit(1);
    }

    // Parseo del archivo de entrada
    int c, nuevo_c, height, width, f;
    string line;
    
    getline(ifile, line);
    c = stoi(line);
    getline(ifile, line, ',');
    height = stoi(line);
    getline(ifile, line);
    width = stoi(line);
    getline(ifile, line);
    f = stoi(line);

    vector<vector<vector<int> > > ivideo(height, vector<vector<int> >(width, vector<int>()));
    vector<vector<vector<int> > > ovideo(height, vector<vector<int> >(width, vector<int>()));

    for (int t = 0; t < c; t++) {
        for (int i = 0; i < height; i++) {
            for (int j = 0; j < width - 1; j++) {
                getline(ifile, line, ',');
                ivideo[i][j].push_back(stoi(line));
            }
            getline(ifile, line);
            ivideo[i][width - 1].push_back(stoi(line));
        }
    }

    // Ejecucion del algoritmo
    MEDIR_TIEMPO_INICIO(args.timer);
    
    for (int i = 0; i < height; i++) {
        for (int j = 0; j < width; j++) {
            vector<int> ipixel = ivideo[i][j];
            vector<int> opixel;
            switch (args.alg) {
                case ALG_VECINO: {
                    opixel = interpolar_vecino(ipixel, args.cant_cuadros);
                    break;
                }
                case ALG_LINEAL: {
                    opixel = interpolar_lineal(ipixel, args.cant_cuadros);
                    break;
                }
                case ALG_SPLINE: {
                    if (args.bloques_flag) {
                        opixel = interpolar_spline_bloques(ipixel, args.cant_cuadros, args.tamano_bloque);
                    } else {
                        opixel = interpolar_spline(ipixel, args.cant_cuadros);
                    }
                    break;
                }
            }
            ovideo[i][j] = opixel;
        }
    }
    
    MEDIR_TIEMPO_FIN(args.timer);

    // Escritura en archivo de salida
    nuevo_c = c + args.cant_cuadros * (c - 1);

    ofile << nuevo_c << endl;
    ofile << height << "," << width << endl;
    ofile << f << endl;

    for (int t = 0; t < nuevo_c; t++) {
        for (int i = 0; i < height; i++) {
            for (int j = 0; j < width - 1; j++) {
                ofile << ovideo[i][j][t] << ",";
            }
            ofile << ovideo[i][width - 1][t] << endl;
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
    cout << "    -b <tam>    Si la interpolación se realiza usando splines, aplica el algo-" << endl;
    cout << "                  ritmo de a bloques con el tamaño indicado por parámetro" << endl;
}

void parsear_argumentos(conf& args, char* argv[], int argc) {
    args.ifile = argv[argc - 4];
    args.ofile = argv[argc - 3];
    INTENTAR_PARSEO(args.alg = stoi(argv[argc - 2]);, <algoritmo>)
    INTENTAR_PARSEO(args.cant_cuadros = stod(argv[argc - 1]);, <cant_cuadros>)
}
