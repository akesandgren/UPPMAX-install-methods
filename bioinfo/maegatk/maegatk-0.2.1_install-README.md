maegatk/0.2.1
========================

<https://github.com/caleblareau/maegatk>

Used under license:
MIT
<https://github.com/caleblareau/maegatk/blob/master/LICENSE.txt>

Structure creating script (makeroom_maegatk_0.2.1.sh) moved to /sw/bioinfo/maegatk/makeroom_0.2.1.sh

LOG
---

    makeroom.sh "-t" "maegatk" "-v" "0.2.1" "-c" "bioinfo" "-s" "misc" "-w" "https://github.com/caleblareau/maegatk" "-l" "MIT" "-L" "https://github.com/caleblareau/maegatk/blob/master/LICENSE.txt" "-d" "The maegatk package is a python-based command line interface for processing .bam files with mitochondrial reads and generating high-quality heteroplasmy estimation from sequencing data." "-f"
    ./makeroom_maegatk_0.2.1.sh

    source /sw/bioinfo/maegatk/SOURCEME_maegatk_0.2.1 && cd $SRCDIR
    
    module load python3/3.9.5 gcc/9.3.0
    python3 -m venv venv-maegatk
    source venv-maegatk/bin/activate
    #python3 -m pip install -U setuptools wheel
    python3 -m pip install git+https://github.com/caleblareau/maegatk.git

    cd $PREFIX
    mkdir bin
    cd bin
    ln -s ../../src/venv-maegatk/bin/maegatk
    ln -s ../../src/venv-maegatk/bin/snakemake
    

