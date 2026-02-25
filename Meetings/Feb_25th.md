# Impact of Medication on the Mucosal Microbiome in IBD

## Research Question
> "How does medication affect the microbiome of individuals with IBD: Crohn's Disease or Ulcerative Colitis?"

## Project Overview
This project utilizes the Ryan Dataset to analyze the spatial and pharmaceutical influences on the gut microbiome. We aim to isolate the effects of specific treatments (Anti-TNF and Mercaptopurine) compared to non-treated individuals and healthy controls, while accounting for the biopsy location as a key predictor.



## Current Status: Meeting Agenda & Action Items

## Data Processing Updates
- [x] **DADA2 Denoising:** Trucation parameters were set to 220bp for both forward and reverse reads. Mean quality score began to decline at about 210bps for forward reads and reverse reads showing a more dramatic drop in quality score at about 170bps. Initial attempts with shorter truncation lengths had insufficient overlap, and thus, unsuccessfull paired-end merging.
- [x] **Table Filtering:** removed mitochondria and chloroplast sequences. Features with total frequency below 5 and with fewer than 100 reads were removed. Leaves us with 2,733 unique features across 342 samples.
- [x] **Rarefaction:** A sampling depth of 6000 was selected to optimise statistical power and data resolution. The majority of sample curves reach a plateau at this sampling depth (as observed in Figure 1). This sampling depth retains 1,512,000 (46.79%) total sequences across 252 (73.68%) samples.

<img src="https://raw.githubusercontent.com/kgagno01/MICB475_Team8/85e997b46d45c9e0af594e43a6396af34466adf4/rarefaction.png" width="800" alt="Figure 1">

***Figure 1. Alpha rarefaction analysis of the 2,733 rescued features.** Rarefaction curves were generated in QIIME 2 using the final feature table to evaluate the relationship between sequencing depth and ASVs. Each line represents a distinct sample, with a maximum sequencing depth of 10,000. The sampling depth for diversity analysis is set to 6,000, as indicated by the red dotted line.*

- [x] **Metadata Categories of Interest:** *Histological Status:* 109 “inflamed” and 143 “non-inflamed” tissue samples retained.
                                       *Medications:* 13 Anti-TNF, 15 Corticosteroids, 16 Mercaptopurine, and 50 Mesalamine samples retained. 

## Analysis (Parallel Tasks)

| Analysis Task | Lead | Objective |
| :--- | :--- | :--- |
| **Diversity Metrics** | Evelyn | Aim 1: Compare the diversity of the biopsy sites in healthy individuals. Aim 2: Analyze alpha and beta diversity metrics of medication use on inflamed vs. non-inflamed tissues. Bin together groups (medications or IBD types) with no distinguishable differences in diversity.|
| **Core Microbiome** | YunYun | Aim 3: Determine the compositional differences of the microbial communities in medicated vs non-medicated tissue samples of patients with IBD. Generate Venn diagrams for shared/unique taxa. |
| **Indicator Taxa** | Ahnaf | Aim 4: Identify indicator taxa significantly associated with inflammatory status and clinical metadata categories.|
| **DESeq2** | Hanna | Aim 5: Identify specific microbial taxa (ASVs) that are significantly increased or decreased in abundance across different tissue conditions and medication groups. |
| **PICRUSt2** | Keryanne | Aim 6: Determine the functional composition and metabolic pathway enrichment of microbial communities in IBD patients across medication groups. | 

## Action item deadlines: 
TBD during meeting
