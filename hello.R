install.packages("caret", dependencies = c("Depends", "Suggests"))
library(utils)
download.file(url="https://raw.githubusercontent.com/quinlan-lab/sllobs-biostats/master/data/lecture-02/airway_scaledcounts.subset.euro.tsv",
              destfile="genecounts.tsv")
gene_counts <- read.table("genecounts.tsv", header=TRUE, dec = ",")
plot(x=gene_counts$control_1, y=gene_counts$control_2)
plot(x=gene_counts$treated_1, y=gene_counts$treated_2)
abline(0,1)

#diminishing the outliers
plot(x=gene_counts$control_1, y=gene_counts$control_2, xlim = c(0, 2500), ylim=c(0, 2500))
plot(x=gene_counts$treated_1, y=gene_counts$treated_2, xlim = c(0, 2500), ylim=c(0, 2500))


gene_counts$control_mean <- (gene_counts$control_1 +
                               gene_counts$control_2) / 2 
gene_counts$treated_mean <- (gene_counts$treated_1 +
                               gene_counts$treated_2) / 2

plot(x=gene_counts$control_mean, y=gene_counts$treated_mean, xlim = c(0, 2500), ylim=c(0, 2500))
abline(0,1)


plot(log2(gene_counts$treated_mean / gene_counts$control_mean), xlab="gene index", ylab="log2(treated / control)")
# create a new column with the log2 ratio
gene_counts$logexpr = log2(gene_counts$treated_mean / gene_counts$control_mean)

# create a new color column based upon the log2 expression
gene_counts$color[gene_counts$logexpr >=3 | gene_counts$logexpr <=-3]="darkred"
gene_counts$color[gene_counts$logexpr <3  & gene_counts$logexpr >-3]="darkgray"  

# plot using the new color
plot(gene_counts$logexpr, col=gene_counts$color, xlab="gene index", ylab="log2(treated / control)")
