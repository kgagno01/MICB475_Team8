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

-Review and reconsider aim 2 results to confirm how we wish to proceed in terms of grouping the data for further testing 
-Review the results of the “post hoc” test and base decision on results
-clarify
-still keeping control?
-confirm comparison groups that are used for all future aims 

