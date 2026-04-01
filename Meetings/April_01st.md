# Meeting Agenda - April 1st, 2026
## Preparation of presentation slides
### Introduction
* Inflammatory bowel disease (IBD) is a chronic immune-mediated inflammatory response localized to the gastrointestinal (GI) tract.
* By 2035, 1% of the Canadian population will be affected by IBD.
* The cause of IBD has yet to be elucidated but it is thought to be a combination of genetic, microbial, immune and environmental factors.
* IBD is associated with:
  * A decrease in microbial gut diversity
  * A decrease in anti-inflammatory bacteria
  * An increase in pro-inflammatory bacteria
* Current pharmacological treatments aim to treat symptoms (e.g. inflammation).
* Examples of drugs:
    * Corticosteroids: inhibit inflammation
    * Mesalamine: scavenges ROS and targets different immune responses
* How do different pharmacological treatments affect the microbiome of patients with IBD?
### Results
1. Alpha-diversity metrics
2. Core microbiome
3. Indicator taxa
4. DESEq
5. PICRUSt2
### Conclusion
Corticosteroid-treated patients have different compositional and functional compositions compared to mesalamine-treated patients and patients without medication.
### Future directions
* Short-term:
  * Look at the effects of other pharmacological treatments included in the dataset.
* Long-term:
  * Collect similar samples from the same IBD patients over time to see the short- and long-term effects of the pharmacological treatment on the gut microbiome.
 
## Edits of figures presented last week
## Aim 3
## Inflamed
![4-Way Venn Diagram - Inflamed](https://github.com/kgagno01/MICB475_Team8/blob/3eaa4f6637d4ce61cc40ccfa8885acddd75cf51a/Project_2/Figures/G7_4%20way%20venn_Inflammed_edited.png?raw=true)
## non-inflamed
![4-Way Venn Diagram - Non-Inflamed](https://github.com/kgagno01/MICB475_Team8/blob/18421233b82dddc929ddf55af562ae6279f2bf38/Project_2/Figures/G7_noninflamed_4%20way%20venn_edited.png?raw=true)

---

## Aim 5 DESeq Heatmap
<img width="1934" height="1645" alt="Aim5 Final Heatmap" src="https://github.com/user-attachments/assets/59bbf82c-5441-49bb-a70a-bc133e292ea2" />
* Heat map shows a clear IBD dysbiosis pattern across treatment groups
* Corticosteroid groups show larger and more pronounced shifts than mesalamine groups
* Enriched in corticosteroid related comparisons: Enterobacteriaceae, Bacillaceae, Family_XI
* Depleted in corticosteroid related comparisons: Lachnospiraceae, Ruminococcaceae, Oscillospiraceae, Barnesiellaceae, Sutterellaceae, Marinilabiliaceae
* Strongest dysbiosis signal: Enterobacteriaceae enrichment
* Strongest beneficial loss signal: Lachnospiraceae depletion
* Mesalamine groups appear relatively less disrupted
* Inflammation status remains a major driver of taxonomic differences
* Overall: steroid associated microbiota look more perturbed than mesalamine associated microbiota
