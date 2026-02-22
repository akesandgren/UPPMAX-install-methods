snpEff_data/5.4a
================

<https://pcingola.github.io/SnpEff>

Used under license:
MIT
<https://pcingola.github.io/SnpEff/license/>

LOG
---

    screen -S snpEff_data

    cd /sw/data/snpEff_data/
    mkdir 5.4a/
    cd 5.4a/
    mkdir data

    module load snpEff/5.4a
    cd /sw/data/snpEff_data/5.4a

    snpEff databases -dataDir $PWD/data >databases_list
    tail -n +3 databases_list | grep -P '\tOK ' > databases_list.installed
    tail -n +3 databases_list | grep -P -v '\tOK ' > databases_list.missing

    for G in $(cut -f1 databases_list.missing) ; do snpEff download -dataDir $PWD/data  $G; done

    snpEff databases -dataDir $PWD/data >databases_list
    tail -n +3 databases_list | grep -P '\tOK ' > databases_list.installed
    tail -n +3 databases_list | grep -P -v '\tOK ' > databases_list.missing
    wc -l databases_list.installed databases_list.missing

Now add /sw/data/snpEff_data/5.4a/data as the data directory in snpEff/5.4a config.

