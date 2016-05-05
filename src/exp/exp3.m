%Experimento 3 - Error Cuadratico Medio - Método Splines, con y sin bloques

cantVideos = 2;
cantBloques = [2, 4, 6, 8, 10, 12, 14, 50, 80, 100, 130, 170]; 
labels = [0, 2, 4, 6, 8, 10, 12, 14, 50, 80, 100, 130, 170, 255];

filetype='-dpdf'; %CAMBIAR A PDF
mkdir('graficos');
figure;

for h = 1:cantVideos
	% textFileName0 = ['exp3/exp3-' num2str(h) '-sinBloques-errorCuadMedio.txt'];
	% [ecm_sinBloques, frames_sinBloques, e_sinBloques, cant_sinBloques] = leer_datos_float(textFileName0);
	% for k = cantBloques
	% 	textFileName1 = ['exp3/exp3-' num2str(h) '-' num2str(k) '-errorCuadMedio.txt'];
	% 	[ecm, frames, e, cant] = leer_datos_float(textFileName1); 
		
	% 	titulo = ['Video ' num2str(h) '- ' num2str(k) ' bloques'];


	% 	%Grafica errores por frame, para cada video, y para cada algoritmo
	% 	clf;
	% 	hold on;
	% 		axis([frames(1),frames(length(frames))]); %esto es para que el eje x sea del tamaño de la cantidad de datos y no haya bordes blancos ocupando espacio
	% 		stem(frames, ecm_dif, 'LineStyle', 'none', 'Marker', 'o', 'MarkerEdgeColor', 'red');
	% 		%stem(frames_sinBloques, ecm_sinBloques, 'LineStyle', 'none', 'Marker', 'x', 'MarkerEdgeColor', 'green');
	% 		title(titulo, 'FontSize', 16);
	% 		xlabel('Frame','FontSize',12);
	% 		ylabel('Error Cuadratico Medio','FontSize',10);
	% 	hold off;
	% 	textFileName2 = ['graficos/exp3-' num2str(h) '-' num2str(k)];
	% 	print(textFileName2, filetype);
	%end
	%Grafica errores por video
	textFileName3 = ['exp3/exp3-' num2str(h) '-erroresTotales.txt']; 
	[bloques, ecm_total, e_total, cant_total] = leer_datos_float(textFileName3); 
	clf;
	hold on;
		title(['Video ' num2str(h)], 'FontSize', 16);
		if h==1
			axis([0,length(labels),95,105]); %esto es para que el eje y sea del tamaño de la cantidad de datos y no haya bordes blancos ocupando espacio
		else
			axis([0,length(labels),215,225]); %esto es para que el eje y sea del tamaño de la cantidad de datos y no haya bordes blancos ocupando espacio
		end
		bar(ecm_total, 'b');
		xlabel('Tamano de Bloque','FontSize',12);
		ylabel('Error Cuadratico Medio','FontSize',10);
		set(gca, 'XTick', 0:length(labels)); % Esto es para que los unicos labels que haya en el eje x sean los algoritmos (saca 0.5, etc)
		set(gca, 'XTickLabel', labels); 
	hold off;
	textFileName4 = ['graficos/exp3-' num2str(h)];
	print(textFileName4, filetype);

	%Grafica tiempos por video
	textFileName5 = ['exp3/exp3-' num2str(h) '-tiempo.txt'];
	[bloques_tiempo, tiempos, e_tiempos, cant_tiempos] = leer_datos_float(textFileName5);

	clf;
	hold on;
		axis([bloques_tiempo(1),bloques_tiempo(length(bloques_tiempo))]);%esto es para que el eje x sea del tamaño de la cantidad de datos y no haya bordes blancos ocupando espacio
		title(['Video ' num2str(h)], 'FontSize', 16);
		errorbar(bloques_tiempo, tiempos, e_tiempos, '-b');
		xlabel('Tamano Bloques','FontSize',12);
		ylabel('Tiempo de ejecucion en ticks de clock','FontSize',10);
	hold off;
	textFileName6 = ['graficos/exp3-' num2str(h) '-tiempos'];
	print(textFileName6, filetype);

end

