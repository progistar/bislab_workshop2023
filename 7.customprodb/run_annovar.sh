perl table_annovar.pl BTS.filt.vcf humandb/ \
-buildver hg38 \
-out BTS \
-protocol ensGene \
-operation g -nastring . \
-vcfinput \
--thread 4 \
--maxgenethread 4 \
-polish