tobias/0.17.3-86e7729
========================

<https://github.com/loosolab/TOBIAS>

Used under license:
MIT


Structure creating script (makeroom_tobias_0.17.3-86e7729.sh) moved to /sw/bioinfo/tobias/makeroom_0.17.3-86e7729.sh

LOG
---

    /home/bjornv/git/install-methods/makeroom.sh "-t" "tobias" "-v" "0.17.3-86e7729" "-l" "MIT" "-w" "https://github.com/loosolab/TOBIAS" "-d" "Transcription factor Occupancy prediction By Investigation of ATAC-seq Signal" "-s" "annotation"
    ./makeroom_tobias_0.17.3-86e7729.sh


    # Load modules
    module load bioinfo-tools
    module load samtools/1.20
    module load BEDTools/2.31.1
    module load python/3.11.8
    module load gcc/10.3.0
    module load cmake/3.26.3

    
    # Git clone and checkout
    cd $SRCDIR
    git clone https://github.com/loosolab/TOBIAS.git
    cd TOBIAS
    git reset --hard 86e7729

    # Create venv
    python -m venv $PREFIX/tobias_env
    source $PREFIX/tobias_env/bin/activate 
    pip install cython 
    pip install "PyPDF2<3.0.0" # Downgrade PyPDF
    pip install pyarrow-20.0.0
    pip install gimmemotifs
    pip install .

    # Lift out TOBIAS
    mkdir $PREFIX/bin
    cp $PREFIX/tobias_env/bin/TOBIAS $PREFIX/bin



# Download test data and test
    cd $PREFIX
    TOBIAS DownloadData --bucket data-tobias-2020
    ln -s data-tobias-2020 test_data
 
    TOBIAS ATACorrect --bam $PREFIX/test_data/Bcell.bam --genome $PREFIX/test_data/genome.fa.gz --peaks $PREFIX/test_data/merged_peaks.bed --blacklist $PREFIX/test_data/blacklist.bed --outdir $PREFIX/test_data/ATACorrect_test --cores 8
    TOBIAS FootprintScores --signal $PREFIX/test_data/Bcell_corrected.bw --regions $PREFIX/test_data/merged_peaks.bed --output Bcell_footprints.bw --cores 8
    TOBIAS BINDetect --motifs $PREFIX/test_data/motifs.jaspar --signals $PREFIX/test_data/Bcell_footprints.bw $PREFIX/test_data/Tcell_footprints.bw --genome $PREFIX/test_data/genome.fa.gz --peaks $PREFIX/test_data/merged_peaks_annotated.bed --peak_header $PREFIX/test_data/merged_peaks_annotated_header.txt --outdir BINDetect_output --cond_names Bcell Tcell --cores 8
    TOBIAS PlotAggregate --TFBS $PREFIX/test_data/BATF_all.bed  --signals $PREFIX/test_data/Bcell_corrected.bw $PREFIX/test_data/Tcell_corrected.bw --output BATFJUN_footprint_comparison_all.pdf --share_y both --plot_boundaries --signal-on-x
    TOBIAS PlotHeatmap --TFBS $PREFIX/test_data/BATF_all.bed --signals $PREFIX/test_data/Bcell_*.bw --output BATFJUN_heatmap.png --sort_by -2
    TOBIAS PlotTracks --bigwigs $PREFIX/test_data/*cell_corrected.bw --bigwigs $PREFIX/test_data/*cell_footprints.bw --regions $PREFIX/test_data/plot_regions.bed --sites $PREFIX/test_data/binding_sites.bed --highlight $PREFIX/test_data/binding_sites.bed --gtf $PREFIX/test_data/genes.gtf --colors red darkblue red darkblue
    TOBIAS FormatMotifs --input $PREFIX/test_data/individual_motifs/* --task join --output joined_motifs.jaspar
    TOBIAS ClusterMotifs --motifs $PREFIX/test_data/motifs.jaspar --threshold 0.4 --type png
    TOBIAS CreateNetwork --TFBS $PREFIX/test_data/annotated_tfbs/* --origin $PREFIX/test_data/motif2gene_mapping.txt 
    TOBIAS FilterFragments --bam $PREFIX/test_data/Bcell.bam --regions $PREFIX/test_data/merged_peaks.bed
    TOBIAS ScoreBed --bed $PREFIX/test_data/merged_peaks.bed --bigwigs $PREFIX/test_data/Bcell_corrected.bw --output merged_peaks_scored.bed
    TOBIAS MaxPos --bed $PREFIX/test_data/merged_peaks.bed --bigwig $PREFIX/test_data/Bcell_footprints.bw --output merged_peaks_max.bed
    TOBIAS SubsampleBam --bam $PREFIX/test_data/Bcell.bam --no_rand 1 --step 50 --outdir subsamplebam_output
    TOBIAS Log2Table --logfiles $PREFIX/test_data/BATF_footprint_comparison_all.log --outdir log2table_output
    echo 'CTCF KLF4 GATA NFAT MEF2 NR2F1 ETS NRF1 ELK ATF' > $PREFIX/test_data/TF_names.txt
    TOBIAS PlotChanges --bindetect $PREFIX/test_data/Tcell_bindetect_results.txt --TFS $PREFIX/test_data/TF_names.txt
    TOBIAS TFBScan --motifs $PREFIX/test_data/motifs.jaspar --fasta $PREFIX/test_data/genome.fa.gz --cores 10
    TOBIAS TFBScan --motifs $PREFIX/test_data/motifs.jaspar --fasta $PREFIX/test_data/genome.fa.gz --cores 10 --regions $PREFIX/test_data/merged_peaks_annotated.bed --add-region-columns



