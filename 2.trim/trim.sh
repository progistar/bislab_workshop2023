java -Xmx36G -jar /Users/gistar/tools/Trimmomatic-0.39/trimmomatic-0.39.jar PE \
-threads 4 \
-phred33 \
../data/genomics/SRR1925276.man_1.toy.fastq \
../data/genomics/SRR1925276.man_2.toy.fastq \
fr.paired.toy.fq.gz \
fr.unpaired.toy.fq.gz \
rv.paired.toy.fq.gz \
rv.unpaired.toy.fq.gz \
ILLUMINACLIP:/Users/gistar/tools/Trimmomatic-0.39/adapters/TruSeq3-PE-2.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36

