#!/bin/bash

gatk=${GATK:-gatk}

ref=${REFERENCE_FASTA:-/share/home/yanzhiqiang/DB/Homo_sapiens/UCSC/hg38/Sequence/WholeGenomeFasta/genome.fa}
dbsnp=${DBSNP:-/share/home/yanzhiqiang/DB/1000Gemome/hg38/dbsnp_144.hg38.vcf}

family=$1
shift

input_bam=""
for bam in "$@"
do
  input_bam="$input_bam -I $bam"
done

$gatk HaplotypeCaller \
  -R $ref \
  $input_bam \
  -O ${family}.raw_variants.vcf.gz \
  --dbsnp $dbsnp
