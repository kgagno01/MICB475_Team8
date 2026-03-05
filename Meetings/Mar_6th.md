# Impact of Medication on the Mucosal Microbiome in IBD

## Research Question
> "How does medication affect the microbiome of individuals with IBD: Crohn's Disease or Ulcerative Colitis?"

## Project Overview
This project utilizes the Ryan Dataset to analyze the spatial and pharmaceutical influences on the gut microbiome. We aim to isolate the effects of specific treatments (Anti-TNF and Mercaptopurine) compared to non-treated individuals and healthy controls, while accounting for the biopsy location as a key predictor.

## Data Processing Updates
- [x] **DADA2 Denoising:** Trucation parameters were set to 220bp for both forward and reverse reads. Mean quality score began to decline at about 210bps for forward reads and reverse reads showing a more dramatic drop in quality score at about 170bps. Initial attempts with shorter truncation lengths had insufficient overlap, and thus, unsuccessfull paired-end merging.
- [x] **Table Filtering:** removed mitochondria and chloroplast sequences. Features with total frequency below 5 and with fewer than 100 reads were removed. Leaves us with 2,733 unique features across 342 samples.
- [x] **Rarefaction:** A sampling depth of 6000 was selected to optimise statistical power and data resolution. The majority of sample curves reach a plateau at this sampling depth (as observed in Figure 1). This sampling depth retains 1,512,000 (46.79%) total sequences across 252 (73.68%) samples.

## Analysis (Parallel Tasks)

| Analysis Task | Lead | Objective |
| :--- | :--- | :--- |
| **Diversity Metrics** | Evelyn | Assess Alpha/Beta diversity for group binning. |
| <mark>**Core Microbiome** | YunYun | Generate Venn diagrams for shared/unique taxa. <mark/>|
| **Indicator Taxa** | Ahnaf | Identify signatures for Anti-TNF vs. Mercaptopurine. |
| **DESeq2** | [Hannah] | Differential abundance in inflamed vs. healthy tissue. |
| **PICRUSt2** | [Kéryanne] | Functional pathway predictions (SCFA, barrier repair). | 

## Current Status: Meeting Agenda & Action Items
Review feedback from paper proposal and submit a revision by.


Complete Core Microbiome analysis for next week with brief description of results.


Fix research proposal:
* Fix citations
* Fix title
* Fix Aim 1
* Fix wording of introduction
