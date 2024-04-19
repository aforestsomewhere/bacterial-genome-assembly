---
title: "Using Trycycler on the Migale cluster"
teaching: 30
exercises: 2
---

:::::::::::::::::::::::::::::::::::::: questions 

- Why use Trycycler to assemble bacterial genomes with long-read data?

::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: objectives

- Understand common errors that can occur during assembly
- Become familiar with the Trycycler approach 

::::::::::::::::::::::::::::::::::::::::::::::::

## Introduction

Bacterial genomes are dynamic landscapes. They may frequently lose and gain both chromosomal and extrachromosomal elements such as insertion sequences (IS), REP sequences, ICE elements, plasmids and prophage.

This can be particularly interesting to food microbiologists in the context of adaptations to dynamic niches - such as during food fermentations! In order to detect and characterise this kind of genomic plasticity, we require high quality bacterial genome assemblies which are both:

* Complete - one contig per replicon
* Accurate - fully match the actual DNA sequence of the organism

Short-read sequencing (e.g. Illumina) generates highly accurate reads, but the short length of reads (typically 150-300bp) cannot resolve repetitive or difficult-to-sequence regions, resulting in fragmented draft assemblies. Importantly, dynamic genome elements such as IS, REP and ICE are often themselves repetitive, meaning that their presence is not reflected in the draft assembly, yet they can be quite influential on the phenotype of bacterial isolates.

::::::::::::::::::::::::::::::::::::: challenge 

## Insertion sequences (IS)

:::::::::::::::::::::::: solution 

## Show more
Insertion sequences (IS) are short genomic elements which are frequently found in bacterial genomes. They can shape genomes as they move around, potentially introducing deletions, mutations and influencing gene expression.
![Overview of IS - reproduced from 10.1128/spectrum.02112-21](https://www.ncbi.nlm.nih.gov/pmc/articles/instance/9241782/bin/spectrum.02112-21-f007.jpg){alt='Insertion Sequences'}
:::::::::::::::::::::::::::::::::::::

## REP sequences

:::::::::::::::::::::::: solution 

## Show more
REP sequences are genomic regions containing highly repetitive and palindromic sequences. They are often located in the the extragenic space of some bacterial genomes e.g. ERIC (Enterobacterial Repetitive Intergenic Consensus) sequences in the Enterobacterales.
![Overview of rep sequences - reproduced from 10.1111/1574-6976.12036](https://d3i71xaburhd42.cloudfront.net/9d601ea51726a3257a80ba2f7cc9f98c4a569397/2-Figure1-1.png){alt='Examples of rep sequences'}

:::::::::::::::::::::::::::::::::::::

## Integrative and Conjugative Elements (ICEs)

:::::::::::::::::::::::: solution 

## Show more
Integrative and Conjugative Elements (ICEs) are mobile genetic elements capable of moving between hosts and donors through conjugation. They are flanked on either side by direct repeat sequences, which allow them to excise via site-specific recombination.
![Overview of ICE structure - reproduced from 10.1007/s10142-022-00903-2](https://media.springernature.com/lw685/springer-static/image/art%3A10.1007%2Fs10142-022-00903-2/MediaObjects/10142_2022_903_Fig2_HTML.png?as=webp){alt='ICEs'}

:::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::

## Assembling the "perfect" bacterial genome?

Bacterial genome assembly remains an open problem - Torsten Seeman, immortalises this concept in the stdout of his assembly pipeline Shovill: "Remember, an assembly is just a **hypothesis** of the original sequences"! 

Hybrid bacterial whole-genome assembly combines the accuracy of short reads with the additional information provided by long reads generated on Oxford Nanopore Technologies (ONT) platforms. Previous approaches used a "short-read-first" approach, only using long reads to connect short contigs generated from Illumina data. Improvements in yield and accuracy of ONT data has caused a gradual shift in the field to "long-read-first" pipelines, using short reads only for the polishing of long-read assemblies.

::::::::::::::::::::::::::::::::::::: challenge 
## Example: long-read-first assembly pipeline:
:::::::::::::::::::::::: solution 
Note: this is by far from the only possible pipeline and does not include, for example, PacBio sequencing.
![Assembling the perfect bacterial genome using Oxford Nanopore and Illumina sequencing - reproduced from 10.1371/journal.pcbi.1010905](https://www.researchgate.net/publication/368938787/figure/fig1/AS:11431281124501087@1677968652785/Illustrated-overview-of-our-recommended-approach-to-perfect-bacterial-whole-genome.png){alt='Assembling the perfect bacterial genome using Oxford Nanopore and Illumina sequencing'}
:::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::

Other pipelines exist which completely automate the long-read assembly process, such as Hybracter (https://github.com/gbouras13/hybracter) or Dragonflye (https://github.com/rpetit3/dragonflye). Trycycler on the other hand is deterministic and requires manual intervention at different points. So, one of the obvious `questions` could be: why dedicate extra time to using Trycycler?

::::::::::::::::::::::::::::::::::::: challenge 

## Closed genomes versus accuracy
Flye assembled one circular contig for my bacterial chromosome - isn't that good enough?

:::::::::::::::::::::::: solution 

## Show more
It is possible to assemble a bacterial genome and find that it is "closed" as one circular chromosome - however it may not be very accurate or in fact complete! Long-read-only assemblies can contain a variety of errors, such as "indels" (deletions ~50bp), or missassemblies where contigs are joined in incorrect orientations.

![Assembling the perfect bacterial genome using Oxford Nanopore and Illumina sequencing - reproduced from 10.1371/journal.pcbi.1010905](https://journals.plos.org/ploscompbiol/article/figure/image?size=large&id=10.1371/journal.pcbi.1010905.g002){alt='Assembling the perfect bacterial genome using Oxford Nanopore and Illumina sequencing'}

:::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::

## Overview of Trycycler

Trycycler is a tool developed by Ryan Wick and colleagues to address an issue they had uncovered in previous benchmarking work. Several long-read assembly tools exist for genome assembly, each with their own strengths and tendency to generate certain assembly errors, for example:

* Flye: fast, accurate, has dedicated plasmid setting, high RAM usage
* Raven: fast, low RAM usage, issues with circularisation and missing small plasmids
* Miniasm (within Unicycler): good at achieving circularisation, but not the best at completing chromosomal contigs
* Canu: slow, good at recovering plasmids, tendency to produce chimeric replicons + hinder circularisation

Keeping with the idea that any assembly is a **hypothesis** of the original bacterial genome, Trycycler looks to improve the strength of our **hypothesis** by finding a consensus amongst different assemblers and subsets of the entire read set. In doing so, we should be better able to identify and correct large-scale assembly errors. 

![Overview of the Trycycler long-read assembly pipeline - reproduced from Wick et al (2021)](https://www.researchgate.net/publication/354593531/figure/fig1/AS:1068171633106963@1631683371578/Overview-of-the-Trycycler-long-read-assembly-pipeline-Before-Trycycler-is-run-the-user.png){alt='Overview of the Trycycler long-read assembly pipeline'}

It is important to remember that Trycycler assemblies are still unlikely to be perfect, and will frequently contain "homopolymer errors" - however these can be corrected by long-read and particularly short-read polishing (there is debate on how much polishing is helpful - for further reading see Ryan Wick's blog post: https://rrwick.github.io/2023/11/06/accuracy-vs-depth-update.html).

::::::::::::::::::::::::::::::::::::: challenge 
## A more detailed look at the Trycycler process
:::::::::::::::::::::::: solution 
![Illustrated pipeline overview - reproduced from https://github.com/rrwick/Trycycler/wiki/](https://github.com/rrwick/Trycycler/wiki/images/pipeline.png){alt='Illustrated pipeline overview'}
:::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::

## Enough theory, time for a demo!

Now that we have had a whistle-stop tour of bacterial genome assebmly, we will use Trycycler on some real world data!

::::::::::::::::::::::::::::::::::::: keypoints 

- Illumina short-read sequencing is accurate but cannot produce complete bacterial genomes
- ONT long-read sequencing is less accurate, but can resolve gaps and repeats 
- No assembler is perfect, but Trycycler lets you find the best consensus
- Long-read-first assemblies can be improved with short-read polishing

::::::::::::::::::::::::::::::::::::::::::::::::

[r-markdown]: https://rmarkdown.rstudio.com/
