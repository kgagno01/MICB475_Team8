# Impact of Medication on the Mucosal Microbiome in IBD

## Research Question
> "How does medication affect the microbiome of individuals with IBD, Crohn's disease, or ulcerative colitis?"

## Project Overview
This project utilizes the Ryan Dataset to analyze the spatial and pharmaceutical influences on the gut microbiome. We aim to isolate the effects of specific treatments (Anti-TNF and Mercaptopurine) compared to non-treated individuals and healthy controls, while accounting for the biopsy location as a key predictor.



## Current Status: Meeting Agenda & Action Items

### 1. Data Processing Updates
- [x] **Cutadapt Execution:** Completed by Ahnaf. Initial review of `cutadapt-log-2.txt` shows >99% read retention.
- [ ] **Quality Review:** Team must upload `1a_demux_seqs-trimmed.qzv` to QIIME 2 View to finalize truncation lengths.
- [ ] **DADA2 Denoising:** Define `--p-trunc-len-f` and `--p-trunc-len-r` to generate the final feature table.

### 2. Analysis (Parallel Tasks)

| Analysis Task | Lead | Objective |
| :--- | :--- | :--- |
| **Diversity Metrics** | [Name] | Assess Alpha/Beta diversity for group binning. |
| **Core Microbiome** | [Name] | Generate Venn diagrams for shared/unique taxa. |
| **Indicator Taxa** | [Name] | Identify signatures for Anti-TNF vs. Mercaptopurine. |
| **DESeq2** | [Name] | Differential abundance in inflamed vs. healthy tissue. |
| **PICRUSt2** | Hanna | Functional pathway predictions (SCFA, barrier repair). |



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

### 2. Spatial Biogeography of the Gut
**Lavelle et al. (2015). "Spatial variation of the colonic microbiota in patients with ulcerative colitis and control volunteers."**
* **Key takeaway:** Mucosal-associated microbiomes vary significantly by location (Caecum vs. Rectum). Justifies treating Biopsy Location as a predictor rather than pooling all IBD samples.
* **Link:** [https://doi.org/10.1136/gutjnl-2015-309181](https://doi.org/10.1136/gutjnl-2015-309181)

### 3. Medication-Microbiome Interactions
**Ryan et al. (2022). "Interactions between Medications and the Gut Microbiome in Inflammatory Bowel Disease."**
* **Key takeaway:** Medication accounts for more variance in the microbiome (3.5%) than disease subtype or geography. Provides the foundational justification for the project's novel question.
* **Link:** [https://doi.org/10.3390/microorganisms10020473](https://doi.org/10.3390/microorganisms10020473)
