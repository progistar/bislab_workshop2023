

echo "start indexing genome"
/Users/gistar/tools/STAR_2.7.10b/MacOSX_x86_64/STAR \
--runThreadN 4 \
--runMode genomeGenerate \
--genomeDir BTS_general_idx \
--genomeFastaFiles ../data/genomics/BTS.fa \
--sjdbGTFfile ../data/genomics/BTS.gtf \
--sjdbOverhang 100

echo "start first-pass"
/Users/gistar/tools/STAR_2.7.10b/MacOSX_x86_64/STAR \
--runThreadN 4 \
--genomeDir BTS_general_idx \
--readFilesCommand gunzip -c \
--readFilesIn ../2.trim/fr.paired.toy.fq.gz ../2.trim/rv.paired.toy.fq.gz \
--outTmpDir tmpSTAR \
--outSAMunmapped Within \
--outSAMattributes MD NH HI NM AS nM \
--outFileNamePrefix BTS_ \
--outFilterMultimapScoreRange 1 \
--outFilterMultimapNmax 20 \
--outFilterMismatchNmax 10 \
--alignIntronMax 500000 \
--alignMatesGapMax 1000000 \
--sjdbScore 2 \
--alignSJDBoverhangMin 1 \
--genomeLoad NoSharedMemory \
--outFilterMatchNminOverLread 0.33 \
--outFilterScoreMinOverLread 0.33 \
--sjdbOverhang 100 \
--twopass1readsN -1 \
--twopassMode Basic
--outSAMstrandField intronMotif \
--outSAMtype None \
--outSAMmode None

# towpass1readsN: the number of reads to be mapped in the 1st pass
# outSAMattributes: MD tag = String encoding mismatched and deleted reference baases
# outSAMstrandField: intronMotif = infer strand from known intron motifs
# outSAMunmapped: Within = output unmapped reads within the main SAM file
# outSAM: output SAM? (we do not need to write the results in the fisrt pass)

#mkdir SRR12285189_SUDHL4_D2_Genome_Basic_Index
## make second index
echo "generate second index"
/Users/gistar/tools/STAR_2.7.10b/MacOSX_x86_64/STAR \
--runThreadN 4 \
--runMode genomeGenerate \
--genomeDir BTS_specific_idx \
--genomeFastaFiles ../data/genomics/BTS.fa \
--sjdbOverhang 100 \
--sjdbFileChrStartEnd BTS_SJ.out.tab \
--sjdbGTFfile ../data/genomics/BTS.gtf

echo "start second-pass"
/Users/gistar/tools/STAR_2.7.10b/MacOSX_x86_64/STAR \
--runThreadN 4 \
--quantMode TranscriptomeSAM GeneCounts \
--genomeDir BTS_specific_idx \
--readFilesCommand gunzip -c \
--readFilesIn ../2.trim/fr.paired.toy.fq.gz ../2.trim/rv.paired.toy.fq.gz \
--outTmpDir tmpSTAR \
--outFilterMultimapNmax 20 \
--outFilterMismatchNmax 10 \
--alignIntronMax 500000 \
--alignMatesGapMax 1000000 \
--sjdbScore 2 \
--alignSJDBoverhangMin 1 \
--genomeLoad NoSharedMemory \
--limitBAMsortRAM 0 \
--outFilterMatchNminOverLread 0.33 \
--outFilterScoreMinOverLread 0.33 \
--sjdbOverhang 100 \
--outSAMstrandField intronMotif \
--outSAMattributes NH HI NM MD AS XS \
--outSAMunmapped Within \
--outSAMheaderHD @HD VN:1.4 \
--outFileNamePrefix final_BTS_