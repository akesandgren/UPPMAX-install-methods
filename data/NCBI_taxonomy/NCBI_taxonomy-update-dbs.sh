#!/bin/bash

ROOT=/sw/data/NCBI_taxonomy

WGET_OPTIONS="--quiet --timestamping"

VERBOSE=yes
MOVE_TO_FINAL=yes

# Much of the guts come from diamond-db-update.sh, but this is much simplified
# by moving the temp directory and latest symlink to be done once in the script

DateFormat='%Y%m%d-%H%M%S'  # used for databases where the version tag is a date
TODAY=`date +"$DateFormat"`
NEWVERSION="$TODAY"

echo -e "Updating NCBI taxonomy files to version $NEWVERSION ...\n"

# This will set NEWVERSION based on the last-modified time of a file, but we
# don't do that for these databases because they are all bundled under the date
# the whole set was updated
#
# [[ "$DateSource" = 'now' ]] && NEWVERSION="$TODAY" || NEWVERSION=`date --date=@$(stat -c'%Y' $DB_FILE) +"$DateFormat"`

#set -x

function error() {
    local MSG="Error within $0: '$1'"
    echo -e "$MSG"
    exit 1
}

function warning() {
    local MSG="Warning within $0: '$1'"
    echo -e "$MSG"
}

cd $ROOT
[[ -L latest ]] && PREVIOUSVERSION=$(readlink latest) || PREVIOUSVERSION=
[[ (! "$PREVIOUSVERSION" || "$PREVIOUSVERSION" != "$NEWVERSION") || ! $MOVE_TO_FINAL ]] || error "latest already points to $NEWVERSION"

TMPDIR=tmp.$$.$TODAY
mkdir $TMPDIR || error "error during mkdir $TMPDIR"
[[ $MOVE_TO_FINAL ]] || echo "... but not actually finalising the update, leaving files in the tmp directory $ROOT/$TMPDIR"

function make_latest_symlink() {
    local NEWVERSION=$1
    local HERE=$PWD
    cd $ROOT
    { rm -f latest && ln -sf $NEWVERSION latest; } || error "could not create 'latest' symlink"
    [[ $VERBOSE ]] && echo -e "symlinked latest to $NEWVERSION"
    cd $HERE
}

#[[ $(uname -n) = 'rackham5.uppmax.uu.se' ]] || error "This is a long multi-core process and must be run on rackham5"


# unpack a single gzipped database file
function unpack_db_single() {
    local DB_INPUT=$1
    local METHOD=${2:?METHOD required}
    local FUNC="unpack_db_single"
    local cmd=
    case $METHOD in
        tar)  cmd="tar xvf $DB_INPUT" ;;
        zcat) cmd="zcat $DB_INPUT > ${DB_INPUT%.gz}" ;;
        none) cmd="echo $DB_INPUT" ;;
    esac 
    [[ $VERBOSE ]] && echo "$FUNC:  $cmd ..."
    eval $cmd
}


# get_db_single()
#
# Download updates for a database that is a single file with separate md5
# checksum file, using wget.
#
# Version of the download is dependent on DateSource

function get_db_single() {

    local DB_DIR=$1       # 1  base directory, . for current directory
    local URL_DIR=$2      # 2  base url/directory for wget
    local DB_FILE=$3      # 3  data filename
    local DB_MD5_FILE=$4  # 4  md5 checksum filename, md5sum --quiet -c with this checks $DB_FILE
    local METHOD=$5       # 5  method to unpack, 'tar' or 'zcat'
    local FUNC="get_db_single"

    echo "$FUNC:     $DB_DIR/$DB_FILE ..."

    cd $ROOT
    cd $TMPDIR
    mkdir -p $DB_DIR
    cd $DB_DIR

    if wget $WGET_OPTIONS $URL_DIR/$DB_MD5_FILE ; then  # fetch the md5 file, preserving its server time
        if wget $WGET_OPTIONS $URL_DIR/$DB_FILE ; then  # fetch the database file
            if md5sum --quiet -c $DB_MD5_FILE ; then  # it looks good, update to this version
                [[ $VERBOSE ]] && echo -e "$FUNC:     successfully downloaded update"
                unpack_db_single  $DB_FILE  $METHOD
                mkdir -p download && mv -f $DB_FILE $DB_MD5_FILE download/ && echo -e "$FUNC:     original moved to download/" || error "could not move $DB_FILE and/or $DB_MD5_FILE to download/"
                [[ $VERBOSE ]] && echo -e "$FUNC:     successfully updated $DB_FILE\n"
            else 
                error "$FUNC: $DB_FILE md5 checksum do not match"
            fi
            cd $ROOT
        else 
            warning "$FUNC: $DB_FILE could not be fetched"
        fi
    else 
        warning "$FUNC: $URL_DIR/$DB_MD5_FILE could not be fetched, so not fetching $URL_DIR/$DB_FILE"
    fi
}

# get_db_file()
#
# Download updates for a database that is a single file with no md5

function get_db_file() {

    local DB_DIR=$1       # 1  base directory, . for current directory
    local URL_DIR=$2      # 2  base url/directory for wget
    local DB_FILE=$3      # 3  data filename
    local FUNC="get_db_file"

    echo "$FUNC:       $DB_DIR/$DB_FILE ..."

    cd $ROOT
    cd $TMPDIR
    mkdir -p $DB_DIR
    cd $DB_DIR
    wget $WGET_OPTIONS $URL_DIR/$DB_FILE
    [[ $VERBOSE ]] && echo -e "$FUNC:       successfully downloaded update"
    mkdir -p download && cp -af $DB_FILE download/ && echo -e "$FUNC:       original copied to download/" || { echo "could not copy $DB_FILE to download/"; exit 1; }
    [[ $VERBOSE ]] && echo -e "$FUNC:       successfully updated $DB_FILE\n"
    cd $ROOT
}

# set -x


# taxonomy database

get_db_file    .                ftp://ftp.ncbi.nlm.nih.gov/pub/taxonomy                  Major_taxonomic_updates_2023.txt
get_db_file    .                ftp://ftp.ncbi.nlm.nih.gov/pub/taxonomy                  coll_dump.txt
get_db_file    .                ftp://ftp.ncbi.nlm.nih.gov/pub/taxonomy                  ncbi_taxonomy_genussp.txt

get_db_single  .                ftp://ftp.ncbi.nlm.nih.gov/pub/taxonomy                  taxdump.tar.gz                     taxdump.tar.gz.md5                  tar
get_db_file    .                ftp://ftp.ncbi.nlm.nih.gov/pub/taxonomy                  taxdump_readme.txt
get_db_single  .                ftp://ftp.ncbi.nlm.nih.gov/pub/taxonomy                  taxcat.tar.gz                      taxcat.tar.gz.md5                   tar
get_db_file    .                ftp://ftp.ncbi.nlm.nih.gov/pub/taxonomy                  taxcat_readme.txt


# new_taxdump database

get_db_single  new_taxdump      ftp://ftp.ncbi.nlm.nih.gov/pub/taxonomy/new_taxdump      new_taxdump.tar.gz                 new_taxdump.tar.gz.md5              tar
get_db_file    new_taxdump      ftp://ftp.ncbi.nlm.nih.gov/pub/taxonomy/new_taxdump      taxdump_readme.txt


# accession2taxid for new accession numbers

get_db_file    accession2taxid  ftp://ftp.ncbi.nlm.nih.gov/pub/taxonomy/accession2taxid  README

get_db_single  accession2taxid  ftp://ftp.ncbi.nlm.nih.gov/pub/taxonomy/accession2taxid  nucl_wgs.accession2taxid.gz        nucl_wgs.accession2taxid.gz.md5     zcat
get_db_single  accession2taxid  ftp://ftp.ncbi.nlm.nih.gov/pub/taxonomy/accession2taxid  nucl_wgs.accession2taxid.EXTRA.gz  nucl_wgs.accession2taxid.EXTRA.gz.md5  zcat
get_db_single  accession2taxid  ftp://ftp.ncbi.nlm.nih.gov/pub/taxonomy/accession2taxid  nucl_gb.accession2taxid.gz         nucl_gb.accession2taxid.gz.md5      zcat

get_db_single  accession2taxid  ftp://ftp.ncbi.nlm.nih.gov/pub/taxonomy/accession2taxid  prot.accession2taxid.gz            prot.accession2taxid.gz.md5         zcat
get_db_single  accession2taxid  ftp://ftp.ncbi.nlm.nih.gov/pub/taxonomy/accession2taxid  prot.accession2taxid.FULL.gz       prot.accession2taxid.FULL.gz.md5    zcat

get_db_single  accession2taxid  ftp://ftp.ncbi.nlm.nih.gov/pub/taxonomy/accession2taxid  pdb.accession2taxid.gz             pdb.accession2taxid.gz.md5          zcat

get_db_single  accession2taxid  ftp://ftp.ncbi.nlm.nih.gov/pub/taxonomy/accession2taxid  wgs.accession2taxid.gz             wgs.accession2taxid.gz.md5          zcat

get_db_single  accession2taxid  ftp://ftp.ncbi.nlm.nih.gov/pub/taxonomy/accession2taxid  dead_nucl.accession2taxid.gz       dead_nucl.accession2taxid.gz.md5    zcat
get_db_single  accession2taxid  ftp://ftp.ncbi.nlm.nih.gov/pub/taxonomy/accession2taxid  dead_wgs.accession2taxid.gz        dead_wgs.accession2taxid.gz.md5     zcat
get_db_single  accession2taxid  ftp://ftp.ncbi.nlm.nih.gov/pub/taxonomy/accession2taxid  dead_prot.accession2taxid.gz       dead_prot.accession2taxid.gz.md5    zcat


# collections information

get_db_file    biocollections   ftp://ftp.ncbi.nlm.nih.gov/pub/taxonomy/biocollections   Collection_codes.txt
get_db_file    biocollections   ftp://ftp.ncbi.nlm.nih.gov/pub/taxonomy/biocollections   Institution_codes.txt
#get_db_file    biocollections   ftp://ftp.ncbi.nlm.nih.gov/pub/taxonomy/biocollections   Unique_institution_codes.txt


# blast database taxonomy info, primarily useful in the separate copy downloaded alongside the blast databases

get_db_file    .                https://ftp.ncbi.nlm.nih.gov/blast/db                    taxdb-metadata.json
get_db_single  .                https://ftp.ncbi.nlm.nih.gov/blast/db                    taxdb.tar.gz                       taxdb.tar.gz.md5                    tar


# refresh $ROOT/taxdump_archive

[[ $VERBOSE ]] && echo -e "refreshing $ROOT/taxdump_archive/ ..."
( cd $ROOT && echo "mirror -P 2 taxdump_archive" | lftp ftp://ftp.ncbi.nlm.nih.gov/pub/taxonomy/ )


# remove previous version, place update, and update latest symlink
[[ $MOVE_TO_FINAL ]] && { echo "Final move to $ROOT/$NEWVERSION ..."; } || { echo "No final move, downloaded versions left in $ROOT/$TMPDIR"; exit 0; }

cd $ROOT
[[ -d $PREVIOUSVERSION ]] && rm -rf $PREVIOUSVERSION
mv $TMPDIR $NEWVERSION
make_latest_symlink  "$NEWVERSION"

chgrp -hR sw .
chmod -R u+rwX,g+rwX,o+rX .
find . -type d -exec chmod g+s {} \;
echo "Done."

