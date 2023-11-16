mkdir -p res/genome
wget -O res/genome/ecoli.fasta.gz ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/005/845/GCF_000005845.2_ASM584v2/GCF_000005845.2_ASM584v2_genomic.fna.gz
gunzip res/genome/ecoli.fasta.gz
for sample in $(ls ../data/*.fastq.gz | cut -d"_" -f1 | sed "s:../data/::" | sort | uniq); do bash ~/testsim/scripts/analyse_samples.sh $sample; done;
