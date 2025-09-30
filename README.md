# A-Test-Strategy-for-a-Current-Source-Designed-for-Fast-Field-Cycling-Nuclear-Magnetic-Resonance
IEEE Latin America Transactions - ID 9952
Delfina Vélez Ibarra, Gonzalo Vodanovic, Agustín Laprovitta, Gabriela Peretti, Eduardo Romero, and Esteban Anoardo

This repository contains the necessary files to reproduce the results reported in the journal article.
* The "ModeloOrcad_circuitoCompleto" folder includes the SPICE simulation model of the complete circuit.
* For the fault analysis in the low-power section (CUTlp), the following are included:
  - The "csvFallasCatastroficasOBT" and "csvFallasDesviacionOBT" folders, which contain the results of the fault injection and simulation process in the oscillator circuit (OCs and SCs in the first, and deviations of +/-30% and +/-50% in the second).
  - The "AnalisisFallasOBT" Matlab script, which was used to analyze the amplitude and frequency of the simulated curves.
  - The "AnalisisFC_CUTlp" spreadsheet, which presents the fault coverage analysis combining OBT and DC testing.
* For the fault analysis in the high-power section (CUThp), the following are included:
  - The results of the injection and simulation process of all faults in the CUThp ("CurvasFallasCUThpSimuladas").
  - The results of the experimental injection process in the CUThp of the faults with responses very similar to the fault-free one ("CurvasFallasCUThpExperimentales").
  - The "AnalisisFallasCUThp_Matlab" folder, where the fault coverage in the CUThp is analyzed using DTW.
________________________________________________________________________________________________________________________________________________

Este repositorio posee los archivos necesarios para reproducir los resultados reportados en el artículo de la revista.
* La carpeta "ModeloOrcad_circuitoCompleto" incluye el modelo de simulación SPICE del circuito completo.
* Para el análisis de fallas en la sección de baja potencia (CUTlp) se incluyen:
  - Las carpetas "csvFallasCatastroficasOBT" y "csvFallasDesviacionOBT" que contienen los resultados del proceso de inyección y simulación de fallas en el circuito oscilador (OCs y SCs en la primera, y desviaciones de +/-30% y +/-50% en la segunda).
  - El script de Matlab "AnalisisFallasOBT" que se utilizó para analizar la amplitud y frecuencia de las curvas simuladas.
  - La hoja de cálculo "AnalisisFC_CUTlp" donde se presenta el análisis de cobertura de fallas combinando OBT y test de DC.
* Para el análisis de fallas en la sección de alta potencia (CUThp) se incluyen:
  - Los resultados del proceso de inyección y simulación de todas las fallas en el CUThp ("CurvasFallasCUThpSimuladas").
  - Los resultados del proceso de inyección experimental en el CUThp de las fallas con respuestas muy similares a la sin-fallas ("CurvasFallasCUThpExperimentales").
  - La carpeta "AnalisisFallasCUThp_Matlab" donde se analiza la cobertura de fallas en el CUThp usando DTW.
