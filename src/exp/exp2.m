%Experimento 2 - Error Cuadratico Medio - Comparación de los 3 métodos

cantVideos = 3;
cantAlgoritmos = 0; % (cantidad algoritmos - 1) Esto sirve para el ciclo, ya que los archivos se enumeran desde el 0

filetype='-dpdf';
mkdir('graficos');
figure;

for h = 1:cantVideos
	for k = 0:cantAlgoritmos
		textFileName1 = ['exp2/exp2-' num2str(h) '-' num2str(k) '-errorCuadMedio.txt'];
		[frames, ecm, e, cant] = leer_datos(textFileName1); 

		%Grafica errores por frame, para cada video, y para cada algoritmo
		clf;
		hold on;
		stem(frames, ecm, 'LineStyle', 'none', 'MarkerEdgeColor', 'red', 'MarkerFaceColor', 'red');
		xlabel('Frame','FontSize',12);
		ylabel('Error Cuadratico Medio','FontSize',10);
		hold off;
		textFileName2 = ['graficos/exp2-' num2str(h) '-' num2str(k)];
		print(textFileName2, filetype);
	end

	%Grafica errores por video
	textFileName3 = ['exp2/exp2-' num2str(h) '-erroresTotales.txt']; 
	[algoritmos, ecm_total, e_total, cant_total] = leer_datos(textFileName1); 
	clf;
	hold on;
	bar(algoritmos, ecm_total, 0.5, 'b');
	xlabel('Algoritmo','FontSize',12);
	ylabel('Error Cuadratico Medio','FontSize',10);
	hold off;
	textFileName4 = ['graficos/exp2-' num2str(h)];
	print(textFileName4, filetype);
end

