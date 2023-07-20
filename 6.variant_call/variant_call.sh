## Mark duplicates

java -jar /Users/gistar/tools/broadinstitute-picard-4811797/picard.jar \
MarkDuplicates \
I=../4.samtools/final_BTS_Aligned.out.sorted.bam \
O=final_BTS_Aligned.out.sorted.dup.bam \
M=final_BTS_Aligned.out.sorted.dup.metrics



## Fasta index

samtools faidx ../data/genomics/BTS.fa
/Users/gistar/tools/gatk-4.4.0.0/gatk --java-options "-Xmx2G" CreateSequenceDictionary \
-R ../data/genomics/BTS.fa



## SplitNCigarReads

/Users/gistar/tools/gatk-4.4.0.0/gatk --java-options "-Xmx2G" SplitNCigarReads \
-R ../data/genomics/BTS.fa \
-I final_BTS_Aligned.out.sorted.dup.bam \
-O final_BTS_Aligned.out.sorted.dup.split.bam



## Sample numbering
java -jar /Users/gistar/tools/broadinstitute-picard-4811797/picard.jar \
AddOrReplaceReadGroups \
I=final_BTS_Aligned.out.sorted.dup.split.bam \
RGID=1 \
RGLB=CHR1 \
RGPL=ILLUMINA \
RGPU=PE \
RGSM=BTS \
O=final_BTS_Aligned.out.sorted.dup.split.RG.bam



## bam index

samtools index final_BTS_Aligned.out.sorted.dup.split.RG.bam


## HaplotypeCaller

/Users/gistar/tools/gatk-4.4.0.0/gatk --java-options "-Xmx2G" HaplotypeCaller \
-R ../data/genomics/BTS.fa \
-I final_BTS_Aligned.out.sorted.dup.split.RG.bam \
-O BTS.vcf



## Hard-filter

/Users/gistar/tools/gatk-4.4.0.0/gatk --java-options "-Xmx2G" VariantFiltration \
-R ../data/genomics/BTS.fa \
-V BTS.vcf \
-O BTS.filt.vcf \
--filter-expression "QD < 2.0" --filter-name "QD2" \
--filter-expression "QUAL < 30.0" --filter-name "QUAL30" \
--filter-expression "SOR > 3.0" --filter-name "SOR3" \
--filter-expression "FS > 60.0" --filter-name "FS60" \
--filter-expression "MQ < 40.0" --filter-name "MQ40" \
--filter-expression "MQRankSum < -12.5" --filter-name "MQRankSum-12.5" \
--filter-expression "ReadPosRankSum < -8.0" --filter-name "ReadPosRankSum-8"

# QUAL: phred
# QD (QualByDepth): normalized QUAL by the read depth (DP)
# SOR (StrandOddRatio): strand bias estimated by the symmetric odds ratio test
# FS (FisherStrand)
# MQ (RMSMappingQuality): root mean square mapping quality over all the reads at the site
# MQRankSum (MappingQualityRankSumTest): negative means mapping qualites of the reference allele are higher than those supporting the alternate allele.
# ReadPosRankSumTest: negative value indicates that the alternate allele is foundd at the ends of reads more often than the reference allele.
# See: https://gatk.broadinstitute.org/hc/en-us/articles/360035890471-Hard-filtering-germline-short-variants