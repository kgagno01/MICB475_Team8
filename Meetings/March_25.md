# Aim 3 Venn diagrams
## G6: Corticosteroids only vs no medication in inflamed tissues
<img src="https://raw.githubusercontent.com/kgagno01/MICB475_Team8/3d0c57e9b723dd59fbd05894c32e893d4a7769d2/Project_2/Figures/venn_G6_inflamed.png" alt="Venn G6 Inflamed" width="800" />

Comparing diagrams between corticosteroid use vs corticosteroid use and mesalamine use (double therapy) in inflammed tissues, we can see that core microbiome composition appeared to be more variable when tissues were treated with corticosteroids only. This could suggest that double therapy doesn't seem to have as much as an effect than just using corticosteroids singularly.

## G6: Corticosteroids only vs no medication in noninflamed tissues
<img src="https://raw.githubusercontent.com/kgagno01/MICB475_Team8/b5ad6002958e80cb57f45ddd944d2af837bab117/Project_2/Figures/venn_G6_noninflamed.png" alt="Venn G6 Noninflamed" width="800" /> 

Comparing diagrams between corticosteroid use vs corticosteroid use and mesalamine use (double therapy) in non-inflamed tissues, we also see similar results in which core microbiome composition appeared to be more variable when tissues were treated with corticosteroids only. This could suggest that double therapy doesn't seem to have as much as an effect than just using corticosteroids singularly.

## G7: No Medication vs Corticosteroids Only vs Mesalamine Only vs Corticosteroids + Mesalamine — Inflamed 
<img src="https://raw.githubusercontent.com/kgagno01/MICB475_Team8/8ca4808bb23f141210a92e682571ef843fdb0531/Project_2/Figures/venn_G7_inflamed.png" alt="Venn G7 Inflamed" width="900" />
There were more shared similarities of core microbiome composition of the 3 treatment groups vs no_med group in inflammed tissues compared to non-inflamed tissues. We can also see that the 3 distinct treatment groups show low level of variability in core microbiome composition. They all seem to have similar percentages of differing microbiome composition. This could suggest that the treatments are relatively less effective overall. 

## G7: No Medication vs Corticosteroids Only vs Mesalamine Only vs Corticosteroids + Mesalamine — Noninflamed

<img src="https://raw.githubusercontent.com/kgagno01/MICB475_Team8/8ca4808bb23f141210a92e682571ef843fdb0531/Project_2/Figures/venn_G7_noninflamed.png" alt="Venn G7 Noninflamed" width="900" />
Interestingly, we can see that non-inflamed tissues that were treated with corticosteroids only had a more variable core microbiome composition comapred to the other groups (51% difference). This could suggest that corticosteroids create a larger disturbance in a non-inflamed microbiome.

---

# Aim 4

G1: Corticosteroids vs No Medication
Indicator taxon: Unclassified Family
Association: Enriched in corticosteroid-treated samples
The presence of a corticosteroid-associated indicator taxon suggests that corticosteroid therapy induces targeted compositional shifts in the microbiome, even if overall diversity changes are modest.
Although the taxon is unclassified at the family level, its consistent enrichment indicates a treatment-specific microbial niche, potentially reflecting early-stage microbiome restructuring under corticosteroid exposure.
<img width="2400" height="1800" alt="G1_Corticosteroids_Only_vs_No_Medication_boxplot" src="https://github.com/user-attachments/assets/d43df731-4966-4c72-972e-ddbef3a91e22" />

G2: Corticosteroids + Mesalamine vs No Medication
No statistically significant indicator taxa identified
combination therapy does not produce strongly unique or exclusive taxa
<img width="1800" height="1400" alt="G2_Corticosteroids_Plus_Mesalamine_vs_No_Medication_top_taxa_heatmap" src="https://github.com/user-attachments/assets/67c873cd-e38d-4dcc-ac7d-6e1714778f81" />

G3: Triple Therapy vs No Medication

G4: Corticosteroids vs Mesalamine
Indicator taxon: Peptostreptococcaceae
Association: Enriched in mesalamine-treated samples
treatment-specific divergence between corticosteroids and mesalamine.
Peptostreptococcaceae are:
anaerobic bacteria
often linked to protein fermentation and gut metabolic activity
Their enrichment in mesalamine-treated samples suggests:
mesalamine may promote distinct metabolic niches
potentially supports different recovery pathways compared to corticosteroids
<img width="2400" height="1800" alt="G4_Corticosteroids_Only_vs_Mesalamine_Only_boxplot" src="https://github.com/user-attachments/assets/e9de5d7d-bb99-4e7f-bdce-ffb7c1479412" />

G5: Mesalamine vs No Medication
Indicator taxon: Rikenellaceae
Association: Enriched in mesalamine-treated samples
Rikenellaceae is a well-recognized gut-associated family linked to:
mucosal environments
complex carbohydrate metabolism
Its enrichment suggests that mesalamine:
promotes stabilization of gut-associated taxa
may contribute to restoration of microbial balance
Interestingly, Aim 5 showed depletion of dysbiosis-associated taxa (e.g., Sutterella, Geofilum) in medicated groups , supporting the idea that mesalamine: shifts the microbiome toward a health-associated state
<img width="2400" height="1800" alt="G5_Mesalamine_Only_vs_No_Medication_boxplot" src="https://github.com/user-attachments/assets/4d6d1665-6ff1-4c81-a05b-77034d7ab379" />

---

# Aim 5: DESeq2 Heatmap Analysis (Family Level)

<img width="4800" height="3600" alt="Aim5_Final_Heatmap" src="https://github.com/user-attachments/assets/3bbd39ee-e9c9-4909-9ea2-86b4d51206a3" />

## 1. Key Observations: Differential Abundance Trends
* **Downregulated Taxa (Blue):** *Sutterellaceae* and *Marinilabiliaceae* (primarily **Inflamed** tissue across Cort, Mes, and Double Therapy).
* **Upregulated Taxa (Red):** *Enterobacteriaceae* and *Bacillaceae* (specifically **Cort (N)** and **Cort vs Mes (N)**).
* **Upregulated Taxa (Red):** *Oscillospiraceae* and *Ruminococcaceae* trends (**Double Therapy (N)** and **Mes (I)**).

## 2. Microbial Roles in the Human Gut
* **Sutterellaceae:** Mucus-adhering Proteobacteria; correlation with pro-inflammatory states in IBD.
* **Enterobacteriaceae:** Facultative anaerobic pathobionts; opportunistic blooms during gut stress/oxygenation.
* **Oscillospiraceae & Ruminococcaceae:** Strictly anaerobic fiber-degraders; primary producers of **butyrate** for barrier integrity.
* **Lachnospiraceae:** Core commensal family; involved in carbohydrate fermentation and homeostasis.
* **Marinilabiliaceae:** Anaerobic specialists; degradation of complex organic matter in stable environments.

## 3. Preliminary Indications for Treatment
* **Targeted Depletion:** Possible successful clearance of inflammatory-associated taxa in **Inflamed** sites.
* **Potential Off-Target Effects:** Possible corticosteroid-induced shifts in histologically healthy (**Noninflamed**) tissue.
* **Synergistic Recovery:** Tentative signal of Double Therapy supporting beneficial butyrate-producing commensals.
* **Histology-Dependent Response:** Local tissue environment as a significant modulator of microbial drug response.

---

# Aim 6 Functional analysis using PICRUSt2
## Inflamed tissues - Heatmap
Generated after differential abundance analysis of all inflamed samples with medication of interest
<img width="1800" height="1800" alt="Heatmap of differentially abundant KO pathways in medication groups of interest (inflamed)" src="https://github.com/kgagno01/MICB475_Team8/blob/1233ff51363fe033a8ef8b218c2b6832681b2a0f/Project_2/Figures/Aim%206/KEGG%20Heatmap%20Inflamed.png" />
Questions:
* How can we tell which group is which?
* Is there a way to replace the KO pathway code by the name of the pathway?
* Would it be better to focus on only two groups per heatmap?

## Noninflamed tissues - Heatmap
Generated after differential abundance analysis of all noninflamed samples with medication of interest
<img width="1800" height="1800" alt="Heatmap of differentially abundant KO pathways in medication groups of interest (noninflamed)" src="https://github.com/kgagno01/MICB475_Team8/blob/1233ff51363fe033a8ef8b218c2b6832681b2a0f/Project_2/Figures/Aim%206/KEGG%20Heatmap%20Noninflamed.png" />
Questions
* Is it normal that there are way more pathways compared to the inflamed tissues?
* Same questions as the ones for the inflamed tissues heatmap

## Inflamed tissues - Error Bar
Performed DAA using all noninflamed samples with medication of interest. However, when plotting error bar charts, the code only allows for two groups. I didn't know if it was better to filter the daa_results table multiple times to only keep two groups (method 2) or to redo the whole analysis using two groups at a time (method 1). So I did both.
### Corticosteroids vs Mesalamine
Method 1: Analysis gave more than 30 significant pathways so I only kept the ones with padj < 0.02 and log2FC > 3
<img width="2000" height="1800" alt="PEB Method 1 Corticosteroids vs Mesalamine" src="https://github.com/kgagno01/MICB475_Team8/blob/1233ff51363fe033a8ef8b218c2b6832681b2a0f/Project_2/Figures/Aim%206/KEGG%20Error%20Bar%20Inflamed%20CvsM.png" />
Method 2: 
<img width="2000" height="1800" alt="PEB Method 2 Corticosteroids vs Mesalamine" src="https://github.com/kgagno01/MICB475_Team8/blob/1233ff51363fe033a8ef8b218c2b6832681b2a0f/Project_2/Figures/Aim%206/KEGG%20Error%20Bar%20Inflamed%20CvsM%20Method2.png" />
Differences between the two:
* More pathways were differentially abundant using method 1.
* Adjusted p-values are lower with method 1.

### Corticosteroids vs Mesalamine+corticosteroids
Method 1: No significant pathway identified
Method 2: Only 4 pathways identified
<img width="1000" height="900" alt="PEB Method 2 Corticosteroids vs Mesalamine+corticosteroids" src="https://github.com/kgagno01/MICB475_Team8/blob/1233ff51363fe033a8ef8b218c2b6832681b2a0f/Project_2/Figures/Aim%206/KEGG%20Error%20Bar%20Inflamed%20CvsM%2BC%20Method2.png" />
Note: I will change the formatting so it looks better.

### Corticosteroids vs No medication
Method 1: No significant pathway identified
Method 2: 
<img width="1000" height="900" alt="PEB Method 2 Corticosteroids vs No" src="https://github.com/kgagno01/MICB475_Team8/blob/1233ff51363fe033a8ef8b218c2b6832681b2a0f/Project_2/Figures/Aim%206/KEGG%20Error%20Bar%20Inflamed%20CvsNo%20Method2.png" />

## Noninflamed tissues - Error bar
### Corticosteroids vs Mesalamine
Method 1: More than 30 pathways identified; only kept the ones with p_adjust < 0.02, log2FC > 4
<img width="2000" height="1800" alt="PEB Method 1 Corticosteroids vs Mesalamine Noninflamed" src="https://github.com/kgagno01/MICB475_Team8/blob/1233ff51363fe033a8ef8b218c2b6832681b2a0f/Project_2/Figures/Aim%206/KEGG%20Error%20Bar%20Noninflamed%20CvsM%20Method1.png" />
Method 2: Also had to filter to keep less than 30 pathways (same settings as method 1)
<img width="2000" height="1800" alt="PEB Method 2 Corticosteroids vs Mesalamine Noninflamed" src="https://github.com/kgagno01/MICB475_Team8/blob/1233ff51363fe033a8ef8b218c2b6832681b2a0f/Project_2/Figures/Aim%206/KEGG%20Error%20Bar%20Noninflamed%20CvsM%20Method2.png" />

### Corticosteroids vs Mesalamine+corticosteroids
Method 1: Less than 30 pathways identified
<img width="2000" height="1800" alt="PEB Method 1 Corticosteroids vs Mesalamine+corticosteroids Noninflamed" src="https://github.com/kgagno01/MICB475_Team8/blob/1233ff51363fe033a8ef8b218c2b6832681b2a0f/Project_2/Figures/Aim%206/KEGG%20Error%20Bar%20Noninflamed%20CvsM%2BC%20Method1.png" />
Method 2: Had to filter to keep less than 30 pathways
<img width="2000" height="1800" alt="PEB Method 2 Corticosteroids vs Mesalamine+corticosteroids Noninflamed" src="https://github.com/kgagno01/MICB475_Team8/blob/1233ff51363fe033a8ef8b218c2b6832681b2a0f/Project_2/Figures/Aim%206/KEGG%20Error%20Bar%20Noninflamed%20CvsM%2BC%20Method2.png" />
