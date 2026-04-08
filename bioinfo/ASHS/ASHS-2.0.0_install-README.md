ASHS/2.0.0
========================

<https://sites.google.com/view/ashs-dox/home>

Used under license:



Structure creating script (makeroom_ASHS_2.0.0.sh) moved to /sw/bioinfo/ASHS/makeroom_2.0.0.sh

LOG
---

    makeroom.sh "-t" "ASHS" "-v" "2.0.0" "-c" "bioinfo" "-w" "https://sites.google.com/view/ashs-dox/home" "-d" "ASHS is software for automatic segmentation of the medial temporal lobe (MTL) substructures from brain MRI scans." "-s" "misc"
    ./makeroom_ASHS_2.0.0.sh
    cd $SRCDIR
    # Download files... needs browser GUI
    unzip ashs-fastashs_2.0.0_07202018.zip
    mv ashs-fastashs_beta/* $PREFIX/

    ./ASHS-2.0.0_post-install.sh


