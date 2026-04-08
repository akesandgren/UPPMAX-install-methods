giggle/0.6.3
========================

<https://github.com/ryanlayer/giggle>

Used under license:
MIT
<https://github.com/ryanlayer/giggle/blob/master/LICENSE>

Structure creating script (makeroom_giggle_0.6.3.sh) moved to /sw/bioinfo/giggle/makeroom_0.6.3.sh

LOG
---

    makeroom.sh "-t" "giggle" "-v" "0.6.3" "-w" "https://github.com/ryanlayer/giggle" "-l" "MIT" "-L" "https://github.com/ryanlayer/giggle/blob/master/LICENSE" "-c" "bioinfo" "-d" "GIGGLE is a genomics search engine that identifies and ranks the significance of shared genomic loci between query features and thousands of genome interval files." "-s" "misc"
    ./makeroom_giggle_0.6.3.sh
    cd $SRCDIR
    apptainer build giggle giggle.def
    mkdir -p $PREFIX/bin &&  cd PREFIX/bin
    ln -s ../../src/giggle

