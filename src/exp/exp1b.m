% Procesado de los datos
[tam_x_a, tiempos_y_a, e_a, cant_a] = leer_datos('exp1/exp1-b-0.txt');
[tam_x_b, tiempos_y_b, e_b, cant_b] = leer_datos('exp1/exp1-b-1.txt');
[tam_x_c, tiempos_y_c, e_c, cant_c] = leer_datos('exp1/exp1-b-2.txt');


% Creación de los gráficos
filetype='-dpdf';
mkdir('graficos');
figure;

hold on;
axis([tam_x_a(length(tam_x_a)),tam_x_a(1)]);%esto es para que el eje x sea del tamaño de la cantidad de datos y no haya bordes blancos ocupando espacio
h = errorbar(tam_x_a, tiempos_y_a, e_a, '-r');
errorbar(tam_x_b, tiempos_y_b, e_b, '-g');
errorbar(tam_x_c, tiempos_y_c, e_c, '-b');
xlabel('Tamano de cuadro en pixeles','FontSize',12);
ylabel('Tiempo de ejecucion en ticks de clock','FontSize',10);
legend('Vecino mas cercano','Lineal','Spline','Location','northwest');
set(get(h, 'Parent'), 'YScale', 'log');
hold off;
print('graficos/exp1b', filetype);