#### Make phyloseq object, working in the ryan_exports folder on my computer ####
## Load all required packages ##
library(phyloseq)
library(ape)
library(tidyverse)
library(vegan)
library(picante)

## Loading in your data ##
meta <- read_delim(file = "ryan_metadata.tsv")

otufp <- "feature-table.txt"
otu <- read_delim(file = otufp, delim="\t", skip=1)

taxfp <- "taxonomy.tsv"
tax <- read_delim(taxfp, delim="\t")

phylotreefp <- "tree.nwk"
phylotree <- read.tree(phylotreefp)
                     
## Format OTU table
#### OTU tables should be a matrix ####
#### with rownames and colnames as OTUs and sampleIDs, respectively #

#### save everything except first column (OTU ID) into a matrix #
otu_mat <- as.matrix(otu[,-1])
#### Make first column (#OTU ID) the rownames of the new matrix #
rownames(otu_mat) <- otu$`#OTU ID`
#### Use the "otu_table" function to make an OTU table #
OTU <- otu_table(otu_mat, taxa_are_rows = TRUE) 
class(OTU)

## Format sample metadata 
#### Save everything except sampleid as new data frame #
samp_df <- as.data.frame(meta[,-1])
#### Make sampleids the rownames
rownames(samp_df)<- meta$'sample-id'
#### Make phyloseq sample data with sample_data() function
SAMP <- sample_data(samp_df)
class(SAMP)

## Formatting taxonomy
#### Convert taxon strings to a table with separate taxa rank columns
tax_mat <- tax %>% select(-Confidence)%>%
  separate(col=Taxon, sep="; "
           , into = c("Domain","Phylum","Class","Order","Family","Genus","Species")) %>%
  as.matrix() # Saving as a matrix
#### Save everything except feature IDs #
tax_mat <- tax_mat[,-1]
#### Make sampleids the rownames
rownames(tax_mat) <- tax$`Feature ID`
#### Make taxa table
TAX <- tax_table(tax_mat)
class(TAX)

## Create phyloseq object
#### Merge all into a phyloseq object
ryan_phyloseq <- phyloseq(OTU, SAMP, TAX, phylotree)

### Save phyloseq object
save(ryan_phyloseq, file="ryan_phyloseq.RData")


#### Incase you would like to view each component of the phyloseq object
#otu_table(ryan_phyloseq)
#sample_data(ryan_phyloseq)
#tax_table(ryan_phyloseq)
#phy_tree(ryan_phyloseq)

############################################################################################

# Aim 1: Comparing diversity of each biopsy site in healthy individuals #

## Filter for healthy patients only (according to Aim 1)
ryan_healthy <- subset_samples(ryan_phyloseq, Condition == "Healthy" )

## Alpha diversity ##
### Shannon Index

estimate_richness(ryan_healthy)
ryan_richness <- estimate_richness(ryan_healthy, measures = c("Shannon"))

plot_richness(ryan_healthy) 
plot_richness(ryan_healthy, measures = c("Shannon")) 

gg_richness <- plot_richness(ryan_healthy, x = "Biopsy_location", measures = c("Shannon")) +
  xlab("Biopsy Site") +
  geom_boxplot()
gg_richness

ggsave(filename = "ryan_richness.png"
       , gg_richness
       , height=4, width=6)

### Phylogenetic Diversity

#### calculate Faith's phylogenetic diversity as PD
phylo_dist <- pd(t(otu_table(ryan_healthy)), phy_tree(ryan_healthy),
                 include.root=F) 
?pd

#### add PD to metadata table
sample_data(ryan_healthy)$PD <- phylo_dist$PD

#### plot any metadata category against the PD
plot.pd <- ggplot(sample_data(ryan_healthy), aes(Biopsy_location, PD)) + 
  geom_boxplot() +
  xlab("Biopsy Site") +
  ylab("Phylogenetic Diversity")

#### view plot
plot.pd

ggsave(filename = "ryan_pd.png"
       , plot.pd
       , height=4, width=6)

### Kruskal-Wallis Test 
#### to compare diversity between biopsy sites as the values are not normally distributed (non-parametric) and there are >2 groups (biopsy sites)

metadata <- sample_data(ryan_healthy)
ryan_richness <- cbind(ryan_richness, metadata)
colnames(ryan_richness)

#### first on Shannon
kruskal_shannon <- kruskal.test(Shannon ~ Biopsy_location, data = ryan_richness)
kruskal_shannon

#### p-value of 0.2239 which fails to reject the null hypothesis, therefore, there is not statistical significance in richness between any of the biopsy sites

#### Next, on PD
kruskal_pd <- kruskal.test(PD ~ Biopsy_location, data = ryan_richness)
kruskal_pd

#### p-value of 0.6388 which fails to reject the null hypothesis, therefore, there is no statistically significant difference in phylogenetic alpha diversity between any of the biopsy sites



## Beta diversity ###

### Bray Curtis
bc_dm <- distance(ryan_healthy, method="bray")

pcoa_bc <- ordinate(ryan_healthy, method="PCoA", distance=bc_dm)

gg_pcoa_bc <- plot_ordination(ryan_healthy, pcoa_bc, color = "Biopsy_location") +
  labs(col = "Biopsy Site")
gg_pcoa_bc

#### No clustering of biopsy sites observed

ggsave("plot_pcoa_bc.png"
       , gg_pcoa_bc
       , height=4, width=5)

### Unweighted Unifrac Distance
unifrac <- distance(ryan_healthy, method="unifrac")

pcoa_unifrac <- ordinate(ryan_healthy, method="PCoA", distance=unifrac)

gg_pcoa_unifrac <- plot_ordination(ryan_healthy, pcoa_unifrac, color = "Biopsy_location") +
  labs(col = "Biopsy Site")
gg_pcoa_unifrac

#### No clustering of biopsy sites observed

ggsave("plot_pcoa_unifrac.png"
       , gg_pcoa_unifrac
       , height=4, width=5)

### Weighted Unifrac Distance
wunifrac <- distance(ryan_healthy, method="wunifrac")

pcoa_wunifrac <- ordinate(ryan_healthy, method="PCoA", distance=wunifrac)

gg_pcoa_wunifrac <- plot_ordination(ryan_healthy, pcoa_wunifrac, color = "Biopsy_location") +
  labs(col = "Biopsy Site")
gg_pcoa_wunifrac

#### No clustering of biopsy sites observed

ggsave("plot_pcoa_wunifrac.png"
       , gg_pcoa_wunifrac
       , height=4, width=5)


### PERMANOVA Tests
#### to determine whether the overall microbial community composition differs with statistical significance between biopsy locations

### Bray-Curtis
dat <- data.frame(sample_data(ryan_healthy))
adonis2(bc_dm ~ Biopsy_location, data = dat)

#### p-value of 0.099, not statistically significant

### Unweighted Unifrac
adonis2(unifrac ~ Biopsy_location, data=dat)

#### p-value of 0.865, not statistically significant

### Weighted Unifrac
adonis2(wunifrac ~ Biopsy_location, data=dat)

#### p-value of 0.887, not statistically significant

#####################################################################################################

# Aim 2: Comparing diversity of inflamed vs. non-inflamed tissues based on medication use #

#### First filter out the healthy individuals before filtering by inflammation
ryan_unhealthy <- subset_samples(ryan_phyloseq, Condition == "Crohn's Disease" | Condition == "Ulcerative Colitis")

#### Filter for inflamed tissues only
ryan_inflamed <- subset_samples(ryan_unhealthy, Histological.status == "Inflamed tissue ")

#### Make a second table filtering for only non-inflamed tissues
ryan_noninflamed <- subset_samples(ryan_unhealthy, Histological.status == "Noninflamed tissue ")


## Alpha diversity - Inflamed ##
### Shannon Index
estimate_richness(ryan_inflamed)
ryan_inf_richness <- estimate_richness(ryan_inflamed, measures = c("Shannon"))

plot_richness(ryan_inflamed) 
plot_richness(ryan_inflamed, measures = c("Shannon")) 

gg_richness_inf <- plot_richness(ryan_inflamed, x = "Medications", measures = c("Shannon")) +
  xlab("Medication") +
  geom_boxplot()
gg_richness_inf

ggsave(filename = "ryan_richness_inf.png"
       , gg_richness_inf
       , height=4, width=6)

### Phylogenetic Diversity
#### calculate Faith's phylogenetic diversity as PD
phylo_dist_inf <- pd(t(otu_table(ryan_inflamed)), phy_tree(ryan_inflamed),
                     include.root=F) 

#### add PD to metadata table
sample_data(ryan_inflamed)$PD <- phylo_dist_inf$PD

#### plot Medications against the PD
plot_pd_inf <- ggplot(sample_data(ryan_inflamed), aes(Medications, PD)) + 
  geom_boxplot() +
  xlab("Medication") +
  ylab("Phylogenetic Diversity")
plot_pd_inf

ggsave(filename = "ryan_pd_inf.png"
       , plot_pd_inf
       , height=4, width=6)

### Kruskal-Wallis Test 
#### to compare diversity between medications as the values are not normally distributed (non-parametric) and there are >2 groups (medications)
metadata_inf <- sample_data(ryan_inflamed)
ryan_inf_richness <- cbind(ryan_inf_richness, metadata_inf)
colnames(ryan_inf_richness)

kruskal_shannon_inf <- kruskal.test(Shannon ~ Medications, data = ryan_inf_richness)
kruskal_shannon_inf

#### p-value of 0.3379 which fails to reject the null hypothesis, therefore, there is no statistical significance in richness between any of the medication groups

kruskal_pd_inf <- kruskal.test(PD ~ Medications, data = ryan_inf_richness)
kruskal_pd_inf

#### p-value of 0.01955 which rejects the null hypothesis, therefore, there is a statistically significant difference in phylogenetic alpha diversity between medication groups
#### to determine which groups have statistically significant differences, run a log transformed ANOVA

lm_sh_vs_med_log <- lm(log(PD) ~ `Medications`, data=ryan_inf_richness)
anova_sh_vs_med_log <- aov(lm_sh_vs_med_log)
summary(anova_sh_vs_med_log)
TukeyHSD(anova_sh_vs_med_log)

#### statistically significant p-values observed between Mesalamine+corticosteroids-Mercaptopurine (0.04499), Mesalamine+corticosteroids-Mesalamine (0.04443), and No-Mesalamine+corticosteroids (0.04361).

#################################################################################################

## Alpha diversity - Non-inflamed ##
### Shannon Index
estimate_richness(ryan_noninflamed)
ryan_ninf_richness <- estimate_richness(ryan_noninflamed, measures = c("Shannon"))

plot_richness(ryan_noninflamed) 
plot_richness(ryan_noninflamed, measures = c("Shannon")) 

gg_richness_ninf <- plot_richness(ryan_noninflamed, x = "Medications", measures = c("Shannon")) +
  xlab("Medication") +
  geom_boxplot()
gg_richness_ninf

ggsave(filename = "ryan_richness_ninf.png"
       , gg_richness_ninf
       , height=4, width=6)

### Phylogenetic Diversity
#### calculate Faith's phylogenetic diversity as PD
phylo_dist_ninf <- pd(t(otu_table(ryan_noninflamed)), phy_tree(ryan_noninflamed),
                      include.root=F) 

#### add PD to metadata table
sample_data(ryan_noninflamed)$PD <- phylo_dist_ninf$PD

#### plot Medications against the PD
plot_pd_ninf <- ggplot(sample_data(ryan_noninflamed), aes(Medications, PD)) + 
  geom_boxplot() +
  xlab("Medication") +
  ylab("Phylogenetic Diversity")
plot_pd_ninf

ggsave(filename = "ryan_pd_ninf.png"
       , plot_pd_ninf
       , height=4, width=6)


### Kruskal-Wallis Test 
#### to compare diversity between medications as the values are not normally distributed (non-parametric) and there are >2 groups (medications)
metadata_ninf <- sample_data(ryan_noninflamed)
ryan_ninf_richness <- cbind(ryan_ninf_richness, metadata_ninf)
colnames(ryan_ninf_richness)

kruskal_shannon_ninf <- kruskal.test(Shannon ~ Medications, data = ryan_ninf_richness)
kruskal_shannon_ninf

#### p-value of 0.6932 which fails to reject the null hypothesis, therefore, there is no statistical significance in richness between any of the medications

kruskal_pd_ninf <- kruskal.test(PD ~ Medications, data = ryan_ninf_richness)
kruskal_pd_ninf

#### p-value of 0.02042 which rejects the null hypothesis, therefore, there is a statistically significant difference in phylogenetic alpha diversity between medication groups
#### to determine which groups have statistically significant differences, run a log transformed ANOVA

lm_pd_vs_med_log <- lm(log(PD) ~ `Medications`, data=ryan_ninf_richness)
anova_pd_vs_med_log <- aov(lm_pd_vs_med_log)
summary(anova_pd_vs_med_log)
TukeyHSD(anova_pd_vs_med_log)

#### statistically significant p-value between medication groups No-AntiTNF (0.04223) in noninflammed tissues

##############################################################################################################

## Beta diversity - Inflamed ###
### Bray Curtis

bc_inf <- distance(ryan_inflamed, method="bray")

pcoa_bc_inf <- ordinate(ryan_inflamed, method="PCoA", distance=bc_inf)

gg_pcoa_bc_inf <- plot_ordination(ryan_inflamed, pcoa_bc_inf, color = "Medications") +
  labs(col = "Medication")
gg_pcoa_bc_inf

#### No clustering of specific medication groups observed. Most samples concentrated towards the left of the plot. PC1(17.4%), PC2(8.5%), 25.9% total variation.

ggsave("plot_pcoa_bc_inf.png"
       , gg_pcoa_bc_inf
       , height=4, width=10)

### Unweighted Unifrac Distance
unifrac_inf <- distance(ryan_inflamed, method="unifrac")

pcoa_unifrac_inf <- ordinate(ryan_inflamed, method="PCoA", distance=unifrac_inf)

gg_pcoa_unifrac_inf <- plot_ordination(ryan_inflamed, pcoa_unifrac_inf, color = "Medications") +
  labs(col = "Medication")
gg_pcoa_unifrac_inf

#### No clustering of specific medications observed, however, general clustering of all groups to the left of the plot. There will likely be no significant difference in the presence/absence of taxa. PC1(35.9%), PC2(10.1%), 46% total variation.

ggsave("plot_pcoa_unifrac_inf.png"
       , gg_pcoa_unifrac_inf
       , height=4, width=10)

### Weighted Unifrac Distance
wunifrac_inf <- distance(ryan_inflamed, method="wunifrac")

pcoa_wunifrac_inf <- ordinate(ryan_inflamed, method="PCoA", distance=wunifrac_inf)

gg_pcoa_wunifrac_inf <- plot_ordination(ryan_inflamed, pcoa_wunifrac_inf, color = "Medications") +
  labs(col = "Medication")
gg_pcoa_wunifrac_inf

#### arched clustering of specific medication groups observed, with most samples concentrated at the left of the plot. Since a small number of abundant lineages differ strongly between samples. Meaning that one category/column/axis of variation (ie. smoking, subject, inflammation) is the main contributor of phylogenetic abundance difference. PC1(98.1%), PC2(1.6%), 99.7% total variation.

ggsave("plot_pcoa_wunifrac_inf.png"
       , gg_pcoa_wunifrac_inf
       , height=4, width=10)

### PERMANOVA Tests
## to determine whether the overall microbial community composition differs with statistical significance between Medication groups

### Bray-Curtis
dat_inf <- data.frame(sample_data(ryan_inflamed))
adonis2(bc_inf ~ Medications, data = dat_inf)

#### p-value of 0.001, statistically significant. Community composition differs significantly between medication groups.

#### Re-plot the Bray-Curtis plot but include ellipses to see significant groups
ellip_pcoa_bc_inf <- plot_ordination(ryan_inflamed, pcoa_bc_inf, color = "Medications") +
  labs(col = "Medication")+
  stat_ellipse(type = "norm")
ellip_pcoa_bc_inf

ggsave("ellip_plot_bc_inf.png"
       , ellip_pcoa_bc_inf
       , height=4, width=10)
       <img width="3000" height="1200" alt="ellip_plot_bc_inf" src="https://github.com/user-attachments/assets/19597f08-2d0b-44af-8b56-b0e84af078e6" />

#### Most ellipses are very large and don't show significant clustering. The most concentrated group is Mercaptopurine+corticosteroids.

#### Run a TukeyHSD post-hoc test to determine between which medication groups this statistical significance lies.
#### download and install required package
install.packages("devtools")
devtools::install_github("pmartinezarbizu/pairwiseAdonis/pairwiseAdonis")
library(pairwiseAdonis)

pairwise.adonis2(
  bc_inf ~ Medications,
  data = dat_inf,
  p.adjust.m = "BH"
)
#### Significance between No_vs_Mercaptopurine (0.033), No_vs_Mesalamine+corticosteroids (0.01), No_vs_Mesalamine+mercaptopurine+anti-TNF (0.022), Anti-TNF_vs_Mesalamine (0.008), Corticosteroids_vs_Mesalamine (0.005), Mesalamine+corticosteroids_vs_Mesalamine (0.002), Mesalamine+corticosteroids_vs_Mesalamine+mercaptopurine+anti-TNF (0.045), Mesalamine_vs_Mesalamine+mercaptopurine+anti-TNF (0.01), Mesalamine_vs_Antibiotics (0.041).

### Unweighted Unifrac
adonis2(unifrac_inf ~ Medications, data=dat_inf)

#### p-value of 0.004, statistically significant. There is a significant difference in the presence/absence of specific taxa between medication groups.

#### Re-plot the Unifrac plot but include ellipses to see significant groups
ellip_pcoa_unifrac_inf <- plot_ordination(ryan_inflamed, pcoa_unifrac_inf, color = "Medications") +
  labs(col = "Medication")+
  stat_ellipse(type = "norm")
ellip_pcoa_unifrac_inf

ggsave("ellip_plot_unifrac_inf.png"
       , ellip_pcoa_unifrac_inf
       , height=4, width=10)
       <img width="3000" height="1200" alt="ellip_plot_unifrac_inf" src="https://github.com/user-attachments/assets/094a52bf-98fd-4143-8cfc-cd2d88adb729" />

#### Most ellipses are very large and don't show significant clustering. However, Mercaptopurine, Mercaptopurine+corticosteroids, Mesalamine+mercaptopurine, and Mesalamine+mercaptopurine+anti-TNF show tight clustering. Overall, any medication group that contains Mercaptopurine shows significant difference.

#### Run a TukeyHSD post-hoc test to determine between which medication groups this statistical significance lies.
pairwise.adonis2(
  unifrac_inf ~ Medications,
  data = dat_inf,
  p.adjust.m = "BH"
)
#### Significant differences between: No_vs_Anti-TNF (0.014), No_vs_Corticosteroids (0.008), No_vs_Mesalamine+corticosteroids (0.001), No_vs_Mesalamine+mercaptopurine+anti-TNF (0.013), No_vs_Antibiotics (0.032), Anti-TNF_vs_Mercaptopurine (0.005), Anti-TNF_vs_Mesalamine (0.012), Corticosteroids_vs_Mercaptopurine (0.001), Corticosteroids_vs_Mesalamine (0.006), Mercaptopurine_vs_Mesalamine+corticosteroids (0.006), Mercaptopurine_vs_Mesalamine+mercaptopurine+anti-TNF (0.012), Mesalamine+corticosteroids_vs_Mesalamine (0.001), Mesalamine_vs_Mesalamine+mercaptopurine+anti-TNF (0.014), Mesalamine_vs_Antibiotics (0.043). 

### Weighted Unifrac
adonis2(wunifrac_inf ~ Medications, data=dat_inf)

#### p-value of 0.003, statistically significant. Significant difference in the relative abundance of taxa between medication groups.

#### Re-plot the Weighted Unifrac plot but include ellipses to see significant groups
ellip_pcoa_wunifrac_inf <- plot_ordination(ryan_inflamed, pcoa_wunifrac_inf, color = "Medications") +
  labs(col = "Medication")+
  stat_ellipse(type = "norm")
ellip_pcoa_wunifrac_inf

ggsave("ellip_plot_wunifrac_inf.png"
       , ellip_pcoa_wunifrac_inf
       , height=4, width=10)
       <img width="3000" height="1200" alt="ellip_plot_wunifrac_inf" src="https://github.com/user-attachments/assets/16458941-6a53-4239-99c6-b0acba3e1500" />

#### Most ellipses are very large and don't show significant clustering. However, Mercaptopurine and Mercaptopurine+corticosteroids show tight clustering.

#### Run a TukeyHSD post-hoc test to determine between which medication groups this statistical significance lies.
pairwise.adonis2(
  wunifrac_inf ~ Medications,
  data = dat_inf,
  p.adjust.m = "BH"
)
#### Significant differences between: No_vs_Anti-TNF (0.038), No_vs_Corticosteroids (0.013), No_vs_Mesalamine+corticosteroids (0.027), No_vs_Antibiotics (0.027), Anti-TNF_vs_Mesalamine (0.001), Mesalamine+mercaptopurine_vs_Mesalamine (0.023), Corticosteroids_vs_Mesalamine (0.002), Mesalamine+corticosteroids_vs_Mesalamine (0.001), Mesalamine_vs_Mesalamine+mercaptopurine+anti-TNF (0.03), Mesalamine_vs_Antibiotics (0.036).

####################################################################################################################################

## Beta diversity - Non-inflamed ##
### Bray Curtis

bc_ninf <- distance(ryan_noninflamed, method="bray")

pcoa_bc_ninf <- ordinate(ryan_noninflamed, method="PCoA", distance=bc_ninf)

gg_pcoa_bc_ninf <- plot_ordination(ryan_noninflamed, pcoa_bc_ninf, color = "Medications") +
  labs(col = "Medication")
gg_pcoa_bc_ninf
<img width="1500" height="1200" alt="plot_pcoa_bc_ninf" src="https://github.com/user-attachments/assets/b530d4ae-7dbf-4436-aaaf-edf5bf929415" />

#### No clustering of specific medication groups observed, therefore, will likely be no significant difference in taxa abundance. PC1(15.7%), PC2(9.1%), 24.8% total variation.

ggsave("plot_pcoa_bc_ninf.png"
       , gg_pcoa_bc_ninf
       , height=4, width=5)

### Unweighted Unifrac Distance
unifrac_ninf <- distance(ryan_noninflamed, method="unifrac")

pcoa_unifrac_ninf <- ordinate(ryan_noninflamed, method="PCoA", distance=unifrac_ninf)

gg_pcoa_unifrac_ninf <- plot_ordination(ryan_noninflamed, pcoa_unifrac_ninf, color = "Medications") +
  labs(col = "Medication")+
  stat_ellipse(type = "norm")
gg_pcoa_unifrac_ninf

ggsave("plot_pcoa_unifrac_ninf.png"
       , gg_pcoa_unifrac_ninf
       , height=4, width=5)
<img width="1500" height="1200" alt="plot_pcoa_unifrac_ninf" src="https://github.com/user-attachments/assets/3bb08de3-8438-450e-baa4-3cad66d10da8" />

### Weighted Unifrac Distance
wunifrac_ninf <- distance(ryan_noninflamed, method="wunifrac")

pcoa_wunifrac_ninf <- ordinate(ryan_noninflamed, method="PCoA", distance=wunifrac_ninf)

gg_pcoa_wunifrac_ninf <- plot_ordination(ryan_noninflamed, pcoa_wunifrac_ninf, color = "Medications") +
  labs(col = "Medication")+
  stat_ellipse(type = "norm")
gg_pcoa_wunifrac_ninf

ggsave("plot_pcoa_wunifrac_ninf.png"
       , gg_pcoa_wunifrac_ninf
       , height=4, width=5)
<img width="1500" height="1200" alt="plot_pcoa_wunifrac_ninf" src="https://github.com/user-attachments/assets/aa01c032-67cb-445d-9122-a088264a072b" />

### PERMANOVA Test
#### to determine whether the overall microbial community composition differs with statistical significance between Medication groups

### Bray-Curtis
ryan_noninflamed_med <- subset_samples(ryan_noninflamed, !is.na(Medications))
dat_ninf <- data.frame(sample_data(ryan_noninflamed_med))
bc_ninf <- distance(ryan_noninflamed_med, method = "bray")

adonis2(bc_ninf ~ Medications, data = dat_ninf)

#### p-value of 0.005, statistically significant difference in taxa abundance between medication groups.

#### Re-plot the Bray-Curtis plot but include ellipses to see significant groups
ellip_pcoa_bc_ninf <- plot_ordination(ryan_noninflamed, pcoa_bc_ninf, color = "Medications") +
  labs(col = "Medication")+
  stat_ellipse(type = "norm")
ellip_pcoa_bc_ninf

ggsave("ellip_plot_bc_ninf.png"
       , ellip_pcoa_bc_ninf
       , height=4, width=10)
       <img width="3000" height="1200" alt="ellip_plot_bc_ninf" src="https://github.com/user-attachments/assets/e8b31045-a0fa-4140-86c8-92032e405c03" />

#### Most ellipses are very large except for the NA groups which cluster. Therefore, there is likely no real statistical significance in taxa abundance between the true medication groups.

#### Run a TukeyHSD post-hoc test to determine between which medication groups this statistical significance lies.
pairwise.adonis2(
  bc_ninf ~ Medications,
  data = dat_ninf,
  p.adjust.m = "BH"
)
#### Significant differences between: No_vs_Corticosteroids (0.003), No_vs_Mesalamine+corticosteroids (0.046), No_vs_Anti-TNF (0.003), No_vs_Antibiotics (0.035), Corticosteroids_vs_Mesalamine (0.025), Mesalamine_vs_Anti-TNF (0.021).

### Unweighted Unifrac
adonis2(unifrac_ninf ~ Medications, data=dat_ninf)

#### p-value of 0.03, statistically significant. There is a significant difference in the presence/absence of specific taxa between medication groups.

#### Re-plot the Unifrac plot but include ellipses to see significant groups
ellip_pcoa_unifrac_ninf <- plot_ordination(ryan_noninflamed, pcoa_unifrac_ninf, color = "Medications") +
  labs(col = "Medication")+
  stat_ellipse(type = "norm")
ellip_pcoa_unifrac_ninf

ggsave("ellip_plot_unifrac_ninf.png"
       , ellip_pcoa_unifrac_ninf
       , height=4, width=10)
<img width="3000" height="1200" alt="ellip_plot_unifrac_ninf" src="https://github.com/user-attachments/assets/d0e2a702-1819-4846-97c3-62dccc962ae6" />

#### Run a TukeyHSD post-hoc test to determine between which medication groups this statistical significance lies.
pairwise.adonis2(
  unifrac_ninf ~ Medications,
  data = dat_ninf,
  p.adjust.m = "BH"
)
#### No_vs_Anti-TNF (0.002), No_vs_Antibiotics (0.035), Corticosteroids_vs_Mercaptopurine (0.013), Mercaptopurine_vs_Anti-TNF (0.017), Mercaptopurine_vs_Mesalamine+mercaptopurine (0.018), Mercaptopurine_vs_Mesalamine+mercaptopurine+anti-TNF (0.025), Mesalamine_vs_Anti-TNF (0.031).

### Weighted Unifrac
adonis2(wunifrac_ninf ~ Medications, data=dat_ninf)

#### p-value of 0.012, statistically significant. Significant difference in the relative abundance of taxa between medication groups.

#### Re-plot the Weighted Unifrac plot but include ellipses to see significant groups
ellip_pcoa_wunifrac_ninf <- plot_ordination(ryan_noninflamed, pcoa_wunifrac_ninf, color = "Medications") +
  labs(col = "Medication")+
  stat_ellipse(type = "norm")
ellip_pcoa_wunifrac_ninf

ggsave("ellip_plot_wunifrac_ninf.png"
       , ellip_pcoa_wunifrac_ninf
       , height=4, width=10)
<img width="3000" height="1200" alt="ellip_plot_wunifrac_ninf" src="https://github.com/user-attachments/assets/b7a18017-83c5-4462-9131-6f1b604e647d" />

#### Run a TukeyHSD post-hoc test to determine between which medication groups this statistical significance lies.
pairwise.adonis2(
  wunifrac_ninf ~ Medications,
  data = dat_ninf,
  p.adjust.m = "BH"
)
#### Significant differences between: No_vs_Corticosteroids (0.006), No_vs_Anti-TNF (0.001), Mesalamine+corticosteroids_vs_Anti-TNF (0.033), Mesalamine_vs_Anti-TNF (0.018), Anti-TNF_vs_Mesalamine+mercaptopurine (0.038).

###################################################################################################################

# Re-do of Aim 2 metrics but only comparing the combination drugs #
#### to see if there is any significant difference between the various combination treatments or if combination treatments can be binned.

#### Filter for inflamed tissues  with combination medications only
ryan_inflamed_combo <- subset_samples(ryan_unhealthy, Histological.status == "Inflamed tissue "&
                                        !(Medications %in% c("No", "Anti-TNF", "Antibiotics",
                                                             "Corticosteroids", "Mercaptopurine", "Mesalamine")))

#### Make a second table filtering for only non-inflamed tissues with combination medications only
ryan_noninflamed_combo <- subset_samples(ryan_unhealthy, Histological.status == "Noninflamed tissue "&
  !(Medications %in% c("No", "Anti-TNF", "Antibiotics",
                       "Corticosteroids", "Mercaptopurine", "Mesalamine"))
)


## Alpha diversity - Inflamed ####
### Shannon Index
estimate_richness(ryan_inflamed_combo)
ryan_inf_combo_richness <- estimate_richness(ryan_inflamed_combo, measures = c("Shannon"))

plot_richness(ryan_inflamed_combo) 
plot_richness(ryan_inflamed_combo, measures = c("Shannon")) 

gg_richness_inf_combo <- plot_richness(ryan_inflamed_combo, x = "Medications", measures = c("Shannon")) +
  xlab("Medication") +
  geom_boxplot()
gg_richness_inf_combo

ggsave(filename = "ryan_richness_inf_combo.png"
       , gg_richness_inf_combo
       , height=4, width=6)
<img width="1800" height="1200" alt="ryan_richness_inf_combo" src="https://github.com/user-attachments/assets/f31defef-1219-4420-ba5d-7661d0ab4ef7" />

### Phylogenetic Diversity
#### calculate Faith's phylogenetic diversity as PD
phylo_dist_inf_combo <- pd(t(otu_table(ryan_inflamed_combo)), phy_tree(ryan_inflamed_combo),
                     include.root=F) 

#### add PD to metadata table
sample_data(ryan_inflamed_combo)$PD <- phylo_dist_inf_combo$PD

#### plot Medications against the PD
plot_pd_inf_combo <- ggplot(sample_data(ryan_inflamed_combo), aes(Medications, PD)) + 
  geom_boxplot() +
  xlab("Medication") +
  ylab("Phylogenetic Diversity")
plot_pd_inf_combo

ggsave(filename = "ryan_pd_inf_combo.png"
       , plot_pd_inf_combo
       , height=4, width=6)
<img width="1800" height="1200" alt="ryan_pd_inf_combo" src="https://github.com/user-attachments/assets/bae0e818-be0f-498f-b597-a710466f3c84" />

### Kruskal-Wallis Test 
#### to compare diversity between medications as the values are not normally distributed (non-parametric) and there are >2 groups (medications)
metadata_inf_combo <- sample_data(ryan_inflamed_combo)
ryan_inf_combo_richness <- cbind(ryan_inf_combo_richness, metadata_inf_combo)
colnames(ryan_inf_combo_richness)

kruskal_shannon_inf_combo <- kruskal.test(Shannon ~ Medications, data = ryan_inf_combo_richness)
kruskal_shannon_inf_combo

#### p-value of 0.2752

kruskal_pd_inf_combo <- kruskal.test(PD ~ Medications, data = ryan_inf_combo_richness)
kruskal_pd_inf_combo

#### p-value of 0.9619, no significant difference in phylogenetic alpha diversity between combination medication groups

#################################################################################################

## Alpha diversity - Non-inflamed ##
### Shannon Index
estimate_richness(ryan_noninflamed_combo)
ryan_ninf_combo_richness <- estimate_richness(ryan_noninflamed_combo, measures = c("Shannon"))

plot_richness(ryan_noninflamed_combo) 
plot_richness(ryan_noninflamed_combo, measures = c("Shannon")) 

gg_richness_ninf_combo <- plot_richness(ryan_noninflamed_combo, x = "Medications", measures = c("Shannon")) +
  xlab("Medication") +
  geom_boxplot()
gg_richness_ninf_combo

ggsave(filename = "ryan_richness_ninf_combo.png"
       , gg_richness_ninf_combo
       , height=4, width=6)
<img width="1800" height="1200" alt="ryan_richness_ninf_combo" src="https://github.com/user-attachments/assets/71738cc0-778d-4fb8-95e7-37a800671621" />

### Phylogenetic Diversity
#### calculate Faith's phylogenetic diversity as PD
phylo_dist_ninf_combo <- pd(t(otu_table(ryan_noninflamed_combo)), phy_tree(ryan_noninflamed_combo),
                      include.root=F) 

#### add PD to metadata table
sample_data(ryan_noninflamed_combo)$PD <- phylo_dist_ninf_combo$PD

#### plot Medications against the PD
plot_pd_ninf_combo <- ggplot(sample_data(ryan_noninflamed_combo), aes(Medications, PD)) + 
  geom_boxplot() +
  xlab("Medication") +
  ylab("Phylogenetic Diversity")
plot_pd_ninf_combo

ggsave(filename = "ryan_pd_ninf_combo.png"
       , plot_pd_ninf
       , height=4, width=6)
<img width="1800" height="1200" alt="ryan_pd_ninf_combo" src="https://github.com/user-attachments/assets/6e26f747-f6f6-4b1b-b907-e91939303af6" />


### Kruskal-Wallis Test 
#### to compare diversity between medications as the values are not normally distributed (non-parametric) and there are >2 groups (medications)
metadata_ninf_combo <- sample_data(ryan_noninflamed_combo)
ryan_ninf_combo_richness <- cbind(ryan_ninf_combo_richness, metadata_ninf_combo)
colnames(ryan_ninf_combo_richness)

kruskal_shannon_ninf_combo <- kruskal.test(Shannon ~ Medications, data = ryan_ninf_combo_richness)
kruskal_shannon_ninf_combo

#### p-value of 0.3742 which fails to reject the null hypothesis, therefore, there is no statistical significance in richness between any of the combination treatments.

kruskal_pd_ninf_combo <- kruskal.test(PD ~ Medications, data = ryan_ninf_combo_richness)
kruskal_pd_ninf_combo

#### p-value of 0.5176, no statistically significant difference in phylogenetic alpha diversity between combination treatments.

##############################################################################################################

## Beta diversity - Inflamed ##
### Bray Curtis

bc_inf_combo <- distance(ryan_inflamed_combo, method="bray")

pcoa_bc_inf_combo <- ordinate(ryan_inflamed_combo, method="PCoA", distance=bc_inf_combo)

gg_pcoa_bc_inf_combo <- plot_ordination(ryan_inflamed_combo, pcoa_bc_inf_combo, color = "Medications") +
  labs(col = "Medication")
gg_pcoa_bc_inf_combo

ggsave("plot_pcoa_bc_inf_combo.png"
       , gg_pcoa_bc_inf_combo
       , height=4, width=10)
<img width="3000" height="1200" alt="plot_pcoa_bc_inf_combo" src="https://github.com/user-attachments/assets/4fa0c5cc-47c1-4a78-8431-e0e1bb17d318" />

### Unweighted Unifrac Distance
unifrac_inf_combo <- distance(ryan_inflamed_combo, method="unifrac")

pcoa_unifrac_inf_combo <- ordinate(ryan_inflamed_combo, method="PCoA", distance=unifrac_inf_combo)

gg_pcoa_unifrac_inf_combo <- plot_ordination(ryan_inflamed_combo, pcoa_unifrac_inf_combo, color = "Medications") +
  labs(col = "Medication")
gg_pcoa_unifrac_inf_combo

ggsave("plot_pcoa_unifrac_inf_combo.png"
       , gg_pcoa_unifrac_inf_combo
       , height=4, width=10)
<img width="3000" height="1200" alt="plot_pcoa_unifrac_inf_combo" src="https://github.com/user-attachments/assets/de9315f3-b9d0-43ca-bb8d-0c0cb090eb1e" />

### Weighted Unifrac Distance
wunifrac_inf_combo <- distance(ryan_inflamed_combo, method="wunifrac")

pcoa_wunifrac_inf_combo <- ordinate(ryan_inflamed_combo, method="PCoA", distance=wunifrac_inf_combo)

gg_pcoa_wunifrac_inf_combo <- plot_ordination(ryan_inflamed_combo, pcoa_wunifrac_inf_combo, color = "Medications") +
  labs(col = "Medication")
gg_pcoa_wunifrac_inf_combo

ggsave("plot_pcoa_wunifrac_inf_combo.png"
       , gg_pcoa_wunifrac_inf
       , height=4, width=10)
<img width="3000" height="1200" alt="plot_pcoa_wunifrac_inf_combo" src="https://github.com/user-attachments/assets/3ca6375d-3e9b-4d5d-bebb-2d6597a1dce6" />

### PERMANOVA Test
#### to determine whether the overall microbial community composition differs with statistical significance between Medication groups

### Bray-Curtis
dat_inf_combo <- data.frame(sample_data(ryan_inflamed_combo))
adonis2(bc_inf_combo ~ Medications, data = dat_inf_combo)

#### p-value of 0.045, statistically significant. Community composition differs significantly between combination medication groups.

#### Re-plot the Bray-Curtis plot but include ellipses to see significant groups
ellip_pcoa_bc_inf_combo <- plot_ordination(ryan_inflamed_combo, pcoa_bc_inf_combo, color = "Medications") +
  labs(col = "Medication")+
  stat_ellipse(type = "norm")
ellip_pcoa_bc_inf_combo

ggsave("ellip_plot_bc_inf_combo.png"
       , ellip_pcoa_bc_inf_combo
       , height=4, width=10)
<img width="3000" height="1200" alt="ellip_plot_bc_inf_combo" src="https://github.com/user-attachments/assets/0a2f20bb-de0e-4209-9a8d-e50f6cb2d4fd" />

#### Run a TukeyHSD post-hoc test to determine between which combination medication groups this statistical significance lies.
pairwise.adonis2(
  bc_inf_combo ~ Medications,
  data = dat_inf_combo,
  p.adjust.m = "BH"
)
#### Significance only between: Mesalamine+corticosteroids_vs_Mesalamine+mercaptopurine+anti-TNF (0.037)

### Unweighted Unifrac
adonis2(unifrac_inf_combo ~ Medications, data=dat_inf_combo)

#### p-value of 0.689, no significant difference in the presence/absence of specific taxa between combination medication groups.


### Weighted Unifrac
adonis2(wunifrac_inf_combo ~ Medications, data=dat_inf_combo)

#### p-value of 0.83, no significant difference in the relative abundance of taxa between combination medication groups.


####################################################################################################################################

## Beta diversity - Non-inflamed ##
### Bray Curtis

bc_ninf_combo <- distance(ryan_noninflamed_combo, method="bray")

pcoa_bc_ninf_combo <- ordinate(ryan_noninflamed_combo, method="PCoA", distance=bc_ninf_combo)

gg_pcoa_bc_ninf_combo <- plot_ordination(ryan_noninflamed_combo, pcoa_bc_ninf_combo, color = "Medications") +
  labs(col = "Medication")
gg_pcoa_bc_ninf_combo

ggsave("plot_pcoa_bc_ninf_combo.png"
       , gg_pcoa_bc_ninf_combo
       , height=4, width=5
)
<img width="1500" height="1200" alt="plot_pcoa_bc_ninf_combo" src="https://github.com/user-attachments/assets/c099bda1-7981-4ced-a6a8-623cfd426c1f" />

### Unweighted Unifrac Distance
unifrac_ninf_combo <- distance(ryan_noninflamed_combo, method="unifrac")

pcoa_unifrac_ninf_combo <- ordinate(ryan_noninflamed_combo, method="PCoA", distance=unifrac_ninf_combo)

gg_pcoa_unifrac_ninf_combo <- plot_ordination(ryan_noninflamed_combo, pcoa_unifrac_ninf_combo, color = "Medications") +
  labs(col = "Medication")+
  stat_ellipse(type = "norm")
gg_pcoa_unifrac_ninf_combo

ggsave("plot_pcoa_unifrac_ninf_combo.png"
       , gg_pcoa_unifrac_ninf_combo
       , height=4, width=5)
<img width="1500" height="1200" alt="plot_pcoa_unifrac_ninf_combo" src="https://github.com/user-attachments/assets/da7bf5b4-39fa-4660-bcc7-2f42601a0e79" />

### Weighted Unifrac Distance
wunifrac_ninf_combo <- distance(ryan_noninflamed_combo, method="wunifrac")

pcoa_wunifrac_ninf_combo <- ordinate(ryan_noninflamed_combo, method="PCoA", distance=wunifrac_ninf_combo)

gg_pcoa_wunifrac_ninf_combo <- plot_ordination(ryan_noninflamed_combo, pcoa_wunifrac_ninf_combo, color = "Medications") +
  labs(col = "Medication")+
  stat_ellipse(type = "norm")
gg_pcoa_wunifrac_ninf_combo

ggsave("plot_pcoa_wunifrac_ninf_combo.png"
       , gg_pcoa_wunifrac_ninf_combo
       , height=4, width=5)
<img width="1500" height="1200" alt="plot_pcoa_wunifrac_ninf_combo" src="https://github.com/user-attachments/assets/0ff7fc58-3c0b-4ca7-9b3f-4effcdf9b717" />

### PERMANOVA Test
#### to determine whether the overall microbial community composition differs with statistical significance between combination medication groups

### Bray-Curtis
ryan_noninflamed_med_combo <- subset_samples(ryan_noninflamed_combo, !is.na(Medications))
dat_ninf_combo <- data.frame(sample_data(ryan_noninflamed_med_combo))
bc_ninf_combo <- distance(ryan_noninflamed_med_combo, method = "bray")

adonis2(bc_ninf_combo ~ Medications, data = dat_ninf_combo)

#### p-value of 0.249 no statistically significant difference in taxa abundance between combination medication groups.


### Unweighted Unifrac
adonis2(unifrac_ninf_combo ~ Medications, data=dat_ninf_combo)

#### p-value of 0.568, no significant difference in the presence/absence of specific taxa between combination medication groups.


### Weighted Unifrac
adonis2(wunifrac_ninf_combo ~ Medications, data=dat_ninf_combo)

#### p-value of 0.934, no significant difference in the relative abundance of taxa between combination medication groups.

