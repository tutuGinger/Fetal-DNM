#!/bin/bash

gatk=${GATK:-gatk}

ref=${REFERENCE_FASTA:-/share/home/yanzhiqiang/DB/Homo_sapiens/UCSC/hg38/Sequence/WholeGenomeFasta/genome.fa}

sname=$1
bam=$2
recal_table=$3

$gatk ApplyBQSR \
  -R $ref \
  -I $bam \
  -bqsr $recal_table \
  -O ${sname}.recal.bam
