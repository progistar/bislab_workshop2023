samtools sort -@ 4 -o final_BTS_Aligned.out.sorted.bam ../3.align/final_BTS_Aligned.out.sam
samtools index -@ 4 -o final_BTS_Aligned.out.sorted.bam.bai final_BTS_Aligned.out.sorted.bam