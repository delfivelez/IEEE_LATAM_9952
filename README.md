# A Test Strategy for a Current Source Designed for Fast Field Cycling Nuclear Magnetic Resonance

**IEEE Latin America Transactions - ID 9952**

**Authors**
* Delfina Vélez Ibarra
* Gonzalo Vodanovic
* Agustín Laprovitta
* Gabriela Peretti
* Eduardo Romero
* Esteban Anoardo

**Affiliations**
* Facultad de Matemática, Astronomía, Física y Computación, Universidad Nacional de Córdoba, Córdoba, Argentina.
* Facultad Regional Villa María, Universidad Tecnológica Nacional, Córdoba, Argentina.
* Instituto de Física Enrique Gaviola, CONICET, Córdoba, Argentina.

**Contact**
For any questions regarding the paper or the replication of its results, please contact Delfina Vélez Ibarra at delfinavelez@unc.edu.ar


**Repository Contents**
This repository contains the necessary files to reproduce the results reported in the journal article, and is organized into the following sections, corresponding to the different analyses performed in the study.

***1. SPICE simulation model of the complete circuit***
* SPICE_Model_FullCircuit/: This folder contains the complete OrCAD/PSpice simulation model of the current source circuit.
  
***2. Fault analysis in the low-power section (CUT_LP)***
This section (FaultAnalysis_CUT_LP/) contains the files related to the Oscillation-Based Test (OBT) and DC test for the CUT_LP. 
* OBT_Catastrophic_Faults/: Contains the CSV files from the simulation of catastrophic faults (open-circuits and short-circuits) in the OBT configuration.
* OBT_Parametric_Faults/: Contains the CSV files from the simulation of parametric faults (deviations of +/-30% and +/-50%) in the OBT configuration.
* analyze_OBT_faults.m: MATLAB script used to process the CSV files. It extracts the amplitude and frequency of the oscillation for each simulated fault.
* CUT_LP_FCAnalysis.xlsx: An Excel spreadsheet that summarizes:
    - The results from the analyze_OBT_faults.m script.
    - The results from the DC test simulation (DCout values).
    - The final fault coverage analysis for the CUT_LP, combining both OBT and DC testing methods.

  ***3. Fault analysis in the high-power section (CUT_HP):***
  This section (FaultAnalysis_CUT_HP/) contains the simulation data, experimental data, and analysis scripts for the CUT_HP faults.
* CUT_HP_Simulated_Faults/: Contains the results from the simulation of all modeled faults in the CUT_HP.
* CUT_HP_Experimental_Faults/: Contains the experimental data acquired from the hardware prototype for a subset of injected faults whose response was similar to the fault-free case.
* CUT_HP_FCAnalysis/: This folder contains:
    - detect_CUThp_faults_experimental.m: The main MATLAB script that analyzes the experimental data using Dynamic Time Warping (DTW) to calculate the fault coverage. This script generates the results presented in Table IV of the paper.
    - Experimental data, including the fault-free signals used as a reference.