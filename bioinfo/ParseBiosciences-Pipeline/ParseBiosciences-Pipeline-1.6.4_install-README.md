ParseBiosciences-Pipeline/1.6.4
========================

<https://www.parsebiosciences.com/>

Used under license:
Custom


Structure creating script (makeroom_ParseBiosciences-Pipeline_1.6.4.sh) moved to /sw/bioinfo/ParseBiosciences-Pipeline/makeroom_1.6.4.sh

LOG
---

    makeroom.sh "-t" "ParseBiosciences-Pipeline" "-v" "1.6.4" "-w" "https://www.parsebiosciences.com/" "-c" "bioinfo" "-l" "Custom" "-d" "Combinatorial barcoding technology strips away the limitations and frustrations of yesterday’s single cell approach. It ditches the specialized instrument, freeing you to pursue unprecedented discoveries. Unleash the potential of single cell." "-s" "pipelines" "-f"
    ./makeroom_ParseBiosciences-Pipeline_1.6.4.sh
    source /sw/bioinfo/ParseBiosciences-Pipeline/SOURCEME_ParseBiosciences-Pipeline_1.6.4 && cd $SRCDIR

    # Björn C has account and can reach https://support.parsebiosciences.com
    # Instructions found here: https://support.parsebiosciences.com/hc/en-us/articles/23060102930580-Pipeline-Installation-Current-Version

    wget https://support.parsebiosciences.com/hc/en-us/article_attachments/45303972434964 # may need to download to computer due to the restrictions and transfered to the cluster

    mkdir -p $PREFIX/bin && cd $PREFIX/bin
    # Installation moved into a Singularity container
    # make sure you have the installation .zip file  ParseBiosciences-Pipeline.1.6.4.zip and the split-pipe.def in $PREFIX/bin
    
    apptainer build split-pipe split-pipe.def


## Test in full node

### Download genome files from Ensembl
wget https://ftp.ensembl.org/pub/release-113/fasta/homo_sapiens/dna/Homo_sapiens.GRCh38.dna.primary_assembly.fa.gz
wget https://ftp.ensembl.org/pub/release-113/gtf/homo_sapiens/Homo_sapiens.GRCh38.113.chr.gtf.gz


### Create indexed reference genome
split-pipe \
--mode mkref \
--genome_name GRCh38 \
--nthreads 16 \
--fasta ./Homo_sapiens.GRCh38.dna.primary_assembly.fa.gz \
--genes ./Homo_sapiens.GRCh38.113.chr.gtf.gz \
--output_dir ./GRCh38


### Run pipeline
split-pipe \
--mode all \
--chemistry v3 \
--kit WT \
--nthreads 16 \
--fq1 ./fastq/pbmc_3Mreads_S1_R1.fastq.gz \
--output_dir ./S1-out \
--genome_dir ./GRCh38 \
--sample all-well A1-D12

split-pipe \
--mode all \
--chemistry v3 \
--kit WT \
--nthreads 16 \
--fq1 ./fastq/pbmc_3Mreads_S2_R1.fastq.gz \
--output_dir ./S2-out \
--genome_dir ./GRCh38 \
--sample all-well A1-D12

split-pipe \
--mode comb \
--output_dir ./combined \
--sublibraries ./S1-out ./S2-out
