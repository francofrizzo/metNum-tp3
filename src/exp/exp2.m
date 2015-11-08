%VIDEO 1
% Procesado de los datos
[frames_a_a, ecm_a_a, e_a_a, cant_a_a] = leer_datos('exp2/exp2-1-0-errorCuadMedio.txt');
[frames_a_b, ecm_a_b, e_a_b, cant_a_b] = leer_datos('exp2/exp2-1-1-errorCuadMedio.txt');
[frames_a_c, ecm_a_c, e_a_c, cant_a_c] = leer_datos('exp2/exp2-1-2-errorCuadMedio.txt');


% Creación de los gráficos
filetype='-dpng';
mkdir('graficos');
figure;

%Grafica todo en una misma imagen
% hold on;
% stem(frames_a_a, ecm_a_a, 'LineStyle', 'none', 'MarkerEdgeColor', 'red', 'MarkerFaceColor', 'red');
% stem(frames_a_b, ecm_a_b, 'LineStyle', 'none', 'MarkerEdgeColor', 'green', 'MarkerFaceColor', 'green');
% stem(frames_a_c, ecm_a_c, 'LineStyle', 'none', 'MarkerEdgeColor', 'blue', 'MarkerFaceColor', 'blue');
% xlabel('Frame','FontSize',12);
% ylabel('Error Cuadratico Medio','FontSize',10);
% legend('Vecino mas cercano','Lineal','Spline','Location','northwest');
% hold off;
% print('graficos/exp2a', filetype);


%Grafica todo en 3 imágenes diferentes (una para cada algoritmo)
hold on;
stem(frames_a_a, ecm_a_a, 'LineStyle', 'none', 'MarkerEdgeColor', 'red', 'MarkerFaceColor', 'red');
xlabel('Frame','FontSize',12);
ylabel('Error Cuadratico Medio','FontSize',10);
title('Vecino mas cercano','FontSize',16);
hold off;
print('graficos/exp2-1-0', filetype);

clf;
hold on;
stem(frames_a_b, ecm_a_b, 'LineStyle', 'none', 'MarkerEdgeColor', 'green', 'MarkerFaceColor', 'green');
xlabel('Frame','FontSize',12);
ylabel('Error Cuadratico Medio','FontSize',10);
title('Lineal','FontSize',16);
hold off;
print('graficos/exp2-1-1', filetype);

clf;
hold on;
stem(frames_a_c, ecm_a_c, 'LineStyle', 'none', 'MarkerEdgeColor', 'blue', 'MarkerFaceColor', 'blue');
xlabel('Frame','FontSize',12);
ylabel('Error Cuadratico Medio','FontSize',10);
title('Spline','FontSize',16);
hold off;
print('graficos/exp2-1-2', filetype);



%VIDEO 2
% Procesado de los datos
[frames_b_a, ecm_b_a, e_b_a, cant_b_a] = leer_datos('exp2/exp2-2-0-errorCuadMedio.txt');
[frames_b_b, ecm_b_b, e_b_b, cant_b_b] = leer_datos('exp2/exp2-2-1-errorCuadMedio.txt');
[frames_b_c, ecm_b_c, e_b_c, cant_b_c] = leer_datos('exp2/exp2-2-2-errorCuadMedio.txt');


% Creación de los gráficos
filetype='-dpng';
mkdir('graficos');
figure;

%Grafica todo en una misma imagen
% hold on;
% stem(frames_b_a, ecm_b_a, 'LineStyle', 'none', 'MarkerEdgeColor', 'red', 'MarkerFaceColor', 'red');
% stem(frames_b_b, ecm_b_b, 'LineStyle', 'none', 'MarkerEdgeColor', 'green', 'MarkerFaceColor', 'green');
% stem(frames_b_c, ecm_b_c, 'LineStyle', 'none', 'MarkerEdgeColor', 'blue', 'MarkerFaceColor', 'blue');
% xlabel('Frame','FontSize',12);
% ylabel('Error Cuadratico Medio','FontSize',10);
% legend('Vecino mas cercano','Lineal','Spline','Location','northwest');
% hold off;
% print('graficos/exp2b', filetype);


%Grafica todo en 3 imágenes diferentes (una para cada algoritmo)
hold on;
stem(frames_b_a, ecm_b_a, 'LineStyle', 'none', 'MarkerEdgeColor', 'red', 'MarkerFaceColor', 'red');
xlabel('Frame','FontSize',12);
ylabel('Error Cuadratico Medio','FontSize',10);
title('Vecino mas cercano','FontSize',16);
hold off;
print('graficos/exp2-2-0', filetype);

clf;
hold on;
stem(frames_b_b, ecm_b_b, 'LineStyle', 'none', 'MarkerEdgeColor', 'green', 'MarkerFaceColor', 'green');
xlabel('Frame','FontSize',12);
ylabel('Error Cuadratico Medio','FontSize',10);
title('Lineal','FontSize',16);
hold off;
print('graficos/exp2-2-1', filetype);

clf;
hold on;
stem(frames_b_c, ecm_b_c, 'LineStyle', 'none', 'MarkerEdgeColor', 'blue', 'MarkerFaceColor', 'blue');
xlabel('Frame','FontSize',12);
ylabel('Error Cuadratico Medio','FontSize',10);
title('Spline','FontSize',16);
hold off;
print('graficos/exp2-2-2', filetype);
