# Act2_Omics_Grupo7
Actividad 2 de Ómicas - Sobrepeso vs Normopeso
# Pasos de QC
Los productos de amplificación obtenidos mediante secuenciación Illumina, en formato .fastq, fueron sometidos a control de calidad de lecturas y bases utilizando FastQC. El análisis incluyó muestras correspondientes al grupo obesidad/sobrepeso y al grupo normopeso (control). Posteriormente, las secuencias fueron filtradas mediante fastp, eliminando nucleótidos de baja calidad en los extremos 5’ y 3’ de las lecturas. Asimismo, se conservaron únicamente lecturas con valores de calidad promedio iguales o superiores a Q30 y una longitud mínima de 35 pares de bases. Los resultados del control de calidad fueron integrados y visualizados mediante MultiQC, observándose valores de calidad Q30 o superiores en todas las muestras analizadas. Además, no se detectó contenido significativo de adaptadores y las secuencias sobrerepresentadas presentaron porcentajes bajos tras el filtrado, inferiores al 1.5% en las muestras analizadas




