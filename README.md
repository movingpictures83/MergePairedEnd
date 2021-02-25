# MergePairedEnd
# Language: R
# Input: TXT
# Output: PREFIX
# Tested with: PluMA 1.1, R 4.0.0
# dada2_1.18.0

Merge forward and reverse reads into a single set.

The plugin takes a TXT file of parameters, represented as tab-delimited keyword-value pairs:
FASTQ: Prefix for FASTQ files
DADA: Prefix for Denoised dataset
minoverlap: Minimum amount of overlap allowed before merging.

The FASTQ prefix should begin two R objects of type derep-class (package dada2), namely prefix.forward.rds and prefix.reverse.rds.
The DADA prefix works similarly, for two objects of type dada-class (package dada2).

Merged sequences are output as FASTQ files that start with the user-specified prefix.
