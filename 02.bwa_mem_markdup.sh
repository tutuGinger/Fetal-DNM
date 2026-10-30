#!/bin/bash

bwa=${BWA:-bwa}
samtools=${SAMTOOLS:-samtools}
java=${JAVA:-java}

index=${BWA_INDEX:-/share/home/yanzhiqiang/DB/Homo_sapiens/UCSC/hg38/Sequence/BWAIndex/genome.fa}
picard=${PICARD_JAR:-/share/home/yanzhiqiang/software/picard-tools-1.141/picard.jar}
threads=${THREADS:-12}
mapq=${MAPQ:-30}
java_mem=${JAVA_MEM:-120g}

sname=$1
fq1=$2
fq2=$3
out=$4

rg="@RG\tID:${sname}\tPL:ILLUMINA\tLB:${sname}\tSM:${sname}"

$bwa mem -v 1 -R "$rg" -M -t $threads $index $fq1 $fq2 > ${out}.sam

$samtools view -h -b -q $mapq ${out}.sam > ${out}.mapq${mapq}.bam
$samtools sort -@ $threads -o ${out}.mapq${mapq}.sort.bam ${out}.mapq${mapq}.bam
$samtools index ${out}.mapq${mapq}.sort.bam

$java -Xmx${java_mem} -jar $picard MarkDuplicates \
  I=${out}.mapq${mapq}.sort.bam \
  O=${out}.rmdup.bam \
  M=${out}.markdup.metrics.txt \
  REMOVE_DUPLICATES=true \
  VALIDATION_STRINGENCY=SILENT

$samtools index ${out}.rmdup.bam
