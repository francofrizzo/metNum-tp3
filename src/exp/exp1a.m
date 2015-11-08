% Procesado de los datos
[duracion_x_a, tiempos_y_a, e_a, cant_a] = leer_datos('exp1/exp1-a-0.txt');
[duracion_x_b, tiempos_y_b, e_b, cant_b] = leer_datos('exp1/exp1-a-1.txt');
[duracion_x_c, tiempos_y_c, e_c, cant_c] = leer_datos('exp1/exp1-a-2.txt');


% Creación de los gráficos
filetype='-dpng';
mkdir('graficos');
figure;

hold on;
errorbar(duracion_x_a, tiempos_y_a, e_a, '-r');
errorbar(duracion_x_b, tiempos_y_b, e_b, '-g');
errorbar(duracion_x_c, tiempos_y_c, e_c, '-b');
xlabel('Tiempo de duracion del video','FontSize',12);
ylabel('Tiempo de ejecucion en ciclos de clock','FontSize',10);
legend('Vecino mas cercano','Lineal','Spline','Location','northwest');
hold off;
print('graficos/exp1a', filetype);


