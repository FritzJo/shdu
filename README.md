# shdu - Shell Disk Usage Analyzer
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
## Description
shdu is a lightweight alternative to ncdu, written in bash. It currently only supports listing the size of all folders in a given directory.

## Requirements
* Bash
* fzf

## Example
```bash
shdu ./.git

0       ..
604 B   objects  
52 B    hooks 
32 B    logs
28 B    refs
8 B     info
> 4 B   branches
7/7
>
```
