#!/bin/bash

dng=${DNG:-dng}

ped=$1
vcf=$2
out=$3

$dng dnm auto \
  --ped $ped \
  --vcf $vcf \
  1> ${out}.denovo.txt \
  2> ${out}.denovo.log
