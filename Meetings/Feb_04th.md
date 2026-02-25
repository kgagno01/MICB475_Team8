# MICB475_Team8
Members: Kéryanne Gagnon, Ahnaf Kabir, Evelyn Mitchell, Hanna Wang, YunYun Wei

## Description
Included here are the agenda and minutes for the team meetings.
Meetings take place on Wednesdays, from 12pm to 12:45pm.

## Table of contents
* February 4, 2026

## February 4, 2026
### Action items from previous meeting
* Find datasets looking at microbiome and anxiety or depressive disorders in mice, and send them to Evelyn.
* Make a list of possible research questions based on the datasets available on the course Canvas page.

### Datasets sourced by YunYun
* Inflammasome signaling affects anxiety- and depressive-like behavior and gut microbiome composition:
  * Article:https://pmc.ncbi.nlm.nih.gov/articles/PMC4879188/#_ad93_
  * Dataset: Check with Dr. Sun
* The Alleviation of Gut Microbiota-Induced Depression and Colitis in Mice by Anti-Inflammatory Probiotics NK151, NK173, and NK175:
  * Article: https://www.mdpi.com/2072-6643/14/10/2080
  * Dataset:https://www.ebi.ac.uk/ena/browser/view/PRJNA827020?show=publications
* Gut microbiome partially mediates and coordinates the effects of genetics on anxiety-like behavior in Collaborative Cross mice
  * Article: https://pmc.ncbi.nlm.nih.gov/articles/PMC7801399/#Sec11
  * Dataset: Check with Dr. Sun
* Gut dysbiosis induces the development of depression-like behavior through abnormal synapse pruning in microglia-mediated by complement C3
  * Article: https://pubmed.ncbi.nlm.nih.gov/38378622/
  * Dataset: Check with Dr. Sun
* Chronic Sleep Deprivation Causes Anxiety, Depression and Impaired Gut Barrier in Female Mice—Correlation Analysis from Fecal Microbiome and Metabolome
  * Article: https://pubmed.ncbi.nlm.nih.gov/39767560/
  * Dataset: Check with Dr. Sun
 
### Research questions from datasets available on Canvas
1. How does medication affect the microbiome of individuals with IBD, Crohn's disease or ulcerative colitis? How are different parts of the colon affected? How does smoking contribute to bacterial diversity?
  * Dataset: IBD in Humans dataset, IBD_ryan (Dataset 16 on Canvas)
  * Metadata variables of interest: Gender, Condition, Biopsy_location, Histological_status, Medications, Smoking.status
  * Original paper: https://www.nature.com/articles/s41467-020-15342-5#Sec2 (Focuses on the effects of inflammation and host epigenomics)
  * Related UJEMI paper: https://ojs.library.ubc.ca/index.php/UJEMI/article/view/199577 (Used a different dataset and focused on surgical intervention)
  * Pros:
    * Can be related to other studies
    * Many variables can be accounted for or looked into since nobody has used this dataset before.
  * Cons:
    * Similar question could have already be addressed in the literature
    * Only 343 samples (Is that too low? Or is that a normal sample size for this project?)
2. How does the microbiome affect the mental health of HIV-positive individuals?
  * Dataset: Depression dataset (Dataset 23 on Canvas)
  * Metadata variables of interest: many depression numeric measures, antiviral regimen, number of medications, lymphocyte, neutrophil
  * Original paper: https://journals.asm.org/doi/10.1128/msystems.00465-20
  * Pros:
    * Lots of variables to look into
    * Lots of factors to look at depression rather than a yes or no or singular scale
    * Could use this dataset to compare the use of antiviral therapy in the HIV dataset (Dataset 20 on Canvas)
  * Cons:
    * Research question already answered in the original paper, so we would need to find a different question/perspective/focus.
      * Compared HIV and HCV infected and coinfected individuals and found that the gut microbiome differed between depression states only in coinfected individuals.
      * Maybe focusing solely on HIV infected individuals yield different results?
    * Unsure whether healthy individuals are included as a control in the dataset

 ### Minutes from meeting
* Notes on datasets
  * Datasets sourced by YunYun are not suitable for project 2.
  * The IBD Ryan dataset will be used.
  * They were unable to find the metadata for the HIV and depression dataset so it is not very usable. You can’t see who has HIV vs. healthy in the data provided
* Notes on the IBD Ryan dataset
  * Data still contains the primers so we need to contact Hans for the code that would remove the primers.
  * Good sample size
  * Has already been used to solve the different parts of the colon and the smoking. We will answer the following question: “How does medication affect the microbiome of individuals with IBD, Crohn's disease or ulcerative colitis?”
* Notes on Project 2
  * Research question: How does medication affect the microbiome of individuals with IBD, Crohn's disease or ulcerative colitis?
  * Analysis:
    * Do the most prevalent medication(s), and combine all the others → want to isolate the effect of drug by itself (there are patients who are only on one drug so this should work)
    * Might need to correct for biopsy location: making sure they are taken from the same location/part of the colon (2 different locations)
    * Note that only one area is inflamed for different patients, so we could focus on biopsies taken from inflamed tissues and see how many samples we can keep per medication per biopsy location (could compare inflamed vs. healthy, combining Crohn's and Ulcerative colitis)
    * 52 datapoints for inflamed tissues (all from different individuals). Should have enough to separate by location
    * For medications use: no treatment, anti-TNF, mercaptopurine. Make sure to keep the healthy patients in there too
 * Aims and workflow
    * Variables 
      * Inflamed (keep separated at the beginning for diversity metrics, then can combine them later for downstream analysis):
      * UC (confounding variable)
      * CD (confounding variable)
      * Further separate by biopsy location (predictor)
      * Treatment vs. non-treated (predictor)
   * Aims:
     1. Diversity metrics - will allow us to make some decisions about what comparison groups we can bin together
     2. Core microbiome (venn diagram of shared vs unique microbes)
     3. Indicator taxa (which signature microbes are indicative of a certain condition)
     4. DESeq (can see the fluctuation of abundance/richness)
     5. Functional analysis - piCrust2 (predict functional pathways. Determines what kind of functional bacteria are being selected for). Budget more time for this 
* Proposal
  * All we need to have is the data processed in Qiime. Do all processing on the server we were just sent. Have it processed (primer removed) for the proposal.
  * After the proposal make the phyloseq object, share it around on Github before we start working on it.
  * Start running analysis (steps 1-4) in parallel.
* Action items
  * Reach out to Hans for the code to process the dataset (Ahnaf)
  * Process dataset on Qiime (Ahnaf)
  * Delegate workflow steps between team members so we are ready to start analysis once proposal is submitted (everyone)
  * For next meeting have any questions about proposal prepared (everyone)
  * Ensure the work we plan to do will address our research question and how so (everyone)
  * By next meeting do primary literature research so that we can start talking about the introduction (Keryanne, Evelyn, Hanna and YunYun)
 
 

