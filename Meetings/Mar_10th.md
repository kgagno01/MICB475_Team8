# Impact of Medication on the Mucosal Microbiome in IBD

## Research Question
> "How does medication affect the microbiome of individuals with IBD: Crohn's Disease or Ulcerative Colitis?"

## Project Overview
This project utilizes the Ryan Dataset to analyze the spatial and pharmaceutical influences on the gut microbiome. We aim to isolate the effects of specific treatments (Anti-TNF and Mercaptopurine) compared to non-treated individuals and healthy controls, while accounting for the biopsy location as a key predictor.
## Data Processing Updates
- [x] **Changes the file to be  in markdown format. 
- [x] **Ran post-hoc test on beta diversity metrics.
- [x] **Filtered out NA samples in medications group.
- [x]  **Re-did Aim 2 but only comparing diversity metrics of the combination drug approaches - filtering out single drug treatments.
- [x]  **During Aim 2 analysis, filtered out healthy individuals before dividing into "inflammed" and "noninflamed" tables.


## Analysis (Parallel Tasks)

| Analysis Task | Lead | Objective |
| :--- | :--- | :--- |
| **Diversity Metrics** | Evelyn | Completed |
| <mark>**Core Microbiome** | YunYun | Generate Venn diagrams for shared/unique taxa. <mark/>|
| **Indicator Taxa** | Ahnaf | Identify signatures for Anti-TNF vs. Mercaptopurine. |
| **DESeq2** | [Hannah] | Differential abundance in inflamed vs. healthy tissue. |
| **PICRUSt2** | [Kéryanne] | Functional pathway predictions (SCFA, barrier repair). | 

## Current Status: Meeting Agenda & Action Items

### Agenda 
Review and reconsider aim 2 results to confirm how we wish to proceed in terms of grouping the data for further testing 

Review the results of the “post hoc” test and base decision on results

confirm comparison groups that are used for all future aims 

### Meeting Summary
## Analysis Summary

### Alpha Diversity

**Inflamed Tissue:**
- Separated inflamed and non-inflamed samples
- Significant differences observed for **Shannon** and **PD (Faith's)**
- Groups of interest in inflamed tissue:
  1. **(MOST INTERESTING)** Mesalamine + Corticosteroid vs. Azathioprine/6-Mercaptopurine
  2. Mesalamine + Corticosteroids vs. Mesalamine alone
     - Addition of corticosteroid changed alpha diversity
  3. No drug vs. Mesalamine + Corticosteroids
- Shannon shows no overall difference across all groups
- Faith PD shows differences between the 3 listed groups
- Abundance and richness did not change — PD changes
- Note: a group may be missing in beta diversity compared to alpha diversity

**Non-Inflamed Tissue:**
- Shannon p-value: **not significant** — no difference
- Faith PD: difference observed
  - Only group showing difference: **Null vs. Anti-TNF**

---

### Beta Diversity

**Bray-Curtis:**

*Inflamed:*
- Stats show significant difference
- Post-hoc pairwise comparisons significant for:
  - Mesalamine + Corticosteroid vs. No drug
  - Mesalamine + Corticosteroid vs. Mesalamine

**Unweighted UniFrac** (phylogenetic):

*Inflamed:*
- Null vs. Mesalamine + Corticosteroid
- Mesalamine + Corticosteroid vs. Mesalamine

**Weighted UniFrac:**

*Inflamed:*
- Same two comparisons as above

*Non-Inflamed:*
- Mesalamine + Corticosteroid vs. Null
- Mesalamine vs. Anti-TNF

**Unweighted UniFrac (Non-Inflamed):**
- Null vs. Anti-TNF

---

### Key Interpretation Notes

- Use **Null vs. Corticosteroid** as control to compare effect of corticosteroid
- Drug combinations of interest:
  - Mesalamine + Corticosteroid vs. Azathioprine/6-Mercaptopurine
  - Mesalamine + Corticosteroid vs. Mesalamine alone
- Seems like phylogenetic difference present
- Abundance and richness unchanged; phylogenetic diversity (PD) changes

---

## Action Items

### Aim 2
- [ ] One group missing in Faith PD for non-inflamed: **Mesalamine + Corticosteroid + Anti-TNF combination**
- [ ] Filter out drug combination groups — ensure all combinations exist in **both** inflamed and non-inflamed
- [ ] Organize figures

### Aim 3
- [ ] Finish by **next meeting**

### Aim 4
- [ ] Complete **week after next**

### Slides
- [ ] Future weeks

---

## Important Note
> **Only 2 more meetings remaining!**


