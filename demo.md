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

(One assembly was made for each (not-subsampled) readset using Canu).

[r-markdown]: https://rmarkdown.rstudio.com/
