---
title: "Using Trycycler on the Migale cluster"
teaching: 30
exercises: 2
---

:::::::::::::::::::::::::::::::::::::: questions 

- How can we use Trycycler on the Migale cluster?

::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: objectives

- Become familiar with the file structure and commands
- Understand the inputs and outputs to Trycycler Reconcile

::::::::::::::::::::::::::::::::::::::::::::::::

## Introduction

Short (Illumina NovaSeq) and long (ONT P2solo) read data has been generated for a selection of bacterial isolates. After quality control, Trycycler's "subsample" command was used to generate 3 subsamples of each readset at a minimum allowed read depth of 20x, and providing the expected genome size. Each subsample was then assembled by each assembler (Flye, Raven and Unicycler), generating a total of 9 assemblies. Trycycler "cluster" has already been run, so let's take a look at our starting data.

```
 cd /save_projet/domino_wp3_isollates
```
Each sample directory should look like this, with a sub-directory containing the input assemblies, a .fastq.gz containing the reads for that sample, and a sub-directory called 'trycycler'.

![Sample directory structure (https://github.com/aforestsomewhere/bacterial-genome-assembly/blob/main/figures/folder1.jpg){alt='Sample directory structure'}

When we descend into the 'trycycler' folder we can see the output from Trycycler clustering, with one folder for each cluster, and .newick and .phylip files which contain information on the clustering of contigs (complete-linkage clustering based on Mash distance).

(One assembly was made for each (not-subsampled) readset using Canu).


## Trycycler Reconcile



[r-markdown]: https://rmarkdown.rstudio.com/
