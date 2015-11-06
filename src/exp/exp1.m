% Procesado de los datos
[algoritmos_x, tiempos_y, e, cant] = leer_datos('exp1/exp1-data.txt');

%promedio = tiempos_y ./ e ;

% Creación de los gráficos
filetype='-dpng';
mkdir('graficos');
figure;

hold on;
bar(tiempos_y, 0.5);
xlabel('Algoritmo','FontSize',12);
ylabel('Tiempo de ejecucion en ciclos de clock normalizado por cantidad de iteraciones','FontSize',10);
hold off;
print('graficos/exp1', filetype);