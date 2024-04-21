---
title: "Running the rest of the Trycycler workflow"
teaching: 30
exercises: 2
---

:::::::::::::::::::::::::::::::::::::: questions 

- How can we arrive at a complete consensus genome from the reconciled clusters?

::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: objectives

- Be able to run the remainder of the Trycycler workflow
- Understand the limitations of the pipeline

::::::::::::::::::::::::::::::::::::::::::::::::

## Introduction

After some inevitable trial and error, you have reconciled all possible "good" clusters for your genome.

The good news is that the remaining steps are more computationally intensive but require less manual intervention.

## Running Trycycler msa

The basic command to run a multiple sequence alignment (msa) on a cluster looks like this:
```
trycycler msa --cluster_dir trycycler/cluster_001 
```
or, in other words, as a cluster job:
```
qsub -cwd -V -N tm -e err/try_msa_001 -o out/try_msa_001 -pe thread 4 -b y "conda activate trycycler-0.5.4 && trycycler msa --cluster_dir trycycler/cluster_001 --threads 4 && conda deactivate"
```
Again, a bash script is provided whcih will automatically submit a job for each cluster (run in the main isolate directory):
```
/save_projet/domino_wp3_isollates/scripts/msa.sh
```
The alignment can take some time, especially for the chromosomal cluster (check resources). When the msa job concludes, a new file '3_msa.fasta' will be generated in the cluster directory.

## Trycycler Partition

Next, the original sequencing reads are partitioned amongst the clusters, to see where they best align. For more info, read the [Trycycler wiki: Partitioning reads](https://github.com/rrwick/Trycycler/wiki/Partitioning-reads)
```
trycycler partition --reads *.fastq.gz --cluster_dirs trycycler/cluster_*
```
or submitted through qsub like:
```
qsub -cwd -V -N tp -e err/try_par -o out/try_par -pe thread 4 -b y "conda activate trycycler-0.5.4 && trycycler partition --reads *.fastq.gz --cluster_dir trycycler/cluster_* --threads 4 && conda deactivate"
```
or use the provided script:
```
/save_projet/domino_wp3_isollates/scripts/partition.sh
```
When the job concludes, a new file '4_reads.fastq' will be generated in the cluster directory. Almost there!

## Trycycler Consensus

This is the last step in the Trycycler pipeline! Briefly, it looks to resolve areas of divergence (alternate alignments in the msa) by examining how well-supported each option is by the sequencing reads.
```
trycycler consensus --cluster_dir trycycler/cluster_001
```
again, this can be submitted through qsub:
```
qsub -cwd -V -N tcon -e err/try_con -o out/try_con -pe thread 4 -b y "conda activate trycycler-0.5.4 && trycycler consensus --cluster_dir trycycler/cluster_001 --threads 4 && conda deactivate"
```
or, use the script:
```
/save_projet/domino_wp3_isollates/scripts/trycycler_consensus.sh
```
 It will generate a '7_final_consensus.fasta' file, which represents the consensus assembly for that cluster. It will still likely benefit from polishing with long and/or short reads later on. 
[r-markdown]: https://rmarkdown.rstudio.com/
