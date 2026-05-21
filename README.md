# Análisis RNA-seq de Obesidad

Proyecto de análisis transcriptómico RNA-seq enfocado en la identificación de genes diferencialmente expresados entre muestras con sobrepeso/obesidad y muestras normopeso.

---

# Objetivo

Evaluar diferencias en los perfiles de expresión génica asociadas a obesidad mediante un flujo de trabajo de RNA-seq utilizando herramientas bioinformáticas modernas.

---

# Flujo de trabajo

FASTQ → FastQC → MultiQC → Salmon → tximport → DESeq2 → PCA → Heatmap → Volcano Plot

---

# Herramientas utilizadas

## Linux / Entorno

* Ubuntu 24.04 (WSL2)
* Conda / Bioconda

## Control de calidad

* FastQC
* MultiQC

## Cuantificación transcriptómica

* Salmon

## Análisis estadístico

* R
* DESeq2
* tximport

## Visualización

* pheatmap
* EnhancedVolcano

---

# Estructura del proyecto

```text
RNAseq-Obesity-Analysis/
│
├── results/
│   ├── PCA_obesidad.png
│   ├── Heatmap_obesidad.png
│   ├── Volcano_obesidad.png
│   ├── Genes_diferenciales_obesidad.csv
│   └── Genes_significativos_obesidad.csv
│
├── scripts/
├── metadata/
├── Design.csv
├── Transcrito_a_Gen.tsv
├── README.md
└── .gitignore
```

---

# Resultados obtenidos

## PCA

Visualización de agrupamiento entre muestras obesas y normopeso según patrones de expresión génica.

## Heatmap

Mapa de calor de genes con mayor variabilidad entre grupos experimentales.

## Volcano Plot

Identificación visual de genes sobreexpresados y subexpresados.

## Expresión diferencial

Obtención de genes diferencialmente expresados mediante DESeq2.

---

# Metodología general

1. Control de calidad de lecturas RNA-seq.
2. Resumen de calidad con MultiQC.
3. Construcción de índice transcriptómico.
4. Cuantificación de transcritos con Salmon.
5. Importación de cuantificaciones usando tximport.
6. Análisis diferencial con DESeq2.
7. Generación de visualizaciones transcriptómicas.

---

# Autor

Luis Angelo Cruz

Proyecto académico de Bioinformática.

