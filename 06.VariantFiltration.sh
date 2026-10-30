#!/bin/bash

gatk=${GATK:-gatk}

ref=${REFERENCE_FASTA:-/share/home/yanzhiqiang/DB/Homo_sapiens/UCSC/hg38/Sequence/WholeGenomeFasta/genome.fa}
filter_expr=${FILTER_EXPR:-"QD < 2.0 || DP < 20 || FS > 60.0 || MQ < 40.0 || MQRankSum < -12.5 || ReadPosRankSum < -8.0"}

out=$1
vcf=$2

$gatk VariantFiltration \
  -R $ref \
  -V $vcf \
  --filter-name fetal_mutation_hard_filter \
  --filter-expression "$filter_expr" \
  -O ${out}.filtered.vcf.gz
