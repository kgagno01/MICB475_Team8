#Picrust 2 analysis

####Packages to install for analysis####
# install.packages("devtools")
# devtools::install_github("cafferychen777/ggpicrust2")
# install.packages('MicrobiomeStat')
# BiocManager::install("KEGGREST")
# install.packages("GGally")
# install.packages("ggpicrust2")
# install.packages("pheatmap")

library(tidyverse)
library(phyloseq)
library(ggpicrust2)

####Loading the phyloseq object, the KO file and extracting the metadata####
load("ryan_phyloseq.RData")

ko <- read.delim("pred_metagenome_unstrat.tsv", row.names = 1)

meta <- ryan_phyloseq %>% .@sam_data %>% data.frame() %>% 
  rownames_to_column('sample_name')

####Filtering out the data to only keep the 5 medication groups of interest and the inflamed data####
# Medication groups of interest:
#   1. No
#   2. Corticosteroid
#   3. Mesalamine
#   4. Corticosteroid + Mesalamine
#   5. Corticosteroid + Mesalamine + Mercaptopurine

#Filtering for inflamed tissues
inflamed <- meta %>% filter(Histological.status == "Inflamed tissue ")

#Filtering for non-inflamed tissues
noninflamed <- meta %>% filter(Histological.status == "Noninflamed tissue ")

#Filtering for medication groups of interest and inflamed tissues
medication <- meta %>% filter(Medications %in% c("No", "Corticosteroisd", "Mesalamine", "Mesalamine+corticosteroids", "Mesalamine+corticosteroids+mercaptopurine"))
medication_inflamed <- medication %>% filter(Histological.status == "Noninflamed tissue ")

#Filtering KO file for medication groups of interest and inflamed tissue
ko_filt <-  ko %>% select(all_of(medication_inflamed$sample_name))

####Differential abundance analysis####
# Perform pathway differential abundance analysis (DAA) using LinDA method
daa_results_df <- pathway_daa(abundance = ko_filt,
                             metadata = medication_inflamed, 
                             group = "Medications", 
                             daa_method = "LinDA", 
                             select = NULL, reference = NULL)

# Annotate pathway results using KO to KEGG conversion
daa_annotated_results_df <- pathway_annotation(pathway = "KO",
                                              daa_results_df = daa_results_df,
                                              ko_to_kegg = TRUE)
