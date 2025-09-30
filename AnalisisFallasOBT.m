% Script para tomar las curvas del análisis para OBT de Orcad 
% y realizar un histograma de amplitud y otro de frecuencia.
% Delfina Vélez

clc
clear
close all

% Cargar el archivo de Orcad en Matlab (a partir de la fila 500)
M = csvread('csvOrcadDesviacionOBT/CpolDesv.csv',500,0); %configurar filas para filtrar el primer ciclo

[filas,columnas] = size (M);      

% Análisis de cada curva:
 for i=2:columnas
    [pks,locs] = findpeaks(M(:,i),M(:,1)); % Carga en pks la amplitud
    % de los máximos locales y en locs el correspondiente valor en x.
    % Requiere pasar el arreglo de tiempo como parámetro.
    AmplitudPositivaPromedio(i-1) = mean(pks);

    [pksNeg,locsNeg] = findpeaks(-M(:,i),M(:,1)); % Análisis de los
    % mínimos locales (invirtiendo la curva)

    AmplitudNegativaPromedio(i-1) = mean(-pksNeg);

    AmplitudPicoPico(i-1) = mean(pks) + mean(pksNeg);

    Periodos = locs(2:1:length(locs))- locs(1:1:(length(locs)-1)); % Distancia entre
    % 2 máximos consecutivos
    PeriodoPromedio = mean(Periodos);
    FrecuenciaPromedio(i-1) = 1/PeriodoPromedio;
     

    % Análisis de los datos por curva
    resultados = [transpose(AmplitudPositivaPromedio) transpose(AmplitudNegativaPromedio) transpose(AmplitudPicoPico) transpose(FrecuenciaPromedio)];
end
acumulado=0;
resultadosOrdenados = zeros(6,20);
for k=1:6
    resultadosOrdenados(k,:) = [(resultados ((acumulado+1),:)) (resultados ((acumulado+7),:)) (resultados ((acumulado+13),:)) (resultados ((acumulado+19),:)) (resultados ((acumulado+25),:)) ];
    acumulado = acumulado + 1;
end

% Graficar última curva y picos:
    figure ('Name', 'Última curva, con máximos y mínimos')
    hold on
    plot (M(:,1), M(:,i))
    plot (locs,pks,'*')
    plot (locsNeg,-pksNeg,'o')
    hold off 
