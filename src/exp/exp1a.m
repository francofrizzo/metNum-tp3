% Definicion de colores
rojo = [197 66 25] ./ 255;
verde = [81 179 33] ./ 255;
azul = [18 113 156] ./ 255;

% Procesado de los datos
[duracion_x_a, tiempos_y_a, e_a, cant_a] = leer_datos('exp1/exp1-a-0.txt');
[duracion_x_b, tiempos_y_b, e_b, cant_b] = leer_datos('exp1/exp1-a-1.txt');
[duracion_x_c, tiempos_y_c, e_c, cant_c] = leer_datos('exp1/exp1-a-2.txt');

% Creación de los gráficos
filetype='-dpdf';
mkdir('graficos');
h = figure(1);

grid on;

hold on;
hVecino = errorbar(duracion_x_a, tiempos_y_a, e_a, '-r');
hLineal = errorbar(duracion_x_b, tiempos_y_b, e_b, '-g');
hSpline = errorbar(duracion_x_c, tiempos_y_c, e_c, '-b');
hXLabel = xlabel('Tiempo de duracion del video en segundos','FontSize',12);
hYLabel = ylabel('Tiempo de ejecucion en ticks de clock','FontSize',10);
hLegend = legend('Vecino mas cercano','Lineal','Spline','Location','northwest');
%   set(get(hVecino, 'Parent'), 'YScale', 'log');

set([gca; findall(gca, 'Type','text')], 'FontName', 'Carlito');

set(hVecino, 'Color', rojo);
set(hLineal, 'Color', verde);
set(hSpline, 'Color', azul);

yt = get(gca,'YTick');
set(gca,'YTickLabel', sprintf('%d|',yt))

print('graficos/exp1a', filetype);

hold off;
