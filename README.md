# Fetal mutation core pipeline

This directory keeps only the core numbered scripts. Important parameters are
listed at the top of each script and can be changed by editing the script or by
exporting the corresponding environment variable before running it.

```text
core_pipeline/
  01.fastp.sh
  02.bwa_mem_markdup.sh
  03.BaseRecalibrator.sh
  04.ApplyBQSR.sh
  05.HaplotypeCaller_family.sh
  06.VariantFiltration.sh
  07.denovogear_auto.sh
```

## 01 fastp

```bash
bash 01.fastp.sh raw_R1.fq.gz raw_R2.fq.gz sample.clean
```

Outputs:

```text
sample.clean.R1.clean.fq.gz
sample.clean.R2.clean.fq.gz
sample.clean.fastp.json
sample.clean.fastp.html
```

## 02 bwa + mark duplicate

```bash
bash 02.bwa_mem_markdup.sh sname sample.clean.R1.clean.fq.gz sample.clean.R2.clean.fq.gz sample
```

Outputs:

```text
sample.rmdup.bam
sample.rmdup.bam.bai
sample.markdup.metrics.txt
```

## 03 BaseRecalibrator

```bash
bash 03.BaseRecalibrator.sh sample sample.rmdup.bam
```

## 04 ApplyBQSR

```bash
bash 04.ApplyBQSR.sh sample sample.rmdup.bam sample.recal_data.table
```

## 05 HaplotypeCaller

Provide all recalibrated BAM files from the family after the output name.

```bash
bash 05.HaplotypeCaller_family.sh family sample1.recal.bam sample2.recal.bam sample3.recal.bam
```

## 06 VariantFiltration

```bash
bash 06.VariantFiltration.sh family family.raw_variants.vcf.gz
```

## 07 DenovoGear

```bash
bash 07.denovogear_auto.sh family.ped family.filtered.vcf.gz family
```

Equivalent command:

```bash
dng dnm auto --ped family.ped --vcf family.filtered.vcf.gz 1> family.denovo.txt 2> family.denovo.log
```
