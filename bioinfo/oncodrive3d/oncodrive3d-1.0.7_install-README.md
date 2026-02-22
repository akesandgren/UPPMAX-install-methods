oncodrive3d/1.0.7
========================

<https://github.com/bbglab/oncodrive3d>

Used under license:

<https://github.com/bbglab/oncodrive3d/blob/master/LICENSE>

Structure creating script (makeroom_oncodrive3d_1.0.7.sh) moved to /sw/bioinfo/oncodrive3d/makeroom_1.0.7.sh

LOG
---

    makeroom.sh "-t" "oncodrive3d" "-v" "1.0.7" "-c" "bioinfo" "-w" "https://github.com/bbglab/oncodrive3d" "-L" "https://github.com/bbglab/oncodrive3d/blob/master/LICENSE" "-d" "Oncodrive3D is a fast and accurate computational method designed to analyze patterns of somatic mutation across tumors, with the goal of identifying three-dimensional (3D) clusters of missense mutations and detecting genes under positive selection." "-s" "misc"
    ./makeroom_oncodrive3d_1.0.7.sh

    source /sw/bioinfo/oncodrive3d/SOURCEME_oncodrive3d_1.0.7 && cd $TOOLDIR/1.0.7/rackham
    mkdir bin && cd bin
    # Build the container
    apptainer build oncodrive3d oncodrive3d.def




