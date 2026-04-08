GTDB/R226
=========

<https://ecogenomics.github.io/GTDBTk/index.html>

Used under license:



LOG
---

No md5sum available from their webpage.

    makeroom.sh -f -t "GTDB" -v "R226" -c "data" -w "https://ecogenomics.github.io/GTDBTk/index.html"
    ./makeroom_GTDB_R226.sh 
    source /sw/data/GTDB/SOURCEME_GTDB_R226
    cd $SRCDIR
    #### TOO SLOW wget https://data.gtdb.ecogenomic.org/releases/release220/220.0/auxillary_files/gtdbtk_package/full_package/gtdbtk_r220_data.tar.gz
    #### wget https://data.ace.uq.edu.au/public/gtdb/data/releases/release220/220.0/auxillary_files/gtdbtk_package/full_package/gtdbtk_r220_data.tar.gz
    # Denmark mirror
    wget https://data.gtdb.aau.ecogenomic.org/releases/release226/226.0/auxillary_files/gtdbtk_package/full_package/gtdbtk_r226_data.tar.gz

This takes a long time to download, overnight most likely.

Downloaded this ahd the latest version (link at website) and they're the same.

    tar xf gtdbtk_r226_data.tar.gz 
    mv release220 $PREFIX/

Note in the mf that GTDB-Tk/2.6.1 is required to use this database.

