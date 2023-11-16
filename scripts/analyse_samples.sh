if [ "$#" -eq 1 ]
then
    sampleid=$1
    echo "Running FastQC..."
    mkdir -p ~/testsim/out/fastqc
    fastqc -o ~/testsim/out/fastqc ~/testsim/data/${sampleid}*.fastq.gz
    echo
    echo "Running cutadapt..."
    mkdir -p ~/testsim/log/cutadapt
    mkdir -p ~/testsim/out/cutadapt
    cutadapt -m 20 -a AGATCGGAAGAGCACACGTCTGAACTCCAGTCA -A AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT -o ~/testsim/out/cutadapt/${sampleid}_1.trimmed.fastq.gz -p ~/testsim/out/cutadapt/${sampleid}_2.trimmed.fastq.gz ~/testsim/data/${sampleid}_1.fastq.gz ~/testsim/data/${sampleid}_2.fastq.gz > ~/testsim/log/cutadapt/${sampleid}.log
    echo
    echo "Running STAR index..."
    mkdir -p ~/testsim/res/genome/star_index
    STAR --runThreadN 4 --runMode genomeGenerate --genomeDir ~/testsim/res/genome/star_index/ --genomeFastaFiles ~/testsim/res/genome/ecoli.fasta --genomeSAindexNbases 9
    echo
    echo "Running STAR alignment..."
    mkdir -p ~/testsim/out/star/${sampleid}
    STAR --runThreadN 4 --genomeDir ~/testsim/res/genome/star_index/ --readFilesIn ~/testsim/out/cutadapt/${sampleid}_1.trimmed.fastq.gz ~/testsim/out/cutadapt/${sampleid}_2.trimmed.fastq.gz --readFilesCommand zcat --outFileNamePrefix ~/testsim/out/star/${sampleid}/
    echo
    echo "Running MultiQC..."
    mkdir -p ~/testsim/out/multiqc
    multiqc -o ~/testsim/out/multiqc
    echo
else
    echo "Usage: $0 <sampleid>"
    exit 1
fi
