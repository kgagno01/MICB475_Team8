# Investigating the Effects of Medication on the Colonic Microbial Diversity in Individuals with IBD

Team 8: Kéryanne Gagnon, Ahnaf Kabir, Evelyn Mitchell, Hanna Wang, Yun Yun Wei

This repository contains the Aim 3, 4 and 5 analysis of colonic mucosal biopsies (Ryan et al. dataset) to determine how pharmacotherapy influences microbial signatures in inflamed vs. non-inflamed tissues.

## Meeting Agenda: March 2026

### 1. Project Status Overview
* Aim 1: Spatial variation across healthy colonic biopsy sites. (Status: Completed)
* Aim 2: Impact of medication on community alpha and beta diversity. (Status: Completed)
* Aim 3: Core microbiome identification (Medicated vs. Non-medicated). (Status: Completed - Peer Task)
* Aim 4: Indicator taxa associated with inflammation and metadata. (Status: Completed - Peer Task)
* Aim 5: Differential abundance of specific species via DESeq2. (Status: Completed - Hanna Wang)

### 2. Technical Note on Sample Sizes
* Statistical Constraint: While the pipeline was designed to analyze both inflamed and non-inflamed tissues, it was determined that across all comparison groups (G1-G5), there were insufficient sample sizes within the non-inflamed cohort to perform statistically robust differential abundance testing. 
* Result Scope: Consequently, the following Aim 5 results and associated volcano plots focus exclusively on comparisons within inflamed tissues.

---

### 3. Aim 3: Core Microbiome Results - Yunyun

### Figure 1: G1: Corticosteroids only vs All Inflamed
<img src="https://raw.githubusercontent.com/kgagno01/MICB475_Team8/5c583d6b82e4a156761e72cdf6eb4c3f4913b5fa/Project_2/Figures/venn_G1_inflamed.png" alt="G1 Inflamed Venn" width="700">

### Figure 2: G1: Corticosteroids only vs All Noninflamed
<img src="https://raw.githubusercontent.com/kgagno01/MICB475_Team8/7a473f280056ed8dc1e0f097642b006cfc366195/Project_2/Figures/venn_G1_noninflamed.png" alt="G1 Noninflamed Venn" width="700">

### Figure 3: G2: Corticosteroids + Mesalamine vs No medication in Inflamed tissues
<img src="https://raw.githubusercontent.com/kgagno01/MICB475_Team8/c3631aa9f8c4d8eb89caf07e192207ed9a48e5fb/Project_2/Figures/venn_G2_inflamed.png" alt="Venn Diagram G2 Inflamed" width="600">

### Figure 4: G2: Corticosteroids + Mesalamine vs No medication in Noninflamed tissues
<img src="https://raw.githubusercontent.com/kgagno01/MICB475_Team8/7a473f280056ed8dc1e0f097642b006cfc366195/Project_2/Figures/venn_G2_noninflamed.png" alt="Venn Diagram G2 Non-inflamed" width="600">

### Figure 5: G3: Corticosteroid combinations vs No medication in Inflamed tissues
<img src="https://raw.githubusercontent.com/kgagno01/MICB475_Team8/7a473f280056ed8dc1e0f097642b006cfc366195/Project_2/Figures/venn_G3_inflamed.png" alt="Venn Diagram G3 Inflamed" width="600">

### Figure 6: G3: Corticosteroid combinations vs No medication in Noninflamed tissues
<img src="https://raw.githubusercontent.com/kgagno01/MICB475_Team8/7a473f280056ed8dc1e0f097642b006cfc366195/Project_2/Figures/venn_G3_noninflamed.png" alt="Venn Diagram G3 Non-inflamed" width="600">

### Figure 7: G4: Corticosteroids only vs Mesalamine only in Inflamed tissues
<img src="https://raw.githubusercontent.com/kgagno01/MICB475_Team8/7a473f280056ed8dc1e0f097642b006cfc366195/Project_2/Figures/venn_G4_inflamed.png" alt="Venn Diagram G4 Inflamed" width="600">

### Figure 8: G4: Corticosteroids only vs Mesalamine only in Noninflamed tissues
<img src="https://raw.githubusercontent.com/kgagno01/MICB475_Team8/7a473f280056ed8dc1e0f097642b006cfc366195/Project_2/Figures/venn_G4_noninflamed.png" alt="Venn Diagram G4 Non-inflamed" width="600">

### Figure 9: G5: Mesalamine only vs No medication in Inflamed tissues
<img src="https://raw.githubusercontent.com/kgagno01/MICB475_Team8/7a473f280056ed8dc1e0f097642b006cfc366195/Project_2/Figures/venn_G5_inflamed.png" alt="Venn Diagram G5 Inflamed" width="600">

### Figure 10: G5: Mesalamine only vs No medication in Noninflamed tissues
<img src="https://raw.githubusercontent.com/kgagno01/MICB475_Team8/7a473f280056ed8dc1e0f097642b006cfc366195/Project_2/Figures/venn_G5_noninflamed.png" alt="Venn Diagram G5 Non-inflamed" width="600">

---

### 4. Aim 4: Indicator Taxa Results - Ahnaf
* Status: Analysis complete.
* Peer Task Placeholder: [Peers to insert ranked set of discriminating taxa and statistical significance measures here].

---

### 5. Aim 5: Differential Abundance (DESeq2) - Hanna
Analysis performed using a negative binomial distribution with a pseudo-count (+1) transformation. Only significant taxa with a known Family or Genus are labeled for clarity.

#### Comparison Results Summary (Inflamed Tissue Only)

| Comparison Group | Primary Enriched Taxa | Primary Depleted Taxa |
| :--- | :--- | :--- |
| G1: Corticosteroids vs No | Oscillospiraceae (f) | Sutterella, Geofilum |
| G2: Mesalamine + Cortico vs No | Segatella, Anaerosphaera | Sutterella, Geofilum, Coprobacter |
| G3: Triple Therapy vs No | Paralactobacillus, Marinilabiliaceae | Phocea, Incertae Sedis |
| G4: Cortico vs Mesalamine | Lachnospiraceae (f), UCG-002 | Geofilum, Sutterella |
| G5: Mesalamine vs No | Segatella, Porphyromonadaceae | Sutterella, Geofilum, Pseudoflavonifractor |

#### Visualizations

### Figure 1: G1: Corticosteroids vs No medication in Inflamed tissues
<img src="./Figures/Aim%205/Volcano_G1_Inflamed_tissue.png" alt="Volcano Plot G1 Inflamed" width="600">

![G2 Volcano Plot](./Analysis_Results/Volcano_Final_G2_Inflamed_tissue.png)
*Figure 2: Differential abundance for Mesalamine+Corticosteroids vs No Medication.*

![G3 Volcano Plot](./Analysis_Results/Volcano_Final_G3_Inflamed_tissue.png)
*Figure 3: Differential abundance for Triple Therapy vs No Medication.*

![G4 Volcano Plot](./Analysis_Results/Volcano_Final_G4_Inflamed_tissue.png)
*Figure 4: Differential abundance for Corticosteroids vs Mesalamine.*

![G5 Volcano Plot](./Analysis_Results/Volcano_Final_G5_Inflamed_tissue.png)
*Figure 5: Differential abundance for Mesalamine vs No Medication.*

---

### 6. Critical Observations (Aim 5)
* Sutterella [fb8d] and Geofilum [98d1] show consistent depletion across G1, G2, G4, and G5, serving as potential biomarkers for medication response.
* Group 2 (Combination therapy) yielded a more diverse range of significant ASVs than mono-therapies, suggesting synergistic microbial reorganization.
* Paralactobacillus [0ab3] emerged as a highly significant outlier in Group 3 (Triple therapy).

---

### 7. Next Steps: Aim 6 (PICRUSt2)
* Use identified taxa from Aims 3, 4, and 5 to predict functional composition and metabolic pathway enrichment.
* Link community composition to the inflamed phenotype observed in the Ryan et al. clinical dataset.
* Prioritize specific microbial targets for the "Blue-sky" proposal.

---

Note: Unique [XXXX] labels in figures refer to the specific ASV row names in the accompanying Results_Data CSV files.
