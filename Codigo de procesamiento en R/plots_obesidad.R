# =============================================================================
# Visualizaciones de expresión génica - genes relacionados con obesidad
# Datos: matriz normalizada por DESeq2 (5 muestras x 37 genes)
# =============================================================================

# ---- Librerías ----
# install.packages(c("ggplot2", "tidyr", "dplyr", "RColorBrewer"))
# if (!require("BiocManager", quietly = TRUE)) install.packages("BiocManager")
# BiocManager::install("ComplexHeatmap")

library(ComplexHeatmap)
library(circlize)
library(ggplot2)
library(tidyr)
library(dplyr)
library(RColorBrewer)

mat <- read.csv("~/Downloads/matriz_genes_normalizada_por_DESeq2.csv",
                row.names = 1, check.names = FALSE)

# ---- Cargar datos ----
# Ajusta la ruta según donde tengas el archivo

mat <- as.matrix(mat)

# ---- Definir grupos fenotípicos ----
# Adultos = Obesos; Niños = Normopeso (ajusta si tu asignación es distinta)
grupo <- c(
  "AbrahamSimpson" = "Obeso",
  "HomerSimpson"   = "Obeso",
  "LisaSimpson"    = "Normopeso",
  "BartSimpson"    = "Normopeso",
  "MaggieSimpson"  = "Normopeso"
)
grupo <- grupo[colnames(mat)]  # ordena según las columnas de la matriz

# Paleta común para los grupos
colores_grupo <- c("Obeso" = "#E41A1C", "Normopeso" = "#377EB8")


# =============================================================================
# PLOT 1: Heatmap de expresión (ComplexHeatmap, z-score por gen)
# =============================================================================

# Transformación log para estabilizar varianza, luego z-score por gen (fila)
mat_log <- log2(mat + 1)
mat_z   <- t(scale(t(mat_log)))   # z-score por fila

# Anotación de columnas (muestras) con el grupo
ha_col <- HeatmapAnnotation(
  Grupo = grupo,
  col = list(Grupo = colores_grupo),
  annotation_name_side = "left"
)

# Escala de color divergente centrada en 0
col_fun <- colorRamp2(c(-2, 0, 2), c("#2166AC", "white", "#B2182B"))

ht <- Heatmap(
  mat_z,
  name = "Z-score\n(log2 norm.)",
  col = col_fun,
  top_annotation = ha_col,
  cluster_rows = TRUE,
  cluster_columns = TRUE,
  show_row_names = TRUE,
  show_column_names = TRUE,
  row_names_gp = gpar(fontsize = 8),
  column_names_gp = gpar(fontsize = 10),
  column_title = "Expresión génica normalizada (z-score por gen)",
  row_title = "Genes",
  heatmap_legend_param = list(title_position = "topcenter")
)

# Mostrar en el panel de Plots de RStudio
draw(ht, merge_legend = TRUE)

# Guardar a archivo PNG
png("heatmap_expresion.png", width = 1800, height = 2200, res = 220)
draw(ht, merge_legend = TRUE)
dev.off()


# =============================================================================
# PLOT 2: Boxplots / strip plots de genes clave (LEPR, LEP, MC4R)
# =============================================================================

genes_clave <- c("LEPR", "LEP", "MC4R")

# Pasar a formato largo para ggplot
df_largo <- as.data.frame(mat[genes_clave, , drop = FALSE]) %>%
  tibble::rownames_to_column("Gen") %>%
  pivot_longer(-Gen, names_to = "Muestra", values_to = "Expresion") %>%
  mutate(Grupo = grupo[Muestra],
         Gen = factor(Gen, levels = genes_clave))

p_box <- ggplot(df_largo, aes(x = Grupo, y = Expresion, fill = Grupo)) +
  geom_boxplot(alpha = 0.4, outlier.shape = NA, width = 0.5) +
  geom_jitter(aes(color = Grupo), width = 0.15, size = 3, alpha = 0.9) +
  facet_wrap(~ Gen, scales = "free_y") +
  scale_fill_manual(values = colores_grupo) +
  scale_color_manual(values = colores_grupo) +
  labs(title = "Expresión de genes clave de la vía leptina-melanocortina",
       x = NULL,
       y = "Cuentas normalizadas (DESeq2)") +
  theme_bw(base_size = 13) +
  theme(legend.position = "none",
        strip.text = element_text(face = "bold"),
        plot.title = element_text(face = "bold"))

# Mostrar en el panel de Plots
print(p_box)

# Guardar a archivo PNG
ggsave("boxplots_genes_clave.png", p_box,
       width = 8, height = 4, dpi = 300)


# =============================================================================
# PLOT 3: Heatmap de correlación entre genes
# =============================================================================

# Correlación de Spearman entre genes (más robusta con n pequeño)
mat_cor <- cor(t(mat_log), method = "spearman")

col_cor <- colorRamp2(c(-1, 0, 1),
                      c("#2166AC", "white", "#B2182B"))

ht_cor <- Heatmap(
  mat_cor,
  name = "Spearman ρ",
  col = col_cor,
  cluster_rows = TRUE,
  cluster_columns = TRUE,
  show_row_names = TRUE,
  show_column_names = TRUE,
  row_names_gp = gpar(fontsize = 8),
  column_names_gp = gpar(fontsize = 8),
  column_title = "Correlación entre genes relacionados con obesidad",
  rect_gp = gpar(col = "white", lwd = 0.3)
)

# Mostrar en el panel de Plots
draw(ht_cor, merge_legend = TRUE)

# Guardar a archivo PNG
png("heatmap_correlacion_genes.png",
    width = 2200, height = 2200, res = 220)
draw(ht_cor, merge_legend = TRUE)
dev.off()


# =============================================================================
# Fin del script
# =============================================================================
