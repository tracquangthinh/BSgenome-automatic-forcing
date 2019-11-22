# BSgenome-automatic-forcing

**BSgenome-automatic-forcing** is a script to automatically force a BSgenome data package. Currently, this script supports you to forge a package from Ensembl fasta files (**HomoSapiens - release 37.75**). For futher modifications, referring to [next section](#how-to-modify)

## Requirements

Obviously, you need to install **BSgenome** pakage first.

## Installation

Simply executing `bash install.sh` on the terminal. **HomoSapiens(37.75)** fasta files from Ensembl will be downloaded and **BSgenome.Sapiens.Ensembl.3775** package will be built and installed on your environment.

**Warning**: If **.TwoBits_export** error happens, please create **extdata** following [the author's suggestion](https://support.bioconductor.org/p/124169/):
```
cd `echo 'cat(system.file(package="BSgenome"))' | R --vanilla --slave`
cd pkgtemplates/BSgenome_datapkg/
mkdir inst
mkdir inst/extdata
```

## Example

After executing the script, you can try an example as follows:

```
> library(BSgenome.Sapiens.Ensembl.3775)
> Sapiens[["1"]]

  249250621-letter "DNAString" instance
seq: NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN...NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN

> gr = GRanges(seqnames=c("1", "2", "MT"), ranges=IRanges(start=101:103, width=9))
> getSeq(Sapiens, gr)

  A DNAStringSet instance of length 3
    width seq
[1]     9 NNNNNNNNN
[2]     9 NNNNNNNNN
[3]     9 GCCGGAGCA
```

## How to modify

1. **Download paths**: You can change the link pattern in `wget` command or simply remove these lines if you already have your own fasta files in *seq* folder.
2. **seed_template**: If you use your own dataset, you have to modify this file and be careful for some parameters as follows:

- **Package**: name of the package you will use to call `library`.
- **BSgenomeObjname**: short name of the genome, e.g. *Sapiens*.
- **seqnames**: (vector) name of fasta files in **seq** folder, also name of chromosomes.