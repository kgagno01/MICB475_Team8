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


Aim 1 and 2 updates - Evelyn
## Aim 1 plots:

<img width="1800" height="1200" alt="ryan_richness" src="https://github.com/user-attachments/assets/7d6bfdd3-628c-4c92-bd3b-175022229033" />
Figure 1: Shannon index (alpha diversity) in healthy patients across colon biopsy locations.

<img width="1800" height="1200" alt="ryan_pd" src="https://github.com/user-attachments/assets/c83fc020-3cc8-4e0a-926d-235a0c2f58f4" />
Figure 2: Faith’s Phylogenetic Distance (alpha diversity) in healthy patients across colon biopsy locations. *** should edit x-axis labels and regenerate plot

<img width="1500" height="1200" alt="plot_pcoa_bc" src="https://github.com/user-attachments/assets/84c63b34-804d-4f19-86c2-73e8da53c7a9" />
Figure 3: Bray Curtis (beta diversity) PCoA plot, distribution of taxa abundance between biopsy locations in healthy patients.

<img width="1500" height="1200" alt="plot_pcoa_unifrac" src="https://github.com/user-attachments/assets/5e4febe3-69db-4e50-876a-bd1d5907e91d" />
Figure 4: Unifrac Distance (beta diversity) PCoA plot, distribution of taxa presence/absence between biopsy locations in healthy patients.

<img width="1500" height="1200" alt="plot_pcoa_wunifrac" src="https://github.com/user-attachments/assets/7ce07fe5-14f7-4a48-aa5b-713e8243eda7" />
Figure 5: Weighted Unifrac Distance (beta diversity), PCoA plot, distribution of the taxa abundance using the phylogenetic tree between biopsy locations in healthy patients.


## Aim 2 plots:

## *Inflammed*

<img width="1800" height="1200" alt="ryan_richness_inf" src="https://github.com/user-attachments/assets/e04bf462-b49d-43ff-8eae-af6a5cb98ce0" />
Figure 6: Shannon Index (alpha diversity) in inflamed samples across medication groups.

<img width="1800" height="1200" alt="ryan_pd_inf" src="https://github.com/user-attachments/assets/eeee337d-8da8-4fca-9e2e-91b8738f3f0c" />
Figure 7: Faith’s Phylogenetic Diversity (alpha diversity) in inflamed samples across medication groups. *** should edit x-axis labels and regenerate plot

<img width="3000" height="1200" alt="ellip_plot_bc_inf" src="https://github.com/user-attachments/assets/374f86c7-e078-4adc-8868-750ed4544ab8" />
Figure 8: Bray Curtis (beta diversity) PCoA plot, distribution of taxa abundance between medication groups in inflamed samples.

<img width="3000" height="1200" alt="ellip_plot_unifrac_inf" src="https://github.com/user-attachments/assets/333bd7c6-6204-44e0-94fc-cc086a6bb414" />
Figure 9: Unifrac Distance (beta diversity) PCoA plot, distribution of taxa presence/absence between medication groups in inflamed samples.

<img width="3000" height="1200" alt="ellip_plot_wunifrac_inf" src="https://github.com/user-attachments/assets/c5d23f7f-c7c7-4abe-a231-a91cf46433af" />
Figure 10: Weighted Unifrac Distance (beta diversity), PCoA plot, distribution of the taxa abundance using the phylogenetic tree between medication groups in inflamed samples.

## *Non-Inflamed*

<img width="1800" height="1200" alt="ryan_richness_ninf" src="https://github.com/user-attachments/assets/bb14af04-08e1-4fc2-b430-4aa26059be84" />
Figure 11: Shannon index (alpha diversity) in non-inflamed samples across medication groups.

<img width="1800" height="1200" alt="ryan_pd_ninf" src="https://github.com/user-attachments/assets/4e23f36a-1325-46dd-82ff-4d92f884e783" />
Figure 12: Faith’s Phylogenetic Diversity (alpha diversity) in non-inflamed samples across medication groups. *** should edit x-axis labels and regenerate plot

<img width="3000" height="1200" alt="ellip_plot_bc_ninf" src="https://github.com/user-attachments/assets/741fbd25-038a-456d-aca2-9b8ede7df7a6" />
Figure 13: Bray Curtis (beta diversity) PCoA plot, distribution of taxa abundance between medication groups in non-inflamed samples.

<img width="1500" height="1200" alt="plot_pcoa_unifrac_ninf" src="https://github.com/user-attachments/assets/a7c53c2b-1ac0-4555-a669-8a628fbca8c3" />
Figure 14: Unifrac Distance (beta diversity) PCoA plot, distribution of taxa presence/absence between medication groups in inflamed samples. No medication groups present.

<img width="1500" height="1200" alt="plot_pcoa_wunifrac_ninf" src="https://github.com/user-attachments/assets/1230c152-a267-402d-96cf-2d2d7812dfb9" />
Figure 15: Weighted Unifrac Distance (beta diversity), PCoA plot, distribution of the taxa abundance using the phylogenetic tree between medication groups in inflamed samples. No medication groups present.


