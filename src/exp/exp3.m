%Experimento 3 - Error Cuadratico Medio - Método Splines, con y sin bloques

cantVideos = 2
cantBloques = [2, 4, 6, 8, 10, 12, 14, 170]; 

filetype='-dpdf';
mkdir('graficos');
figure;

for h = 1:cantVideos
	for k = cantBloques
		textFileName1 = ['exp3/exp3-' num2str(h) '-' num2str(k) '-errorCuadMedio.txt'];
		[frames, ecm, e, cant] = leer_datos(textFileName1); 

		%Grafica errores por frame, para cada video, y para cada algoritmo
		clf;
		hold on;
		stem(frames, ecm, 'LineStyle', 'none', 'MarkerEdgeColor', 'red', 'MarkerFaceColor', 'red');
		xlabel('Frame','FontSize',12);
		ylabel('Error Cuadratico Medio','FontSize',10);
		hold off;
		textFileName2 = ['graficos/exp3-' num2str(h) '-' num2str(k)];
		print(textFileName2, filetype);
	end

	%Grafica errores por video
	textFileName3 = ['exp3/exp3-' num2str(h) '-erroresTotales.txt']; 
	[bloques, ecm_total, e_total, cant_total] = leer_datos(textFileName1); 
	clf;
	hold on;
	bar(bloques, ecm_total, 0.5, 'b');
	xlabel('Tamano de Bloque','FontSize',12);
	ylabel('Error Cuadratico Medio','FontSize',10);
	hold off;
	textFileName4 = ['graficos/exp3-' num2str(h)];
	print(textFileName4, filetype);
end

