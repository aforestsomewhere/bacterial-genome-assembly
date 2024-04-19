---
title: "Bacterial Genome Assembly using Trycycler"
teaching: 30
exercises: 2
---

:::::::::::::::::::::::::::::::::::::: questions 

- Why go to the bother of using Trycycler to assemble bacterial genomes?

::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: objectives

- Provide examples of errors that can occur during assembly
- Explain the approach used by Trycycler

::::::::::::::::::::::::::::::::::::::::::::::::

## Introduction

Bacterial genomes are dynamic landscapes. They may frequently lose and gain both chromosomal and extrachromosomal elements [1] including:

* insertion sequences
* rep sequences
* ICE elements
* plasmids
* prophage

This can be particularly interesting to food microbiologists in the context of adaptations to dynamic niches - such as during food fermentations. In order to detect and characterise this kind of genomic plasticity, we require high quality bacterial genome assemblies which are both:

* Complete - one contig per replicon
* Accurate - fully match the actual DNA sequence of the organism

Short-read sequencing (e.g. Illumina) generates highly accurate reads, but the short length of reads (100-300bp) hinders assembly, particularly at repetitive regions highlighted above (IS, ICE, REP), resulting in fragmented draft assemblies. Furthermore, dynamic genome elements (such as ICE elements, IS) are often themselves repetitive, meaning that their true biological presence is not reflected in the draft assembly.

1. `questions` are displayed at the beginning of the episode to prime the
    learner for the content.
2. `objectives` are the learning objectives for an episode displayed with
    the questions.
3. `keypoints` are displayed at the end of the episode to reinforce the
    objectives.

::::::::::::::::::::::::::::::::::::: challenge 

## Insertion sequences?

Insertion sequences are short genomic elements which are frequently found in bacterial genomes. They can shape genomes by moving around, with the potential to generate deletions and influence gene expression levels.

:::::::::::::::::::::::: solution 

## Show more
 
![Overview of IS - reproduced from 10.1128/spectrum.02112-21](https://www.ncbi.nlm.nih.gov/pmc/articles/instance/9241782/bin/spectrum.02112-21-f007.jpg){alt='Insertion Sequences'}
:::::::::::::::::::::::::::::::::::::

## REP sequences?

REP sequences are genomic regions containing highly repetitive and palindromic sequences. They are often located in the the extragenic space of some bacterial genomes e.g. ERIC sequences in Enterobacterales members (Enterobacterial Repetitive Intergenic Consensus).

:::::::::::::::::::::::: solution 

## Show more

![Overview of rep sequences - reproduced from 10.1111/1574-6976.12036](https://d3i71xaburhd42.cloudfront.net/9d601ea51726a3257a80ba2f7cc9f98c4a569397/2-Figure1-1.png){alt='Examples of rep sequences'}

:::::::::::::::::::::::::::::::::::::

## ICEs

Integrative and Conjugative elements are mobile genetic elements which can move between hosts and donors through conjugation. They are flanked on either side by direct repeat sequences, which allow them to excise through site-specific recombination.

:::::::::::::::::::::::: solution 

## Show more
 
![Overview of ICE structure - reproduced from 10.1007/s10142-022-00903-2](https://media.springernature.com/lw685/springer-static/image/art%3A10.1007%2Fs10142-022-00903-2/MediaObjects/10142_2022_903_Fig2_HTML.png?as=webp){alt='ICEs'}

:::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::

## Assembling the "perfect" bacterial genome?

Hybrid bacterial whole-genome assembly combines the accuracy of short reads with the additional information provided by long reads generated on Oxford Nanopore Technologies (ONT) platforms. Previous approaches used a "short-read-first" approach, only using long reads to connect short contigs generated from Illumina data. Improvements in yield and accuracy of ONT data has caused a gradual shift in the field to "long-read-first" pipelines, using short reads only for the polishing of long-read assemblies.

![Assembling the perfect bacterial genome using Oxford Nanopore and Illumina sequencing - reproduced from 10.1371/journal.pcbi.1010905](https://www.researchgate.net/publication/368938787/figure/fig1/AS:11431281124501087@1677968652785/Illustrated-overview-of-our-recommended-approach-to-perfect-bacterial-whole-genome.png){alt='Assembling the perfect bacterial genome using Oxford Nanopore and Illumina sequencing'}

## Overview of Trycycler

Bacterial genome assembly remains an open problem - Torsten Seeman, author of several important bioinformatic tools like Prokka, Snippy, immortalises this concept in the stdout of his assembly pipeline Shovill: "Remember, an assembly is just a **hypothesis** of the original sequences"! 

::::::::::::::::::::::::::::::::::::: challenge 

## Circular chromosome - end of story?

It is possible to assemble a bacterial genome and find that it is "complete" as one circular chromosome - however it could well contain a variety of errors, such as "indels" where short regions ~50bp are deleted, or missassemblies where contigs are joined in incorrect orientations.

:::::::::::::::::::::::: solution 

## Show more
 
![Assembling the perfect bacterial genome using Oxford Nanopore and Illumina sequencing - reproduced from 10.1371/journal.pcbi.1010905](https://journals.plos.org/ploscompbiol/article/figure/image?size=large&id=10.1371/journal.pcbi.1010905.g002){alt='Assembling the perfect bacterial genome using Oxford Nanopore and Illumina sequencing'}

:::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::

Several long-read assembly tools exist for genome assembly, each with their own strengths and tendency to generate certain assembly errors, as shown through benchmarking [2]:

* Flye: fast, accurate, has dedicated plasmid setting, high RAM usage
* Raven: fast, low RAM usage, issues with circularisation and missing small plasmids
* Miniasm (within Unicycler): good at achieving circularisation, but not the best at completing the chromosome
* Canu: slow, good at recovering plasmids, tendency to produce chimeric replicons + hinder circularisation

Trycycler is a tool developed by Ryan Wick and colleagues to address this problem. Keeping with the idea that any assembly is a **hypothesis** of the original bacterial genome, it looks to improve the strength of our hypothesis by finding a consensus amongst different assemblers and subsets of the entire read set. In doing so, we should be better able to identify large-scale assembly errors.

## Enough theory, time for a demo / code-along

Now that we have had a whistle-stop tour of bacterial genome assebmly, we will use Trycycler on some real world data!

::::::::::::::::::::::::::::::::::::: keypoints 

- Illumina short-read sequencing is accurate but cannot produce complete bacterial genomes
- ONT long-read sequencing is less accurate, but can resolve gaps and repeats 
- No assembler is perfect, but Trycycler lets you find the best consensus
- Long-read-first assemblies can be improved with short-read polishing

::::::::::::::::::::::::::::::::::::::::::::::::

[r-markdown]: https://rmarkdown.rstudio.com/
