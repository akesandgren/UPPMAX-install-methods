ITK-SNAP/4.4.0
========================

<https://www.itksnap.org/pmwiki/pmwiki.php>

Used under license:



Structure creating script (makeroom_ITK-SNAP_4.4.0.sh) moved to /sw/bioinfo/ITK-SNAP/makeroom_4.4.0.sh

LOG
---

    makeroom.sh "-t" "ITK-SNAP" "-v" "4.4.0" "-c" "bioinfo" "-w" "https://www.itksnap.org/pmwiki/pmwiki.php" "-d" "ITK-SNAP is a free, open-source, multi-platform software application used to segment structures in 3D and 4D biomedical images." "-s" "misc"
    ./makeroom_ITK-SNAP_4.4.0.sh
    cd $SRCDIR
    # download the files - needs browser - redirections...
    tar -xvf itksnap-4.4.0-20250909-Linux-x86_64.tar.gz
    mv itksnap-4.4.0-20250909-Linux-x86_64/* $PREFIX/
    # weell needs a container... `GLIBC_2.27' not found (required by ./c2d)


