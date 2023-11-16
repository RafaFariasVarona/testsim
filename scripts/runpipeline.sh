mkdir -p ~/testsim/res/genome
wget -O ~/testsim/res/genome/ecoli.fasta.gz ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/005/845/GCF_000005845.2_ASM584v2/GCF_000005845.2_ASM584v2_genomic.fna.gz
gunzip ~/testsim/res/genome/ecoli.fasta.gz
echo "Running STAR index..."
    mkdir -p ~/testsim/res/genome/star_index
    STAR --runThreadN 4 --runMode genomeGenerate --genomeDir ~/testsim/res/genome/star_index/ --genomeFastaFiles ~/testsim/res/genome/ecoli.fasta --genomeSAindexNbases 9
echo
for sample in $(ls ../data/*.fastq.gz | cut -d"_" -f1 | sed "s:../data/::" | sort | uniq)
do bash ~/testsim/scripts/analyse_samples.sh $sample
done
echo "Running MultiQC..."
    mkdir -p ~/testsim/out/multiqc
    multiqc -o ~/testsim/out/multiqc ~/testsim
    echo
mkdir ~/testsim/envs
mamba env export > ~/testsim/envs/rna-seq.yaml
