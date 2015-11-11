

filetype='-dpdf'; %CAMBIAR A PDF
mkdir('graficos');
figure;

cantVideos = 2;
cantBloques = [2, 4, 6, 8, 10, 12, 14, 50, 80, 100, 130, 170]; 


for h = 1:cantVideos
	for k = cantBloques
		textFileName0 = ['exp3/ecm/exp3-' num2str(h) '-' num2str(k) '-errorCuadMedio.txt'];
		[ecm, frames, e, cant] = leer_datos_float(textFileName0);
		clf;
		hold on;
		grid on;
		axis([frames(1),frames(length(frames))]);%esto es para que el eje x sea del tamaño de la cantidad de datos y no haya bordes blancos ocupando espacio
		stem(frames, ecm, 'LineStyle', 'none', 'Marker', 'o', 'MarkerEdgeColor', 'red');
		xlabel('Frame','FontSize',12);
		ylabel('Diferencia entre metodo Spline con y sin bloques (error cuadratico medio)','FontSize',10);
		hold off;
		textFileName1 = ['graficos/exp3-' num2str(h) '-' num2str(k) '-dif'];
		print(textFileName1, filetype);
	end
end