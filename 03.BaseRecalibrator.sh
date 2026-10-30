#!/bin/bash

gatk=${GATK:-gatk}

ref=${REFERENCE_FASTA:-/share/home/yanzhiqiang/DB/Homo_sapiens/UCSC/hg38/Sequence/WholeGenomeFasta/genome.fa}
known_indel=${KNOWN_INDEL:-/share/home/yanzhiqiang/DB/1000Gemome/hg38/Homo_sapiens_assembly38.known_indels.vcf}

sname=$1
bam=$2

$gatk BaseRecalibrator \
  -R $ref \
  -I $bam \
  --known-sites $known_indel \
  --output ${sname}.recal_data.table
