% Análisis de detección de fallas medidas en laboratorio a partir de las
% curvas sin fallas adquiridas con promedio de 128, usando DTW.
% Delfina Vélez


clear
clc
close all

Numnp=30; % Curvas de entrenamiento
fallas = [7 9 10 12 13 14 16 20 21 26];
NumFallas = length(fallas);
NumNominales = 7; % Curvas sin fallas (f0)
NumTramos = 3;

% ANTES DE CORRER, CONFIGURAR LOS VALORES DE ERROR ADMITIDOS:
errorDTW = 25; % Porcentaje de error admitido en la definición de las máximas distancias DTW

PasosOsciloscopio = 0;
errorO_Vmax = PasosOsciloscopio*19.6e-3; % Paso de conversión del osciloscopio en el canal medido
errorO_Vg = PasosOsciloscopio*39.2e-3; % Paso de conversión del osciloscopio en el canal medido
errorO_Vd = PasosOsciloscopio*78.4e-3; % Paso de conversión del osciloscopio en el canal medido

%% Lectura de archivos
% Curvas sin fallas experimentales
np = cell(1,Numnp);
for k = 1:Numnp        
    name = sprintf ('np%d.csv', k);   
    np{k} = importfile(name,1,2500); %configurar filas para filtrar la primera fila    
end

% Curvas con fallas experimentales
f = cell(1,NumFallas);
for k = 1:NumFallas    
    i=fallas(k);
    name = sprintf ('f%d.csv', i);   
    f{k} = importfile(name,1,2500); %configurar filas para filtrar la primera fila    
end

% Curvas con fallas experimentales (adquiridas en otra fecha)
nom = cell(1,NumNominales);
for k = 1:NumNominales        
    name = sprintf ('f0_%d.csv', k);   
    nom{k} = importfile(name,1,2500); %configurar filas para filtrar la primera fila    
end

%% Promedio de curvas sin fallas (np)
% Vmax
Vmaxp_avg = 0;
for k = 1:Numnp        
    Vmaxp_avg = Vmaxp_avg + np{1,k}(:,3);   
end
Vmaxp_avg = Vmaxp_avg/Numnp;

% Vg
Vgp_avg = 0;
for k = 1:Numnp        
    Vgp_avg = Vgp_avg + np{1,k}(:,4);   
end
Vgp_avg = Vgp_avg/Numnp;

% Vd
Vdp_avg = 0;
for k = 1:Numnp        
    Vdp_avg = Vdp_avg + np{1,k}(:,5);   
end
Vdp_avg = Vdp_avg/Numnp;


figure
hold on
plot (np{1,1}(:,1), Vmaxp_avg,'*')
for k = 1:NumNominales  
    plot (nom{1,k}(:,1), nom{1,k}(:,3))
end
legend ('nom','1','2','3', '4', '5', '6', '7')
hold off


%% Análisis por tramos
% Index de datos: 0-500: Antes de 0s
                % 501-1000: Transitorio ON hasta 50us
                % 1001 - 1500: Estado estable
                % 1501 - 2000: Transitorio OFF hasta 150us
                
% Definición de tramos:
Tini = [501 1001 1501];
Tfin = [1000 1500 2000];

% Promedios por tramo:
% Vmax
Vmaxp_avg = [Vmaxp_avg(Tini(1):Tfin(1)) Vmaxp_avg(Tini(2):Tfin(2)) Vmaxp_avg(Tini(3):Tfin(3))];

% Vg
Vgp_avg = [Vgp_avg(Tini(1):Tfin(1)) Vgp_avg(Tini(2):Tfin(2)) Vgp_avg(Tini(3):Tfin(3))];

% Vd
Vdp_avg = [Vdp_avg(Tini(1):Tfin(1)) Vdp_avg(Tini(2):Tfin(2)) Vdp_avg(Tini(3):Tfin(3))];

%% Curvas por tramos
% Curvas nominales por tramos:
npTr = cell(NumTramos,Numnp);
for j = 1:Numnp
    for k = 1:NumTramos      
        npTr{k,j}= np{1,j}(Tini(k):Tfin(k),3:5);   
    end
end

% Curvas sin fallas por tramos:
nomTr = cell(NumTramos,NumNominales);
for j = 1:NumNominales
    for k = 1:NumTramos      
        nomTr{k,j}= nom{1,j}(Tini(k):Tfin(k),3:5);   
    end
end

fTr = cell(NumTramos,NumFallas);
for j = 1:NumFallas
    for k = 1:NumTramos      
        fTr{k,j}= f{1,j}(Tini(k):Tfin(k),3:5);   
    end
end


%% DISTANCIA DTW %%
metric = 'squared';
% Cálculo de distancias DTW en np
% Vmax   
Vmaxp_distDTW = cell(NumTramos,Numnp);
for j = 1:Numnp
    for k = 1:NumTramos      
        Vmaxp_distDTW{k,j}= dtw(Vmaxp_avg(:,k),npTr{k,j}(:,1),metric);   
    end
end

% Vg       
Vgp_distDTW = cell(NumTramos,Numnp);
for j = 1:Numnp
    for k = 1:NumTramos      
        Vgp_distDTW{k,j}= dtw(Vgp_avg(:,k),npTr{k,j}(:,2),metric);   
    end
end

% Vd      
Vdp_distDTW = cell(NumTramos,Numnp);
for j = 1:Numnp
    for k = 1:NumTramos      
        Vdp_distDTW{k,j}= dtw(Vdp_avg(:,k),npTr{k,j}(:,3),metric);   
    end
end

% Cálculo de distancia DTW en curvas con fallas
% Cálculo de distancias en curvas con fallas (fTr)
VmaxFallas_DTW = cell(NumTramos,NumFallas);
for j = 1:NumFallas
    for k = 1:NumTramos      
        VmaxFallas_DTW{k,j}= dtw(Vmaxp_avg(:,k),fTr{k,j}(:,1),metric);   
    end
end

% Vg      
VgFallas_DTW = cell(NumTramos,NumFallas);
for j = 1:NumFallas
    for k = 1:NumTramos      
        VgFallas_DTW{k,j}= dtw(Vgp_avg(:,k),fTr{k,j}(:,2),metric);   
    end
end

% Vd      
VdFallas_DTW = cell(NumTramos,NumFallas);
for j = 1:NumFallas
    for k = 1:NumTramos      
        VdFallas_DTW{k,j}= dtw(Vdp_avg(:,k),fTr{k,j}(:,3),metric);   
    end
end

% Cálculo de distancias en curvas sin fallas (nomTr)
%Vmax
Vmaxf0_DTW = cell(NumTramos,NumNominales);
for j = 1:NumNominales
    for k = 1:NumTramos      
        Vmaxf0_DTW{k,j}= dtw(Vmaxp_avg(:,k),nomTr{k,j}(:,1),metric);   
    end
end

% Vg      
Vgf0_DTW = cell(NumTramos,NumNominales);
for j = 1:NumNominales
    for k = 1:NumTramos      
        Vgf0_DTW{k,j}= dtw(Vgp_avg(:,k),nomTr{k,j}(:,2),metric);   
    end
end

% Vd      
Vdf0_DTW = cell(NumTramos,NumNominales);
for j = 1:NumNominales
    for k = 1:NumTramos      
        Vdf0_DTW{k,j}= dtw(Vdp_avg(:,k),nomTr{k,j}(:,3),metric);   
    end
end

%% DETECCIÓN DE FALLAS USANDO CURVAS POR TRAMOS %%
% Vmax MAXIMOS
VmaxDTWmax = [max(cell2mat(Vmaxp_distDTW(1,:))); max(cell2mat(Vmaxp_distDTW(2,:))); max(cell2mat(Vmaxp_distDTW(3,:)))];
VmaxDTWmax = VmaxDTWmax + (errorDTW*VmaxDTWmax/100);

% Vg MAXIMOS
VgDTWmax = [max(cell2mat(Vgp_distDTW(1,:))); max(cell2mat(Vgp_distDTW(2,:))); max(cell2mat(Vgp_distDTW(3,:)))];
VgDTWmax = VgDTWmax + (errorDTW*VgDTWmax/100);

% Vd MAXIMOS
VdDTWmax = [max(cell2mat(Vdp_distDTW(1,:))); max(cell2mat(Vdp_distDTW(2,:))); max(cell2mat(Vdp_distDTW(3,:)))];
VdDTWmax = VdDTWmax + (errorDTW*VdDTWmax/100);

TablaLimitesDTW = [VmaxDTWmax; VgDTWmax; VdDTWmax];
%% Análisis de curvas con fallas
% Fallas en Vmax
VmaxfallasDetectadas = cell(NumTramos,NumFallas);
for j = 1:NumFallas
    for k = 1:NumTramos       
        aux = cell2mat(VmaxFallas_DTW(k,j));
        if (aux > VmaxDTWmax(k,1))
            VmaxfallasDetectadas{k,j}= 1;
        else
            VmaxfallasDetectadas{k,j}= 0;
        end
    end
end

% Fallas en Vg
VgfallasDetectadas = cell(NumTramos,NumFallas);
for j = 1:NumFallas
    for k = 1:NumTramos 
        aux = cell2mat(VgFallas_DTW(k,j));   
        if (aux > VgDTWmax(k,1))
            VgfallasDetectadas{k,j}= 1;
        else
            VgfallasDetectadas{k,j}= 0;
        end
    end
end

% Fallas en Vd
VdfallasDetectadas = cell(NumTramos,NumFallas);
for j = 1:NumFallas
    for k = 1:NumTramos 
        aux = cell2mat(VdFallas_DTW(k,j));        
        if (aux > VdDTWmax(k,1))
            VdfallasDetectadas{k,j}= 1;
        else
            VdfallasDetectadas{k,j}= 0;
        end
    end
end
 
% Tabla de cobertura de fallas
% 1° fila: Fallas= 7 9 10 12 13 14 16 20 21 26
% 1° columna: Parámetro analizado= Vmax Vg Vd
TablaCoberturaFallasDTW = [VmaxfallasDetectadas; VgfallasDetectadas; VdfallasDetectadas];

%% Análisis de curvas sin fallas
% Sin fallas en Vmax
Vmaxf0Detectadas = cell(NumTramos,NumNominales);
for j = 1:NumNominales
    for k = 1:NumTramos 
        aux = cell2mat(Vmaxf0_DTW(k,j));
        if (aux > VmaxDTWmax(k,1))
            Vmaxf0Detectadas{k,j}= 1;
        else
            Vmaxf0Detectadas{k,j}= 0;
        end
    end
end

% Sin fallas en Vg
Vgf0Detectadas = cell(NumTramos,NumNominales);
for j = 1:NumNominales
    for k = 1:NumTramos 
        aux = cell2mat(Vgf0_DTW(k,j));        
        if (aux > VgDTWmax(k,1))
            Vgf0Detectadas{k,j}= 1;
        else
            Vgf0Detectadas{k,j}= 0;
        end
    end
end

% Sin fallas en Vd
Vdf0Detectadas = cell(NumTramos,NumNominales);
for j = 1:NumNominales
    for k = 1:NumTramos 
        aux = cell2mat(Vdf0_DTW(k,j));        
        if (aux > VdDTWmax(k,1))
            Vdf0Detectadas{k,j}= 1;
        else
            Vdf0Detectadas{k,j}= 0;
        end
    end
end

% Tabla de cobertura de curvas sin fallas
% 1° fila: n° de curva sin fallas (1: NumNominales)
% 1° columna: Parámetro analizado= Vmax Vg Vd
TablaCoberturaSinFallasDTW = [Vmaxf0Detectadas; Vgf0Detectadas; Vdf0Detectadas];