# Impact of Medication on the Mucosal Microbiome in IBD

## Research Question
> "How does medication affect the microbiome of individuals with IBD, Crohn's disease, or ulcerative colitis?"

## Project Overview
This project utilizes the Ryan Dataset to analyze the spatial and pharmaceutical influences on the gut microbiome. We aim to isolate the effects of specific treatments (Anti-TNF and Mercaptopurine) compared to non-treated individuals and healthy controls, while accounting for the biopsy location as a key predictor.



## Current Status: Meeting Agenda & Action Items

## Data Processing Updates
- [x] **Cutadapt Execution:** Completed by Ahnaf. Initial review of `cutadapt-log-2.txt` shows >99% read retention, confirm with Hans.
- [x] **Quality Review:** Upload demux_seqs-trimmed.qzv` to QIIME 2 View to finalize truncation lengths.
- [ ] **DADA2 Denoising:** Define `--p-trunc-len-f` and `--p-trunc-len-r` to generate the final feature table.

<img width="1423" height="433" alt="Screenshot 2026-02-11 at 12 59 15 AM" src="https://github.com/user-attachments/assets/56d4c5e3-14f0-4735-a0a2-922f987749c7" />

## Analysis (Parallel Tasks)

| Analysis Task | Lead | Objective |
| :--- | :--- | :--- |
| **Diversity Metrics** | Evelyn | Assess Alpha/Beta diversity for group binning. |
| **Core Microbiome** | [Name] | Generate Venn diagrams for shared/unique taxa. |
| **Indicator Taxa** | [Name] | Identify signatures for Anti-TNF vs. Mercaptopurine. |
| **DESeq2** | [Name] | Differential abundance in inflamed vs. healthy tissue. |
| **PICRUSt2** | [Name] | Functional pathway predictions (SCFA, barrier repair). | 

Note: set aside more time for PICRUSt2. >1 person may work on this part.

## Experimental Design
* **Conditions:** Crohn's Disease (CD), Ulcerative Colitis (UC), Healthy Control.
* **Primary Predictors:**
    * **Treatment:** No treatment, Anti-TNF, Mercaptopurine.
    * **Biopsy Location:** Right Colon, Sigmoid, Rectum.
* **Sample Filtering:** Analysis focused on inflamed tissues (~52 samples) to isolate drug-microbe interactions.



## Primary Literature & Significance

### 1. Clinical Context and Non-Response
**Cai et al. (2021). "Treatment of Inflammatory Bowel Disease: A Comprehensive Review."**
* **Key takeaway:** High non-response rates (40%) and secondary loss of response (23-46%) to Anti-TNFs necessitate the identification of microbial biomarkers for treatment success.
* **Link:** [https://doi.org/10.3389/fmed.2021.765474](https://doi.org/10.3389/fmed.2021.765474)

### 2. Mechanisms of Dysbiosis and Disease Progression
**Shan et al. (2022). "The Gut Microbiome and Inflammatory Bowel Diseases."**
* **Key takeaway:** Outlines a multi-stage model of IBD development where environmental triggers and genetic drivers lead to a loss of beneficial commensals and an emergence of pathobionts, ultimately resulting in a compromised mucosal barrier.
* **Link:** [https://doi.org/10.1146/annurev-med-042320-021020](https://doi.org/10.1146/annurev-med-042320-021020)

### 3. Spatial Biogeography of the Gut
**Lavelle et al. (2015). "Spatial variation of the colonic microbiota in patients with ulcerative colitis and control volunteers."**
* **Key takeaway:** Mucosal-associated microbiomes vary significantly by location (Caecum vs. Rectum). Justifies treating Biopsy Location as a predictor rather than pooling all IBD samples.
* **Link:** [https://pmc.ncbi.nlm.nih.gov/articles/PMC4602252/](https://pmc.ncbi.nlm.nih.gov/articles/PMC4602252/)

### 4. Microbiota, Inflammation, and Epigenomics
**Ryan et al. (2020). "Colonic microbiota is associated with inflammation and host epigenomic alterations in inflammatory bowel disease."**
* **Key takeaway:** Establishes the link between mucosal microbiota composition and host epigenetic changes, providing the foundational dataset and biological context for this project.
* **Link:** [https://doi.org/10.1038/s41467-020-14731-z](https://doi.org/10.1038/s41467-020-14731-z)

### 5. Paracellular Passage of Medication
**Nakai et al. (2023). "Intestinal Membrane Function in Inflammatory Bowel Disease."**
* **Key takeaway:** Includes data on ulcerative colitis and Crohn’s disease using “gut-on-a-chip” model. UC patients in remission and IBS patients have reduced transepithelial electrical resistance and increased paracellular passage of IBD medications (intestinal cells become leaky when tissue is inflamed).
* **Link:** [https://doi.org/10.3390/pharmaceutics16010029]

### 6. Altered Inflamed Intestinal Mucosal Membranes
**Dorofeyev et al. (2013). "Mucosal Barrier in Ulcerative Colitis and Crohn’s Disease."**
* **Key takeaway:** Clinical study on 77 UC and CD patients. Patients with UC demonstrated low secretion of mucus on intestinal membrane. The most dramatic alteration in mucin expression was observed in severe cases of UC and CD. This mucosal membrane is important to the host innate immune response making these patients more susceptible to disease and infection.
* **Link:** [https://doi.org/10.1155/2013/431231]
