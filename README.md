# Act2_Omics_Grupo7
Actividad 2 de Ómicas - Sobrepeso vs Normopeso
# Pasos de QC
- Los productos de amplificación obtenidos por ilumina, en formato .fastq fueron sujetos al análisis de calidad de bases y lecturas mediante FASTQC, para los individuos del grupo Obeso/sobrepeso y grupo normopeso (control). El filtrado de secuencias se realizó mediante fastp, eliminando el frente y cola de las secuencias, ajustando la calidad de los datos a un valor de Q30 o superior, y con lecturas de al menos 35 pares de bases. Tras analizar por MultiQC, se observó Q30 o superior en todas las muestras.
- 
