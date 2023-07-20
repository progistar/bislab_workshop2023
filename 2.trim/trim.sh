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

# ILLUMINACLIP:<adapter_file_name>:<seed_mismatches>:<palindrom clip threshold>:<simple clip threshold>
# seed_mismatches: specify the maximum base mismatch count in the ‘seed’ (16 bases).
# clip threshold: Each matching base adds just over 0.6, while each mismatch reduces the alignment score by Q/10. ex> full matches: 34 * 0.6 = 20.4 (clip)ex> three mismatches with Q=30: 31 * 0.6 – 3 * 3 = 9.6 (pass)
# LEADING/TRAILING: cut bases off the start/end of a read, if below a threshold quality.
# SLIDINGWINDOW:<window_size>:<required_quality>
# MINLEN: the minimum length of reads
