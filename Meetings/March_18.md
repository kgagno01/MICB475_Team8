# Investigating the Effects of Medication on the Colonic Microbial Diversity in Individuals with IBD

Team 8: Kéryanne Gagnon, Ahnaf Kabir, Evelyn Mitchell, Hanna Wang, Yun Yun Wei

This repository contains the Aim 3, 4 and 5 analysis of colonic mucosal biopsies (Ryan et al. dataset) to determine how pharmacotherapy influences microbial signatures in inflamed vs. non-inflamed tissues.

## Meeting Agenda: March 2026

### Project Status Overview

| Experimental Aim | Description | Lead | Status |
| :--- | :--- | :--- | :--- |
| **Aim 1** | Spatial variation across healthy colonic biopsy sites. | Evelyn | Completed |
| **Aim 2** | Impact of medication on community alpha and beta diversity. | Evelyn | Completed |
| **Aim 3** | Core microbiome identification (Medicated vs. Non-medicated). | Yun Yun | Completed |
| **Aim 4** | Indicator taxa associated with inflammation and metadata. | Ahnaf | Pending |
| **Aim 5** | Differential abundance of specific species via DESeq2. | Hanna | Completed |
| **Aim 6** | Functional composition and metabolic pathway enrichment (PICRUSt2). | Kéryanne | In Progress |

### 2. Technical Note on Sample Sizes
* Statistical Constraint: While the pipeline was designed to analyze both inflamed and non-inflamed tissues, it was determined that across all comparison groups (G1-G5), there were insufficient sample sizes within the non-inflamed cohort to perform statistically robust differential abundance testing. 
* Result Scope: Consequently, the following Aim 5 results and associated volcano plots focus exclusively on comparisons within inflamed tissues.

---

### 3. Aim 3: Core Microbiome Results - Yunyun

### Figure 1: G1: Corticosteroids only vs All Inflamed
<img src="https://raw.githubusercontent.com/kgagno01/MICB475_Team8/5c583d6b82e4a156761e72cdf6eb4c3f4913b5fa/Project_2/Figures/venn_G1_inflamed.png" alt="G1 Inflamed Venn" width="700">

### Figure 2: G1: Corticosteroids only vs All Noninflamed
<img src="https://raw.githubusercontent.com/kgagno01/MICB475_Team8/7a473f280056ed8dc1e0f097642b006cfc366195/Project_2/Figures/venn_G1_noninflamed.png" alt="G1 Noninflamed Venn" width="700">

#Note: There are more shared microsbiome composition seen in inflamed tissues compared to non-inflamed tissues when corticosteroids were used.
### Figure 3: G2: Corticosteroids + Mesalamine vs No medication in Inflamed tissues
<img src="https://raw.githubusercontent.com/kgagno01/MICB475_Team8/c3631aa9f8c4d8eb89caf07e192207ed9a48e5fb/Project_2/Figures/venn_G2_inflamed.png" alt="Venn Diagram G2 Inflamed" width="600">

### Figure 4: G2: Corticosteroids + Mesalamine vs No medication in Noninflamed tissues
<img src="https://raw.githubusercontent.com/kgagno01/MICB475_Team8/7a473f280056ed8dc1e0f097642b006cfc366195/Project_2/Figures/venn_G2_noninflamed.png" alt="Venn Diagram G2 Non-inflamed" width="600">
#Note: There are more shared microbiome composition seen when comparing inflamed tissues with no medication use and inflamed tissue with corticiosteroids+Mesalamine use.
### Figure 5: G3: Corticosteroid combinations vs No medication in Inflamed tissues
<img src="https://raw.githubusercontent.com/kgagno01/MICB475_Team8/7a473f280056ed8dc1e0f097642b006cfc366195/Project_2/Figures/venn_G3_inflamed.png" alt="Venn Diagram G3 Inflamed" width="600">

### Figure 6: G3: Corticosteroid combinations vs No medication in Noninflamed tissues
<img src="https://raw.githubusercontent.com/kgagno01/MICB475_Team8/7a473f280056ed8dc1e0f097642b006cfc366195/Project_2/Figures/venn_G3_noninflamed.png" alt="Venn Diagram G3 Non-inflamed" width="600">
#Note: There are more shared microbiome composition seen when comparing noninflamed tissues with no medication use and noninflamed tissue with  triple therapy. However, non-inflamed and inflamed tissues shows rough similarity in the percentage of shared micrbiome percentages.
### Figure 7: G4: Corticosteroids only vs Mesalamine only in Inflamed tissues
<img src="https://raw.githubusercontent.com/kgagno01/MICB475_Team8/7a473f280056ed8dc1e0f097642b006cfc366195/Project_2/Figures/venn_G4_inflamed.png" alt="Venn Diagram G4 Inflamed" width="600">

### Figure 8: G4: Corticosteroids only vs Mesalamine only in Noninflamed tissues
<img src="https://raw.githubusercontent.com/kgagno01/MICB475_Team8/7a473f280056ed8dc1e0f097642b006cfc366195/Project_2/Figures/venn_G4_noninflamed.png" alt="Venn Diagram G4 Non-inflamed" width="600">
#Note: There are more shared microbiome composition seen when comparing inflamed tissues with Corticosteroids use and inflamed tissue with Mesalamine use. 
### Figure 9: G5: Mesalamine only vs No medication in Inflamed tissues
<img src="https://raw.githubusercontent.com/kgagno01/MICB475_Team8/7a473f280056ed8dc1e0f097642b006cfc366195/Project_2/Figures/venn_G5_inflamed.png" alt="Venn Diagram G5 Inflamed" width="600">

### Figure 10: G5: Mesalamine only vs No medication in Noninflamed tissues
<img src="https://raw.githubusercontent.com/kgagno01/MICB475_Team8/7a473f280056ed8dc1e0f097642b006cfc366195/Project_2/Figures/venn_G5_noninflamed.png" alt="Venn Diagram G5 Non-inflamed" width="600">
#Note: There are more shared microbiome composition seen when comparing inflamed tissues with no medication use and inflamed tissue with Mesalamine use.

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
| **G1: Corticosteroids vs No** | Oscillospiraceae (f) | Sutterella, Geofilum |
| **G2: Mesalamine + Cortico vs No** | Segatella, Anaerosphaera | Geofilum, Lachnospiraceae (f), Sutterella |
| **G3: Triple Therapy vs No** | Paralactobacillus, Marinilabiliaceae (f) | Phocea, Incertae_Sedis |
| **G4: Cortico vs Mesalamine** | Lachnospiraceae (f), UCG-002 | Geofilum, Lachnospiraceae (f) |
| **G5: Mesalamine vs No** | Segatella, Porphyromonadaceae (f) | Sutterella, Geofilum, Lachnospiraceae (f) |

### Visualizations

### Figure 1: G1: Corticosteroids vs No medication in Inflamed tissues
<img src="https://raw.githubusercontent.com/kgagno01/MICB475_Team8/main/Project_2/Figures/Aim%205/Volcano_G1_Inflamed_tissue.png" alt="Volcano Plot G1 Inflamed" width="800">

### Figure 2: G2: Mesalamine + Corticosteroids vs No medication in Inflamed tissues
<img src="https://raw.githubusercontent.com/kgagno01/MICB475_Team8/main/Project_2/Figures/Aim%205/Volcano_G2_Inflamed_tissue.png" alt="Volcano Plot G2 Inflamed" width="800">

### Figure 3: G3: Triple Therapy vs No medication in Inflamed tissues
<img src="https://raw.githubusercontent.com/kgagno01/MICB475_Team8/main/Project_2/Figures/Aim%205/Volcano_G3_Inflamed_tissue.png" alt="Volcano Plot G3 Inflamed" width="800">

### Figure 4: G4: Corticosteroids vs Mesalamine in Inflamed tissues
<img src="https://raw.githubusercontent.com/kgagno01/MICB475_Team8/main/Project_2/Figures/Aim%205/Volcano_G4_Inflamed_tissue.png" alt="Volcano Plot G4 Inflamed" width="800">

### Figure 5: G5: Mesalamine vs No medication in Inflamed tissues
<img src="https://raw.githubusercontent.com/kgagno01/MICB475_Team8/main/Project_2/Figures/Aim%205/Volcano_G5_Inflamed_tissue.png" alt="Volcano Plot G5 Inflamed" width="800">
Note: Unique [XXXX] labels in figures refer to the specific ASV row names in the accompanying Results_Data CSV files.

---

### 6. Aim 5 Results: Functional Taxonomy and Biological Significance

* Sutterella (Proteobacteria): Consistently depleted in G1, G2, G4, and G5. Known for mucosal adhesion and often elevated in IBD; its reduction suggests a decrease in pro-inflammatory Proteobacteria signatures.
* Geofilum (Bacillota): Frequent depletion across multiple medication groups. While less characterized, its strong association with the untreated "No Medication" group marks it as a reliable indicator of active dysbiosis.
* Paralactobacillus: High-confidence enrichment specific to G3 (Triple Therapy). These Lactic Acid Bacteria (LAB) produce lactate and antimicrobial peptides, potentially lowering colonic pH to inhibit opportunistic pathogens.
* Oscillospiraceae & Lachnospiraceae: Enriched in G1 (Corticosteroids) and G4. These are obligate anaerobes and primary butyrate producers; butyrate is the essential energy source for colonocytes and induces anti-inflammatory T-regulatory cells.
* Segatella (Prevotellaceae): Enriched in G2 and G5 (Mesalamine groups). These bacteria specialize in degrading complex plant-derived glycans, indicating a shift toward a more stable, fiber-fermenting microbial community.
* Coprobacter: Primary depletion in G2. Known as a propionate producer; its depletion despite combination therapy suggests a specific metabolic gap that Mesalamine + Corticosteroids may not address.
* Phocea & Incertae_Sedis: Primary depletion in G3. These taxa are frequently associated with "leaky gut" and dysbiotic profiles; their removal highlights the efficacy of the Triple Therapy (Anti-TNF) regimen.

#### Biological Implications
* Microbiome Remodeling: Significant transition from pro-inflammatory Proteobacteria (Sutterella) toward beneficial Firmicutes/Bacillota (butyrate producers).
* Treatment-Specific Signatures: Triple therapy (G3) uniquely fosters protective LAB (Paralactobacillus), whereas mono-therapies focus more on restoring general SCFA-producing families.
* Mucosal Healing: The enrichment of butyrate-producing Oscillospiraceae suggests that medications are creating an environment conducive to intestinal barrier repair.
* Methodological Integrity: By focusing on 109 inflamed samples, the analysis captured high-resolution taxonomic shifts that would have been diluted in the non-inflamed cohort.

---

### 7. Next Steps: Aim 6 (PICRUSt2)
* Use identified taxa from Aims 3, 4, and 5 to predict functional composition and metabolic pathway enrichment.
* Link community composition to the inflamed phenotype observed in the Ryan et al. clinical dataset.
* Prioritize specific microbial targets for the "Blue-sky" proposal.

---

