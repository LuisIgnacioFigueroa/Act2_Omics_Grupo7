library(tximport)
library(DESeq2)
library(pheatmap)
library(EnhancedVolcano)
library(matrixStats)

design <- read.csv("Design.csv")

files <- list.files(
"salmon_quant",
pattern = "quant.sf",
recursive = TRUE,
full.names = TRUE
)

names(files) <- basename(dirname(files))

tx2gene <- read.delim("Transcrito_a_Gen.tsv")

txi <- tximport(
files,
type = "salmon",
tx2gene = tx2gene
)

dds <- DESeqDataSetFromTximport(
txi,
colData = design,
design = ~ Condition
)

dds <- dds[rowSums(counts(dds)) > 10, ]

dds <- DESeq(dds)

res <- results(dds)

vsd <- varianceStabilizingTransformation(
dds,
blind = FALSE
)

png("results/PCA_obesidad.png", width = 900, height = 700)
plotPCA(vsd, intgroup = "Condition")
dev.off()

annotation_col <- data.frame(
Condition = design$Condition
)

rownames(annotation_col) <- design$Sample

top_genes <- head(
order(
rowVars(assay(vsd)),
decreasing = TRUE
),
15
)

mat <- assay(vsd)[top_genes, ]

png("results/Heatmap_obesidad.png", width = 900, height = 900)

pheatmap(
mat,
annotation_col = annotation_col,
scale = "row"
)

dev.off()

res_df <- as.data.frame(res)

png("results/Volcano_obesidad.png", width = 1000, height = 800)

EnhancedVolcano(
res_df,
lab = rownames(res_df),
x = "log2FoldChange",
y = "pvalue",
title = "Volcano plot - Obesidad vs Normopeso",
pCutoff = 0.5,
FCcutoff = 0.3
)

dev.off()

write.csv(
as.data.frame(res),
file = "results/Genes_diferenciales_obesidad.csv"
)

