ClusterSV/2021-3f3b749
========================

<https://github.com/cancerit/ClusterSV>

Used under license:
AGPL-3


Structure creating script (makeroom_ClusterSV_2021-3f3b749.sh) moved to /sw/bioinfo/ClusterSV/makeroom_2021-3f3b749.sh

LOG
---

    makeroom.sh "-t" "ClusterSV" "-v" "2021-3f3b749" "-w" "https://github.com/cancerit/ClusterSV" "-c" "bioinfo" "-l" "AGPL-3" "-d" "SV clustering: This is the R script used in the PCAWG-6 SV mechanisms project to group rearrangements into rearrangement clusters and footprints." "-s" "misc"
    ./makeroom_ClusterSV_2021-3f3b749.sh
    source /sw/bioinfo/ClusterSV/SOURCEME_ClusterSV_2021-3f3b749 && cd $SRCDIR
    cd $PREFIX
    git clone https://github.com/cancerit/ClusterSV
    mv -fa ClusterSV/* .
    rmdir ClusterSV/
    cd R
    ml R_packages/4.3.1
    Rscript run_cluster_sv.R
    chmod +x run_cluster_sv.R
    ./run_cluster_sv.R
    # Edit module
    run_cluster_sv.R


