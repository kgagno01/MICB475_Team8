### Load packages
```r
library(tidyverse)
library(phyloseq)
library(DESeq2)
library(ggrepel)
```
### How the categories are spelled
```r
unique(sample_data(ryan_phyloseq)$Histological.status)
unique(sample_data(ryan_phyloseq)$Medications)
```

### 1. SETUP & DIRECTORY
```r
if(!dir.exists("Analysis_Results")) dir.create("Analysis_Results")
setwd("Analysis_Results")
```

### 2. DATA PREPARATION
```r
metadata_df <- as(sample_data(ryan_phyloseq), "data.frame")
metadata_df$Histological.status <- trimws(metadata_df$Histological.status)
metadata_df$Medications <- trimws(metadata_df$Medications)
sample_data(ryan_phyloseq) <- sample_data(metadata_df)
```

### Cleaning taxonomy prefixes (f__, o__) 
```r
tax_info <- as.data.frame(tax_table(ryan_phyloseq)) %>%
  rownames_to_column("row") %>%
  mutate(across(everything(), ~ str_replace(., "^.__", "")))
```

### 3. ANALYSIS FUNCTION WITH SAMPLE CHECK
```r
run_analysis <- function(ps_obj, tissue_val, group_label, test_med, ref_med) {
  
  meta <- as(sample_data(ps_obj), "data.frame")
  
  # Filter for specific tissue and medications
  sub_meta <- meta %>%
    filter(Histological.status == tissue_val, 
           Medications %in% c(test_med, ref_med))
  
  n_test <- sum(sub_meta$Medications == test_med)
  n_ref <- sum(sub_meta$Medications == ref_med)
  
  # DESeq2 requires at least 2 replicates per group to estimate dispersion
  if(n_test < 2 | n_ref < 2) {
    message(paste0("!!! SKIPPING ", group_label, " (", tissue_val, "): Insufficient samples."))
    message(paste0("    - ", test_med, ": ", n_test, " sample(s)"))
    message(paste0("    - ", ref_med, ": ", n_ref, " sample(s)"))
    return(NULL)
  }
  
  keep_samples <- rownames(sub_meta)
```
  
  ### Subset and DESeq2 processing
  ```r
  ps_sub <- prune_samples(keep_samples, ps_obj)
  ps_sub <- prune_taxa(taxa_sums(ps_sub) > 0, ps_sub)
  ps_p1 <- transform_sample_counts(ps_sub, function(x) x + 1)
  ds <- phyloseq_to_deseq2(ps_p1, ~ Medications)
  ds <- DESeq(ds)
  res <- results(ds, tidy = TRUE, contrast = c("Medications", test_med, ref_med))
```
  
  ### 4. Resolving ONLY to Family level
  ```r
  res_named <- res %>%
    left_join(tax_info, by = "row") %>%
    mutate(significant = padj < 0.01 & abs(log2FoldChange) > 2) %>%
    mutate(Short_ID = str_sub(row, -4))
```
  
  res_named$Base_Name <- "U" 
  
  ### Using Family as the primary taxonomic label
  ```r
  if("Family" %in% colnames(res_named)) {
    res_named$Base_Name <- ifelse(!is.na(res_named$Family), res_named$Family, res_named$Base_Name)
  }
  
  # Label only if significant and NOT "U" (unclassified at Family level)
  res_named <- res_named %>%
    mutate(Label = ifelse(significant == TRUE & Base_Name != "U", 
                          paste0(Base_Name, " [", Short_ID, "]"), 
                          NA))
```
  
  ### 5. VOLCANO PLOT
  ```r
  p <- ggplot(res_named, aes(x = log2FoldChange, y = -log10(padj), col = significant)) +
    geom_point(alpha = 0.5, size = 1.5) + 
    geom_text_repel(aes(label = Label), 
                    size = 3, 
                    fontface = "italic", 
                    max.overlaps = Inf, 
                    box.padding = 0.5,
                    point.padding = 0.3,
                    force = 2, 
                    segment.alpha = 0.4,
                    show.legend = FALSE) +
    theme_minimal(base_size = 11) + 
    scale_color_manual(values = c("grey70", "firebrick3")) +
    labs(title = paste(group_label, ":", test_med, "vs", ref_med),
         subtitle = paste("Tissue:", tissue_val, "| Resolved to Family Level"),
         x = "Log2 Fold Change", y = "-Log10 Adjusted P-value",
         caption = "Labeled: Significant Family. Unlabeled: Unclassified at Family level or non-significant.") +
    theme(
      plot.title = element_text(face = "bold"),
      plot.caption = element_text(hjust = 0, size = 8, face = "italic", color = "grey30")
    )
```
  
  ### 6. SAVE
  ```r
  file_id <- paste0(group_label, "_", gsub(" ", "_", tissue_val))
  write_csv(res_named, paste0("Results_Data_", file_id, ".csv"))
  ggsave(paste0("Volcano_Family_", file_id, ".png"), plot = p, width = 9, height = 7, dpi = 300)
  
  return(p)
}
```

### 7. EXECUTE ALL COMPARISONS
### Updated G3 to Corticosteroids+mesalamine+mercaptopurine
```r
run_analysis(ryan_phyloseq, "Inflamed tissue", "G1", "Corticosteroids", "No")
run_analysis(ryan_phyloseq, "Noninflamed tissue", "G1", "Corticosteroids", "No")

run_analysis(ryan_phyloseq, "Inflamed tissue", "G2", "Mesalamine+corticosteroids", "No")
run_analysis(ryan_phyloseq, "Noninflamed tissue", "G2", "Mesalamine+corticosteroids", "No")

run_analysis(ryan_phyloseq, "Inflamed tissue", "G3", "Corticosteroids+mesalamine+mercaptopurine", "No")
run_analysis(ryan_phyloseq, "Noninflamed tissue", "G3", "Corticosteroids+mesalamine+mercaptopurine", "No")
```

run_analysis(ryan_phyloseq, "Inflamed tissue", "G4", "Corticosteroids", "Mesalamine")
run_analysis(ryan_phyloseq, "Noninflamed tissue", "G4", "Corticosteroids", "Mesalamine")

run_analysis(ryan_phyloseq, "Inflamed tissue", "G5", "Mesalamine", "No")
run_analysis(ryan_phyloseq, "Noninflamed tissue", "G5", "Mesalamine", "No")
