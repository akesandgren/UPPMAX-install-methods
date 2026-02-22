PharmCAT/3.1.1
========================

<https://pharmcat.clinpgx.org/>

Used under license:
Mozilla2.0
<https://github.com/PharmGKB/PharmCAT/blob/development/LICENSE>

Structure creating script (makeroom_PharmCAT_3.1.1.sh) moved to /sw/bioinfo/PharmCAT/makeroom_3.1.1.sh

LOG
---

    makeroom.sh "-t" "PharmCAT" "-v" "3.1.1" "-c" "bioinfo" "-w" "https://pharmcat.clinpgx.org/" "-l" "Mozilla2.0" "-L" "https://github.com/PharmGKB/PharmCAT/blob/development/LICENSE" "-d" "PharmCAT (Pharmacogenomics Clinical Annotation Tool) is a bioinformatics tool that analyzes genetic variants to predict drug response and tailor medical treatment to an individual patient’s genetic profile." "-s" "misc"
    ./makeroom_PharmCAT_3.1.1.sh
    
    mkdir -p $PREFIX/bin && cd $PREFIX/bin

    cat << EOF > pharmcat.def
Bootstrap: docker
From: pgkb/pharmcat

%runscript
#!/bin/sh
  if command -v $SINGULARITY_NAME > /dev/null 2> /dev/null; then
    exec $SINGULARITY_NAME "$@"
  else
    echo "# ERROR !!! Command  not found in the container"
  fi
EOF
   
   apptainer build pharmcat pharmcat.def
   ln -s pharmcat pharmcat_pipeline
   ln -s pharmcat pharmcat_vcf_preprocessor
   apptainer exec pharmcat cp /pharmcat/pharmcat.jar .


