---
title: Setup
---

We will be working on the Migale cluster (https://migale.inrae.fr/). If you haven't already, please request an account (https://migale.inrae.fr/ask-account) or let us know.


## Data

<!--
FIXME: place any data you want learners to use in `episodes/data` and then use
       a relative link ( [data zip file](data/lesson-data.zip) ) to provide a
       link to it, replacing the example.com link.
-->

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

Use an SSH client like MobaXterm to create a new session. Enter 'front.migale.inrae.fr' as the remote host, tick the box to specify username and enter your provided login. Enter your password when prompted.

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

