for sample in $(ls data/*.fastq.gz | cut -d"_" -f1 | sed "s:data/::" | sort | uniq); do bash scripts/analyse_samples.sh $sample; done;
