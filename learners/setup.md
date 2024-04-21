---
title: Setup
---

We will be working on the Migale cluster (https://migale.inrae.fr/). If you haven't already, please request an account (https://migale.inrae.fr/ask-account).


## Data

You don't need to download any data ahead of time, it is available on the Migale cluster:

* **Raw data and scripts (500Gb)**: /save_projet/domino_wp3_isollates

* **Working directory (5Tb)**: /work_projet/domino_wp3_isollates

* **Spreadsheet with assembly info**: https://docs.google.com/spreadsheets/d/1T0EJeiJInzjfJgT4qG3eR0-DRwHkiHjyb937-c_RnLQ/edit#gid=0 

## Software Setup

::::::::::::::::::::::::::::::::::::::: discussion

### Details

You firstly need to connect to the `front` server of the Migale cluster using the login and password emailed to you when your account was approved (Teagasc participants should follow the Windows instructions)
:::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::: spoiler

### Windows

Use an SSH client like MobaXterm to create a new session. Enter 'front.migale.inrae.fr' as the remote host, tick the box to specify username and enter your login username sent by email. Enter your provided password when prompted (copy and paste may not work, so please type it manually). You may have issues to connect when logged into a corporate VPN, try disconnecting and then establishing the SSH session. Note that after 6 incorrect login attempts your account is temporarily banned for 10 mins - so let us know if you are having issues to connect!

::::::::::::::::::::::::

:::::::::::::::: spoiler

### MacOS

Use the Terminal.app

::::::::::::::::::::::::


:::::::::::::::: spoiler

### Linux
If you are one of the lucky few to have a work laptop with a linux distro and terminal access: 
Open the Terminal ( `Ctrl ` +  `Alt ` +  `T`) and  `ssh ` to the  `front` server:
```
local:~$ ssh -X yourusername@front.migale.inrae.fr
Password:
```

::::::::::::::::::::::::

## Useful commands for navigating the SGE setup
For those used to a SLURM scheduler, here are some of the most important commands:

* 'qstat' - check the status of your jobs in the queue
* 'qstat -j <jobnumber> - get more info on the status of a job (e.g. one in status "Eqw")
* 'qdel' -j <jobnumber> - delete job from the queue
* 'qlogin -q short.q -pe thread 4' - create an interactive session on a node with 4 CPUs (to exit, use the command 'exit')

Unlike SLURM, where we normally specify resource requirements with "#SBATCH" directives in our scripts, in SGE these are specified in the 'qsub' command.
For example, a bare-bones Trycycler script (cat trycycler.sh) could look like this:
```
conda activate trycycler-0.5.4
trycycler reconcile --reads *.fastq.gz --cluster_dir trycycler/cluster_001 --threads 4
conda deactivate
```
To submit the script to the SGE scheduler, we use 'qsub'. 
```
qsub -cwd -V -q short.q -N myblast -pe thread 4 myblast.sh
```
* '-cwd' : execute script in current working directory
* '-V' : pass any environmental variables to the node
* 'q' : specify the queue. For todays work, everything can be submitted to 'short.q'
* '-N' : name of the job
* '-pe thread X' : number of CPUs to reserve
   
For more detail see [https://migale.inrae.fr/faq](https://migale.inrae.fr/faq) the [Migale Tutorial](https://documents.migale.inrae.fr/posts/tutorials/migale-infra/)
