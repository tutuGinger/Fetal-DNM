#!/bin/bash

fastp=${FASTP:-fastp}
threads=${THREADS:-8}

fq1=$1
fq2=$2
out=$3

$fastp \
  -i $fq1 \
  -I $fq2 \
  -o ${out}.R1.clean.fq.gz \
  -O ${out}.R2.clean.fq.gz \
  --detect_adapter_for_pe \
  --qualified_quality_phred 20 \
  --n_base_limit 5 \
  --thread $threads \
  --json ${out}.fastp.json \
  --html ${out}.fastp.html
