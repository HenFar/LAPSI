# LAPSI

## Intoduction
This repository goes over the final project conducted as part of the 2024/2025 LAPSI (Laboratorio Avançado de Processamento de 
Sinal e Imagem) course. The project consisted of finding a paper of interest around the concepts discussed in class, selecting 
it, studying it, then reproducing its results and expanding upon them.

## The paper
The paper under study here, and that has also been added in the present repository, has the title "Detection of Ventricular 
Fibrillation Using Ensemble Empirical Mode Decomposition of ECG Signals" and goes over the application of EMD (Empirical Mode
Decomposition) and EEMD (Ensemble Empirical Mode Decomposition) to decompose ECG (Elecrocardiogram) signals into their component
IMFs (Intrinsic Mode Functions), in an effort to identify patterns of either NSR (Normal Sinus Rhythm) or VF (Ventricular 
Fibrillation), that may lead to the discovery of early onset heart attacks and their early treatment, before major symptoms appear.

## EEMD
The ensemble empirical mode decomposition function here presented was completed following the paper's instructions. For that the
default MATLAB function emd(x) was used as the general empirical mode decomposition function. The functioning of the function is 
detailed in comments inside the function itself and in the paper.

## MIT-BIH Database
The database used throughout the paper was the one distributed by MIT-BIH and is accessible through the following link:
[MIT-BIH](https://archive.physionet.org/cgi-bin/atm/ATM).

4 files have been selected for work, 2 recording NSR and 2 recording VF events. 
