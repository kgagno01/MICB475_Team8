############################################################
# AIM 4: Indicator taxa analysis in inflamed IBD tissues
# Final school-style workflow
# Feature-level ISA with taxonomy mapping
# Includes presentation-ready tables
############################################################

############################
# 1) Load packages
############################
library(tidyverse)
library(tibble)
library(phyloseq)
library(indicspecies)
library(permute)
library(pheatmap)

############################
# 2) Create output folders
############################
dir.create("indicator_taxa_plots", showWarnings = FALSE)
dir.create("indicator_taxa_csv", showWarnings = FALSE)
dir.create("indicator_taxa_tables", showWarnings = FALSE)

############################
# 3) Import feature table
############################
otu_raw <- read.delim(
  "feature-table.txt",
  sep = "\t",
  header = TRUE,
  skip = 1,
  check.names = FALSE,
  stringsAsFactors = FALSE
)

colnames(otu_raw)[1] <- "FeatureID"

otu_mat <- otu_raw %>%
  column_to_rownames("FeatureID") %>%
  as.matrix()

mode(otu_mat) <- "numeric"

############################
# 4) Import metadata
############################
meta <- read.delim(
  "ryan_metadata.tsv",
  sep = "\t",
  header = TRUE,
  check.names = FALSE,
  stringsAsFactors = FALSE
)

meta <- meta %>%
  mutate(
    `sample-id` = as.character(`sample-id`),
    Subject = as.character(Subject),
    Condition = as.character(Condition),
    `Histological.status` = as.character(`Histological.status`),
    Medications = as.character(Medications)
  ) %>%
  mutate(
    HistologyGroup = case_when(
      str_detect(`Histological.status`, regex("Noninflamed|Non-inflamed", ignore_case = TRUE)) ~ "Noninflamed",
      str_detect(`Histological.status`, regex("Inflamed", ignore_case = TRUE)) ~ "Inflamed",
      TRUE ~ NA_character_
    ),
    ConditionGroup = case_when(
      str_detect(Condition, regex("Crohn", ignore_case = TRUE)) ~ "CD",
      str_detect(Condition, regex("Ulcerative", ignore_case = TRUE)) ~ "UC",
      str_detect(Condition, regex("healthy|control", ignore_case = TRUE)) ~ "Healthy",
      TRUE ~ Condition
    )
  )

############################
# 5) Import taxonomy
############################
tax_raw <- read.delim(
  "taxonomy.tsv",
  sep = "\t",
  header = TRUE,
  check.names = FALSE,
  stringsAsFactors = FALSE
)

colnames(tax_raw)[1:2] <- c("FeatureID", "Taxon")

tax_parsed <- tax_raw %>%
  select(FeatureID, Taxon) %>%
  separate(
    Taxon,
    into = c("Kingdom", "Phylum", "Class", "Order", "Family", "Genus", "Species"),
    sep = ";\\s*",
    fill = "right",
    extra = "drop"
  ) %>%
  mutate(across(-FeatureID, ~ stringr::str_remove(.x, "^[dkpcofgs]__"))) %>%
  mutate(
    Kingdom = as.character(Kingdom),
    Phylum = as.character(Phylum),
    Class = as.character(Class),
    Order = as.character(Order),
    Family = as.character(Family),
    Genus = as.character(Genus),
    Species = as.character(Species)
  )

tax_mat <- tax_parsed %>%
  column_to_rownames("FeatureID") %>%
  as.matrix()

############################
# 6) Match samples and taxa
############################
meta2 <- meta %>%
  filter(`sample-id` %in% colnames(otu_mat))

rownames(meta2) <- meta2$`sample-id`

common_taxa <- intersect(rownames(otu_mat), rownames(tax_mat))

otu_mat2 <- otu_mat[common_taxa, , drop = FALSE]
tax_mat2 <- tax_mat[common_taxa, , drop = FALSE]

otu_mat2 <- otu_mat2[, rownames(meta2), drop = FALSE]

############################
# 7) Build phyloseq object
############################
ps <- phyloseq(
  otu_table(otu_mat2, taxa_are_rows = TRUE),
  tax_table(tax_mat2),
  sample_data(meta2)
)

############################
# 8) Filter taxa and samples
############################
ps_filt <- subset_taxa(ps, is.na(Order) | Order != "Chloroplast")
ps_filt <- subset_taxa(ps_filt, is.na(Family) | Family != "Mitochondria")

prev <- apply(otu_table(ps_filt), 1, function(x) sum(x > 0) / length(x))
ps_filt <- prune_taxa(prev >= 0.10, ps_filt)

tot <- taxa_sums(ps_filt)
ps_filt <- prune_taxa(tot >= 10, ps_filt)

ps_filt <- prune_samples(sample_sums(ps_filt) >= 1000, ps_filt)

############################
# 9) Create medication groups
############################
sd <- data.frame(sample_data(ps_filt), stringsAsFactors = FALSE)

sd <- sd %>%
  mutate(
    meds_raw = str_to_lower(str_trim(Medications)),
    meds_raw = str_replace_all(meds_raw, "\\s+", ""),
    
    has_cor = str_detect(meds_raw, "corticosteroid") |
      str_detect(meds_raw, "cort") |
      str_detect(meds_raw, "predni") |
      str_detect(meds_raw, "steroid"),
    
    has_mes = str_detect(meds_raw, "mesalamine") |
      str_detect(meds_raw, "5-asa"),
    
    has_mer = str_detect(meds_raw, "mercaptopurine") |
      str_detect(meds_raw, "6-mp") |
      str_detect(meds_raw, "thiopur"),
    
    has_tnf = str_detect(meds_raw, "anti-tnf") |
      str_detect(meds_raw, "inflix") |
      str_detect(meds_raw, "adalim"),
    
    no_meds = meds_raw %in% c("no", "none", "")
  ) %>%
  mutate(
    MedGroup = case_when(
      no_meds ~ "NoMeds",
      has_cor & !has_mes & !has_mer & !has_tnf ~ "Cor_only",
      has_mes & !has_cor & !has_mer & !has_tnf ~ "Mes_only",
      has_cor & has_mes & !has_mer & !has_tnf ~ "Cor_Mes",
      has_tnf & has_mes & has_mer ~ "Triple_Therapy",
      TRUE ~ "Other"
    )
  )

sample_data(ps_filt)$MedGroup <- as.character(sd$MedGroup)

############################
# 10) Restrict to inflamed IBD tissues
############################
ps_infl <- subset_samples(ps_filt, HistologyGroup == "Inflamed")
ps_infl <- prune_samples(sample_sums(ps_infl) > 0, ps_infl)

ps_infl <- subset_samples(ps_infl, ConditionGroup %in% c("CD", "UC"))
ps_infl <- prune_samples(sample_sums(ps_infl) > 0, ps_infl)

############################
# 11) Clean taxonomy labels
############################
psS <- ps_infl

taxdf <- as.data.frame(tax_table(psS), stringsAsFactors = FALSE)
taxdf[] <- lapply(taxdf, as.character)

if (!"Species" %in% colnames(taxdf)) {
  stop("Species column not found in taxonomy table.")
}

taxdf$Family <- trimws(taxdf$Family)
taxdf$Genus <- trimws(taxdf$Genus)
taxdf$Species <- trimws(taxdf$Species)

taxdf$Family[is.na(taxdf$Family) | taxdf$Family == ""] <- "Unclassified_Family"
taxdf$Genus[is.na(taxdf$Genus) | taxdf$Genus == ""] <- "Unclassified_Genus"
taxdf$Species[is.na(taxdf$Species) | taxdf$Species == ""] <- "Unclassified_Species"

tax_table(psS) <- tax_table(as.matrix(taxdf))

############################
# 12) Helper function:
# get associated group from index
############################
get_associated_group <- function(df, comparison_name) {
  group1 <- unique(df$ComparisonGroup1)
  group2 <- unique(df$ComparisonGroup2)
  
  assoc <- ifelse(df$index == 1, group1, ifelse(df$index == 2, group2, "Unknown"))
  return(assoc)
}

############################
# 13) School-style ISA function
############################
run_indicator_analysis_school <- function(ps_obj, groups, comparison_name, nperm = 999) {
  
  sd_df <- data.frame(sample_data(ps_obj), stringsAsFactors = FALSE)
  sd_df$MedGroup <- as.character(sd_df$MedGroup)
  groups <- as.character(groups)
  
  keep_samples <- rownames(sd_df)[sd_df$MedGroup %in% groups]
  
  if (length(keep_samples) == 0) {
    message("Skipping comparison: ", comparison_name, " (no matching samples found)")
    return(list(
      comparison = comparison_name,
      groups = groups,
      group_counts = table(character(0)),
      isa_output = NULL,
      isa_sig = data.frame(),
      summary_df = data.frame(),
      matrix = NULL
    ))
  }
  
  ps_sub <- prune_samples(keep_samples, ps_obj)
  ps_sub <- prune_samples(sample_sums(ps_sub) > 0, ps_sub)
  ps_sub <- prune_taxa(taxa_sums(ps_sub) > 0, ps_sub)
  
  meta_sub <- data.frame(sample_data(ps_sub), stringsAsFactors = FALSE)
  grp <- as.character(meta_sub$MedGroup)
  names(grp) <- rownames(meta_sub)
  
  grp_counts <- table(grp)
  
  cat("\n============================\n")
  cat("Comparison:", comparison_name, "\n")
  cat("Groups requested:", paste(groups, collapse = " vs "), "\n")
  print(grp_counts)
  
  if (length(unique(grp)) < 2) {
    message("Skipping comparison: ", comparison_name, " (fewer than 2 groups present)")
    return(list(
      comparison = comparison_name,
      groups = groups,
      group_counts = grp_counts,
      isa_output = NULL,
      isa_sig = data.frame(),
      summary_df = data.frame(),
      matrix = NULL
    ))
  }
  
  ps_rel <- transform_sample_counts(ps_sub, function(x) {
    if (sum(x) == 0) return(x)
    x / sum(x)
  })
  
  X <- as(otu_table(ps_rel), "matrix")
  if (taxa_are_rows(ps_rel)) {
    X <- t(X)
  }
  
  meta_rel <- data.frame(sample_data(ps_rel), stringsAsFactors = FALSE)
  grp <- as.character(meta_rel$MedGroup)
  names(grp) <- rownames(meta_rel)
  grp <- grp[rownames(X)]
  
  if (!is.vector(grp) || length(grp) != nrow(X)) {
    stop("Group vector is not aligned properly with the OTU matrix.")
  }
  
  set.seed(123)
  isa_output <- multipatt(
    X,
    cluster = grp,
    func = "IndVal.g",
    control = how(nperm = nperm)
  )
  
  cat("\n--- multipatt summary ---\n")
  print(summary(isa_output))
  
  isa_sig <- isa_output$sign %>%
    as.data.frame() %>%
    rownames_to_column("FeatureID") %>%
    filter(p.value < 0.05) %>%
    arrange(p.value)
  
  tax_df <- as.data.frame(tax_table(ps_rel), stringsAsFactors = FALSE) %>%
    rownames_to_column("FeatureID") %>%
    mutate(
      Family = ifelse(is.na(Family) | Family == "", "Unclassified_Family", Family),
      Genus = ifelse(is.na(Genus) | Genus == "", "Unclassified_Genus", Genus),
      Species = ifelse(is.na(Species) | Species == "", "Unclassified_Species", Species)
    )
  
  summary_df <- left_join(isa_sig, tax_df, by = "FeatureID") %>%
    mutate(
      Comparison = comparison_name,
      ComparisonGroup1 = groups[1],
      ComparisonGroup2 = groups[2],
      DisplayTaxon = case_when(
        Species != "Unclassified_Species" ~ Species,
        Genus != "Unclassified_Genus" ~ paste0(Genus, " (genus-level)"),
        Family != "Unclassified_Family" ~ paste0(Family, " (family-level)"),
        TRUE ~ FeatureID
      )
    )
  
  cat("\nSignificant taxa found:", nrow(summary_df), "\n")
  print(summary_df)
  
  file_tag <- gsub("[^A-Za-z0-9]+", "_", comparison_name)
  
  write.csv(
    summary_df,
    file = file.path("indicator_taxa_csv", paste0("ISA_", file_tag, ".csv")),
    row.names = FALSE
  )
  
  if (nrow(summary_df) > 0) {
    top_features <- intersect(summary_df$FeatureID, colnames(X))
    
    if (length(top_features) > 0) {
      X_top <- X[, top_features, drop = FALSE]
      
      display_names <- summary_df$DisplayTaxon[match(colnames(X_top), summary_df$FeatureID)]
      display_names[is.na(display_names)] <- colnames(X_top)[is.na(display_names)]
      colnames(X_top) <- make.unique(display_names)
      
      ann <- data.frame(
        MedGroup = grp,
        row.names = rownames(X_top)
      )
      
      png(
        filename = file.path("indicator_taxa_plots", paste0(file_tag, "_heatmap.png")),
        width = 1800,
        height = 1400,
        res = 200
      )
      pheatmap(
        log10(X_top + 1e-4),
        annotation_row = ann,
        main = paste("Indicator taxa:", comparison_name),
        cluster_rows = nrow(X_top) >= 2,
        cluster_cols = ncol(X_top) >= 2
      )
      dev.off()
    }
  }
  
  return(list(
    comparison = comparison_name,
    groups = groups,
    group_counts = grp_counts,
    isa_output = isa_output,
    isa_sig = isa_sig,
    summary_df = summary_df,
    matrix = X
  ))
}

############################
# 14) Define G1-G5 comparisons
############################
comparisons <- list(
  list(groups = c("Cor_only", "NoMeds"), comparison_name = "G1 Corticosteroids Only vs No Medication"),
  list(groups = c("Cor_Mes", "NoMeds"), comparison_name = "G2 Corticosteroids Plus Mesalamine vs No Medication"),
  list(groups = c("Triple_Therapy", "NoMeds"), comparison_name = "G3 Triple Therapy vs No Medication"),
  list(groups = c("Cor_only", "Mes_only"), comparison_name = "G4 Corticosteroids Only vs Mesalamine Only"),
  list(groups = c("Mes_only", "NoMeds"), comparison_name = "G5 Mesalamine Only vs No Medication")
)

############################
# 15) Run all comparisons
############################
results_list <- list()

for (i in seq_along(comparisons)) {
  comp <- comparisons[[i]]
  
  results_list[[comp$comparison_name]] <- run_indicator_analysis_school(
    ps_obj = psS,
    groups = comp$groups,
    comparison_name = comp$comparison_name
  )
}

############################
# 16) Combined significant taxa table
############################
summary_table <- bind_rows(
  lapply(results_list, function(x) {
    if (!is.null(x$summary_df) && nrow(x$summary_df) > 0) {
      x$summary_df
    } else {
      NULL
    }
  })
)

print(summary_table)

############################
# 17) Presentation table function
############################
clean_isa_table <- function(df) {
  
  if (is.null(df) || nrow(df) == 0) {
    return(data.frame())
  }
  
  df %>%
    mutate(
      AssociatedGroup = ifelse(index == 1, ComparisonGroup1, ifelse(index == 2, ComparisonGroup2, "Unknown")),
      Taxon = DisplayTaxon,
      Family = ifelse(is.na(Family) | Family == "", "Unclassified_Family", Family),
      Genus = ifelse(is.na(Genus) | Genus == "", "Unclassified_Genus", Genus)
    ) %>%
    select(
      Comparison,
      Taxon,
      Family,
      Genus,
      AssociatedGroup,
      stat,
      p.value
    ) %>%
    rename(
      IndVal = stat,
      p_value = p.value
    ) %>%
    arrange(p_value, desc(IndVal))
}

############################
# 18) Top-5 table function
############################
clean_top5 <- function(df) {
  if (is.null(df) || nrow(df) == 0) {
    return(data.frame())
  }
  df %>% slice_head(n = 5)
}

############################
# 19) Make clean presentation tables
############################
clean_tables <- lapply(results_list, function(x) {
  if (!is.null(x$summary_df) && nrow(x$summary_df) > 0) {
    clean_isa_table(x$summary_df)
  } else {
    NULL
  }
})

############################
# 20) Save one clean table per comparison
############################
result_names <- names(results_list)

for (i in seq_along(clean_tables)) {
  if (!is.null(clean_tables[[i]]) && nrow(clean_tables[[i]]) > 0) {
    write.csv(
      clean_tables[[i]],
      file = file.path(
        "indicator_taxa_tables",
        paste0("PresentationTable_", gsub("[^A-Za-z0-9]+", "_", result_names[i]), ".csv")
      ),
      row.names = FALSE
    )
  }
}

############################
# 21) Save one top-5 table per comparison
############################
clean_tables_top5 <- lapply(clean_tables, function(x) {
  if (!is.null(x) && nrow(x) > 0) {
    clean_top5(x)
  } else {
    NULL
  }
})

for (i in seq_along(clean_tables_top5)) {
  if (!is.null(clean_tables_top5[[i]]) && nrow(clean_tables_top5[[i]]) > 0) {
    write.csv(
      clean_tables_top5[[i]],
      file = file.path(
        "indicator_taxa_tables",
        paste0("PresentationTable_TOP5_", gsub("[^A-Za-z0-9]+", "_", result_names[i]), ".csv")
      ),
      row.names = FALSE
    )
  }
}

############################
# 22) Combined clean presentation table
############################
presentation_summary_table <- bind_rows(
  lapply(clean_tables, function(x) {
    if (!is.null(x) && nrow(x) > 0) x else NULL
  })
)

write.csv(
  presentation_summary_table,
  file = file.path("indicator_taxa_tables", "PresentationTable_ALL_Comparisons.csv"),
  row.names = FALSE
)

############################
# 23) Combined top-5 presentation table
############################
presentation_top5_table <- bind_rows(
  lapply(clean_tables_top5, function(x) {
    if (!is.null(x) && nrow(x) > 0) x else NULL
  })
)

write.csv(
  presentation_top5_table,
  file = file.path("indicator_taxa_tables", "PresentationTable_TOP5_ALL_Comparisons.csv"),
  row.names = FALSE
)

############################
# 24) Save outputs
############################
save(
  ps, ps_filt, ps_infl, psS,
  results_list, summary_table,
  clean_tables, clean_tables_top5,
  presentation_summary_table, presentation_top5_table,
  file = "aim4_indicator_taxa_final_with_tables.RData"
)

write.csv(
  summary_table,
  "aim4_indicator_taxa_final_summary.csv",
  row.names = FALSE
)

############################
# 25) Final checks
############################
cat("\n=== Final MedGroup counts in inflamed IBD subset ===\n")
print(table(sample_data(ps_infl)$MedGroup, useNA = "ifany"))

cat("\n=== Medications classified as 'Other' ===\n")
print(
  unique(
    data.frame(sample_data(ps_infl), stringsAsFactors = FALSE)$Medications[
      data.frame(sample_data(ps_infl), stringsAsFactors = FALSE)$MedGroup == "Other"
    ]
  )
)

cat("\n=== Available taxonomy ranks ===\n")
print(rank_names(psS))

cat("\n=== Output files created ===\n")
cat("Folder: indicator_taxa_csv -> raw ISA result tables per comparison\n")
cat("Folder: indicator_taxa_plots -> heatmaps per comparison\n")
cat("Folder: indicator_taxa_tables -> presentation-ready tables\n")
