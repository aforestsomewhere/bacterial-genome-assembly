---
title: "Reconciling clusters"
teaching: 30
exercises: 2
---

:::::::::::::::::::::::::::::::::::::: questions 

- What happens next to "good" clusters we identified?

::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: objectives

- Understand how and why to exclude a contig from a cluster
- Be able to manually repair duplicated contigs

::::::::::::::::::::::::::::::::::::::::::::::::

## Introduction

In the previous step we identified clusters of contigs, which could each represent true replicons present in our isolates. However, they were primarily clustered using Mash distance and before alignment, they need to be standardised in terms of length, similarity and orientation. We will use Trycycler's 'reconcile' function to achieve this.
([Reconciling contigs](https://github.com/rrwick/Trycycler/wiki/Reconciling-contigs))

![Trycycler folder after clusters have been manually assessed](fig/folder4.jpg){alt='Trycycler folder after clusters have been manually assessed'}

## Running Trycycler Reconcile

The basic command to reconcile a cluster looks like this:
```
trycycler reconcile --reads *.fastq.gz --cluster_dir trycycler/cluster_001 
```
and we could submit this as a cluster job using the following command (changing the number of the cluster each time for the stderr, stdout and --cluster_dir parameters):
```
qsub -cwd -V -N tr_test -e err/try_rec_001 -o out/try_rec_001 -pe thread 4 -b y "conda activate trycycler-0.5.4 && trycycler reconcile --reads *.fastq.gz --cluster_dir trycycler/cluster_001 --threads 4 && conda deactivate"
qsub -cwd -V -N tr_test -e err/try_rec_002 -o out/try_rec_002 -pe thread 4 -b y "conda activate trycycler-0.5.4 && trycycler reconcile --reads *.fastq.gz --cluster_dir trycycler/cluster_002 --threads 4 && conda deactivate"
```
However, for simplicity, a bash script is provided which will detect the clusters present, and generate and submit a script to run Trycycler reconcile on each. You can run it like this:
```
../scripts/reconcile.sh
```
If Trycycler was able to reconcile the cluster, a new file '2_all_seqs.fasta' will be generated in the cluster directory, containing the reconciled contigs. Frequently, it will fail to produce output, meaning that manual intervention is required to resolve.

## Manual interventions

[r-markdown]: https://rmarkdown.rstudio.com/
