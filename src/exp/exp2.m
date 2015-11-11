%Experimento 2 - Error Cuadratico Medio - Comparación de los 3 métodos

cantVideos = 3;
cantAlgoritmos = 2; % (cantidad algoritmos - 1) Esto sirve para el ciclo, ya que los archivos se enumeran desde el 0
labels = 0:cantAlgoritmos;

filetype='-dpdf';
mkdir('graficos');
figure;

for h = 1:cantVideos
	clf;
	for k = 0:cantAlgoritmos
		textFileName1 = ['exp2/exp2-' num2str(h) '-' num2str(k) '-errorCuadMedio.txt'];
		[ecm, frames, e, cant] = leer_datos_float(textFileName1); 

		%Grafica errores por frame, para cada video, y para cada algoritmo
		hold on;
		grid on;
		axis([frames(1),frames(length(frames))]);%esto es para que el eje x sea del tamaño de la cantidad de datos y no haya bordes blancos ocupando espacio
		if k == 0
			stem(frames, ecm, 'LineStyle', 'none', 'Marker', 'o', 'MarkerEdgeColor', 'red');
		elseif k == 1
			stem(frames, ecm, 'LineStyle', 'none', 'Marker', 'x', 'MarkerEdgeColor', 'green');
		else
			stem(frames, ecm, 'LineStyle', 'none', 'Marker', 'd', 'MarkerEdgeColor', 'blue');
		end
		if h == 2
			legend('Vecino mas cercano','Lineal','Spline','Location','northwest');
		else
			legend('Vecino mas cercano','Lineal','Spline','Location','northeast');
		end
		xlabel('Frame','FontSize',12);
		ylabel('Error Cuadratico Medio','FontSize',12);
		textFileName2 = ['graficos/exp2-' num2str(h)];
		print(textFileName2, filetype);
	end
	hold off;

	%Grafica errores por video
	textFileName3 = ['exp2/exp2-' num2str(h) '-erroresTotales.txt']; 
	[algoritmos, ecm_total, e_total, cant_total] = leer_datos_float(textFileName3); 
	clf;
	hold on;
	bar(algoritmos, ecm_total, 0.5, 'b');
	xlabel('Algoritmo ','FontSize',12);
	ylabel('Error Cuadratico Medio','FontSize',12);
	set(gca, 'XTick', 0:length(labels)); % Esto es para que los unicos labels que haya en el eje x sean los algoritmos (saca 0.5, etc)
	set(gca, 'XTickLabel', labels); 
	hold off;
	textFileName4 = ['graficos/exp2-' num2str(h) '-erroresTotales'];
	print(textFileName4, filetype);
end

