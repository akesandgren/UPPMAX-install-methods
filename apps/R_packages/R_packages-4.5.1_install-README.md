R_packages/4.5.1
================

This is not as comprehensive as 4.3.1 and previous versions.  We are simply responding to user requests.


For the next version:

* https://github.com/CSOgroup/CALDER2
* GenomicsDB ??
* https://github.com/mojaveazure/seurat-disk
* and double-check Seurat's own website for its recommended additions for externals
* remotes::install_github('chris-mcginnis-ucsf/DoubletFinder', upgrade='never')
  Be sure that DoubletFinder includes changes to accomodate Seurat:

    cd /sw/apps/R_packages
    source SOURCEME_R_packages_4.5.1
    source $VERSIONDIR/source-for-setup
    cd $VERSIONDIR/external
    ml git/2.34.1
    git clone --recursive https://github.com/chris-mcginnis-ucsf/DoubletFinder
    cd DoubletFinder/
    cd R/
    wget -O paramSweep.R.new https://raw.githubusercontent.com/chris-mcginnis-ucsf/DoubletFinder/57e1a43820ecbf8b371b104879e64976a83f9e8b/R/paramSweep.R
    wget -O doubletFinder.R.new https://raw.githubusercontent.com/chris-mcginnis-ucsf/DoubletFinder/642322aab3a50b2ad1892e2bbd8ac98a5191a18f/R/doubletFinder.R
    diff doubletFinder.R*
    diff paramSweep.R*
    mv doubletFinder.R.new doubletFinder.R
    mv paramSweep.R.new paramSweep.R
    cd ../..

  Then within R:

    install.packages('DoubletFinder', repos=NULL)

* liana <https://saezlab.github.io/liana/>  See the section toward the end of this file


Intro
-----

Double-check that there are no non-base packages installed within R/4.5.1. That
must be chmod -R -w, but I'd forgotten and other AEs had installed packages
there. Big mistake.

Also, the new timeout of 500 seconds (see below) was too short to install e.g.,
stringi. So, extend to 30 mins = 1800 seconds.


Used under license:
Various


Structure creating script (makeroom_R_packages_4.5.1.sh) moved to /sw/apps/R_packages/makeroom_4.5.1.sh

Module holding installations of CRAN and BioConductor.  An attempt to be
comprehensive.  We can't be completely, because we don't have certain
libraries, Oracle, GPUs, etc. installed, nor did I load specialist modules that
might be connectable.

I'll pick those up by hand afterward.  I want to make sure everything that a
user has requested is definitely installed.

I rewrote scripts `/sw/apps/R_packages/3.6.0/inst.R` (do the installing) and
`/sw/apps/R_packages/3.6.0/installed.R` (count the installs, or produce a table
of the installs).  The `biocLite()` mechanism for BioConductor is deprecated,
in favour of a new `BiocManager` package available via CRAN.

In the process, I found that BioConductor repositories included CRAN, so now
break the numbers out into CRAN and BioConductor-specific with no CRAN overlap.

See the note in the install for R_packages/3.5.0 for `R_MAX_NUM_DLLS`.


Packages not picked up in the automated install
-----------------------------------------------

A lot of packages are installed by the automated install, following the
instructions below.  There are still some that are not.  Some require some
hand-holding, loading additional/alternate modules, etc. Some simply do
not install.


To install new packages
-----------------------

First, do

    source $VERSIONDIR/source-for-setup

Then do the installation, however it's needed.  See 'Adding a new package' below.

### Interim updates

If updating an R package from CRAN or BioConductor, simply use `BiocManager::install(..., update=FALSE)` within R.


### Updating existing packages in this module

Note that after installing packages while installing this module, the existence
of additional updates might be announced.  It is OK to accept these updates;
updates to the base R packages has write permissions are locked down on the R
module itself so those can't be updated.  Accept 'a' to update all packages.

After the module is fully installed, **do not do this** after interim updates.
Instead say 'n'.

Do not update base R packages.  See the following section if you get the
message about updating base backages such as Matrix, mgcv, nlme, and survival.

Quit R, save the environment.


### Do not update base R packages unless this accompanies a new installation of R/$VERSION

After installations of BioConductor or other packages, R might suggest you
update some base packages.  Unless this is an installation which is accompanying
a new installation of R, always choose 'n' to update NONE of the base
packages.  Unless there is a serious bug, we will only update base packages
along with updating R.



LOG
---

Set up.

    makeroom.sh -f -c apps -t R_packages -v 4.5.1 -d "Omnibus package containing installations of as many R packages from CRAN, BioConductor and other user-requested sources as can be reasonably installed" -l Various 
    ./makeroom_R_packages_4.5.1.sh 
    source /sw/apps/R_packages/SOURCEME_R_packages_4.5.1 && cd $TOOLDIR

Run these commands to start the installation, and also run these commands for
setting up prior to adding new packages to this installation.

Place these in `$VERSIONDIR/source-for-setup` for future use.

    source /sw/apps/R_packages/SOURCEME_R_packages_4.5.1 && cd $VERSIONDIR
    export R_LIBS_USER=$PREFIX

    module load R/$VERSION

Several modules will be loaded as prereqs when R/4.5.1 is loaded.  Do **NOT**
load these with the modules below, let them come in when loading R/4.5.1. Pay
attention if there are any version incompatibilities when loading the additional
modules liated after the build (autoconf, automake, cmake, m4) modules and
correct them.

    gcc/13.3.0
    binutils/2.41
    openblas/0.3.29
    java/OpenJDK_17+35
    cairo/1.17.4
    texlive/2024-04-24
    texinfo/7.1
    libcurl/8.4.0
    Tcl-Tk/8.6.11
    readline/6.2-11
    libicu/5.2-4
    libdeflate/1.19
    xz/5.4.5
    bzip2/1.0.8
    zlib/1.3.1


Load build systems.

    module load autoconf/2.69
    module load automake/1.16.1
    module load cmake/3.26.3
    module load m4/1.4.17

Load other prereqs for building the package tree.

    module load COIN-OR-OptimizationSuite/1.8.0
    module load cyrus-sasl/2.1.28
    module load Eigen/3.3.4
    module load FFmpeg/5.1.2
    module load GDAL/3.7.2
    module load GEOS/3.12.0-gcc12.3.0
    module load git/2.44.0
    module load glpk/5.0
    module load gsl/2.7
    module load hdf5/1.14.0
    module load JAGS/4.3.1
    module load jq/1.6
    module load libSBML/5.20.0
    module load libwebp/1.3.0
    module load MariaDB/10.1.29
    module load netcdf/4.9.2
    module load openbabel/3.1.1-gcc12.3.0
    module load Poppler/23.09.0
    module load PostgreSQL/10.3
    module load PROJ/9.1.1
    module load protobuf/24.3-gcc12.3.0
    module load rust/1.67.0
    module load SHAPELIB/1.5.0-20220210-8edf888
    module load Tcl-Tk/8.6.11
    module load UDUNITS/2.2.26
    module load giflib/5.1.4
    module load ImageMagick/7.0.11-3
    module load sqlite/3.34.0
    module load GMP/6.3.0
    module load MPFR/4.2.1
    module load libsodium/1.0.18-stable
    module load OpenBUGS/3.2.3
    module load lz4/1.9.2
    module load libb2/0.98.1
    module load libdeflate/1.19
    module load zstd/1.5.2
    module load szip/2.1.1
    module load zlib/1.3.1
    module load curl/8.4.0
    module load freetype/2.12.1


    Final setup.

    export DOWNLOAD_STATIC_LIBV8=1
    export _R_INSTALL_PACKAGES_ELAPSED_TIMEOUT_=1800
    echo -e "\nThis should have been set to the appropriate directory in this module, is it?\n\nR_LIBS_USER = $R_LIBS_USER\n"


The build tools modules are required for some more recent configure scripts
within R packages.  MariaDB (*this 10.1.x version*, not 10.2.x) is required for
installing the `RMySQL` package, which is needed as a prereq by several
BioConductor packages.  We also load `PostgreSQL/10.3` for the same reason for
`RPostgreSQL`.

Several installations require additional modules to be loaded just for that
installation.  See below.

Loading R loads a bunch of stuff including gcc that will be used for building
R packages.  So, like with perl_modules, R_packages is associated with a
specific R module version.  Make sure you are using R/4.3.1:

    which R

and run R, setting it up to use the Umea, Sweden repository, and to have a
longer timeout limit (300 instead of 60 sec):

    R --no-init-file

    r <- getOption("repos")
    r["CRAN"] <- "https://ftp.acc.umu.se/mirror/CRAN/"
    options(repos = r, timeout = 300)



Within R
--------

Now, within R, install this packages from CRAN, ensuring that it was installed
within this R_packages tree:

    if (!requireNamespace("BiocManager"))
        install.packages("BiocManager")
    BiocManager::install(update=FALSE)
    options(BiocManager.check_repositories = FALSE)  # make BioConductor shut up about alternate repositories
    BiocManager::install('getopt', update=FALSE, Ncpus=8)

Temporarily suspend R and double-check that packages are installed into the prefix.

    Ctrl-z
    ls -l $PREFIX
    fg



Installing all packages
-----------------------

Later packages in BioConductor require `rbamtools`, which requires `refGenome`,
both of which are orphaned and not in CRAN.  Also, my two now-archived
packages, and build `rgl` without OpenGL support.

    BiocManager::install(c('doBy','RSQLite','DBI'), update=FALSE, Ncpus=10)
    install.packages('https://cran.r-project.org/src/contrib/Archive/refGenome/refGenome_1.7.7.tar.gz', Ncpus=10)
    install.packages('https://cran.r-project.org/src/contrib/Archive/rbamtools/rbamtools_2.16.17.tar.gz', Ncpus=10)
    install.packages('https://cran.r-project.org/src/contrib/Archive/nestedRanksTest/nestedRanksTest_0.2.tar.gz', Ncpus=10)
    install.packages('rgl', configure.args='--disable-opengl')
    BiocManager::install(c('pegas'), update=FALSE, Ncpus=10)
    install.packages('https://cran.r-project.org/src/contrib/Archive/readGenalex/readGenalex_1.0.tar.gz', Ncpus=10)


to get it installed.

Pre-emptive installations of dependencies in the CRAN archive
-------------------------------------------------------------

Build geo packages that need help finding GEOS, PROJ, GDAL.

      ml libtiff/4.5.0
      ml tbb/2020.3

Then within R:

      install.packages('terra', configure.args="--with-gdal-config=$GDAL_ROOT/bin/gdal-config --with-proj-data=$PROJ_DATA --with-sqlite3-lib=$SQLITE3_ROOT/lib --with-proj-include=$PROJ_ROOT/include --with-proj-lib=$PROJ_ROOT/lib --with-proj-share=$PROJ_DATA --with-geos-config=$GEOS_ROOT/bin/geos-config")
      install.packages('gdalraster', configure.args="--with-gdal-config=$GDAL_ROOT/bin/gdal-config --with-proj-data=$PROJ_DATA --with-sqlite3-lib=$SQLITE3_ROOT/lib --with-proj-include=$PROJ_ROOT/include --with-proj-lib=$PROJ_ROOT/lib --with-proj-share=$PROJ_DATA --with-geos-config=$GEOS_ROOT/bin/geos-config")
      install.packages('sf', configure.args="--with-gdal-config=$GDAL_ROOT/bin/gdal-config --with-proj-data=$PROJ_DATA --with-sqlite3-lib=$SQLITE3_ROOT/lib --with-proj-include=$PROJ_ROOT/include --with-proj-lib=$PROJ_ROOT/lib --with-proj-share=$PROJ_DATA --with-geos-config=$GEOS_ROOT/bin/geos-config")
      install.packages('lwgeom', configure.args="--with-gdal-config=$GDAL_ROOT/bin/gdal-config --with-proj-data=$PROJ_DATA --with-sqlite3-lib=$SQLITE3_ROOT/lib --with-proj-include=$PROJ_ROOT/include --with-proj-lib=$PROJ_ROOT/lib --with-proj-share=$PROJ_DATA --with-geos-config=$GEOS_ROOT/bin/geos-config")
      install.packages('gdalcubes', configure.args="--with-gdal-config=$GDAL_ROOT/bin/gdal-config --with-proj-data=$PROJ_DATA --with-sqlite3-lib=$SQLITE3_ROOT/lib --with-proj-include=$PROJ_ROOT/include --with-proj-lib=$PROJ_ROOT/lib --with-proj-share=$PROJ_DATA --with-geos-config=$GEOS_ROOT/bin/geos-config")

Then within R:

    BiocManager::install("Rsamtools", Ncpu=4, update=FALSE)
    BiocManager::install(c('sftime','stars','raster','gstat','exactextractr','rasterVis'), Ncpu=4, update=FALSE)

Download openssl package, and modify its src/compabitility.h to load <openssl/x509.h> after loading the first header file.  Then install within R with

    install.packages('openssl', repos=NULL)

    install.packages('httr')

Continue.

    install.packages(c('readr', 'tidyr', 'dplyr', 'magrittr', 'ggplot2', 'lubridate', 'stringr', 'taxize', 'rnaturalearth', 'grid', 'ggcorrplot', 'ENMeval', 'CoordinateCleaner'))

    install.packages(c('rgbif', 'purrr', 'countrycode', 'raster', 'ggpubr', 'factoextra', 'svDialogs', 'stringdist'))

    devtools::install_github('rogerhyam/wfor')

    install.packages('dismo')

    devtools::install_github("jasonleebrown/humboldt")

    devtools::install_github("brshipley/megaSDM", build_vignettes = TRUE)


##### build maptools, apply patch below

    install.packages('https://cran.r-project.org/src/contrib/Archive/maptools/maptools_1.1-8.tar.gz')  # currently fails

Outside of R:

    wget https://cran.r-project.org/src/contrib/Archive/maptools/maptools_1.1-8.tar.gz
    tar xf maptools_1.1-8.tar.gz

The files that change are MD5 and src/pip.c, patch file below contains changes
You want to double check the MD5 for src/pip.c after the changes and modify the
checksum appropriately.

    ### patch file for fixing maptools

    diff -r -u maptools.orig/MD5 maptools/MD5
    --- maptools.orig/MD5   2023-07-18 21:10:02.000000000 +0200
    +++ maptools/MD5    2025-09-29 11:52:15.000000000 +0200
    @@ -147,7 +147,7 @@
     f1017d6af939cf229a3d4dcca4c849ee *src/init.c
     c383e3e31bd88ca270cbe9eaf7c24f21 *src/insiders.c
     4555ee0f7b4f5207ca71158f6aa02fe7 *src/maptools.h
    -416137da8f59d274e312612670fb17cb *src/pip.c
    +1759cc12a304f7d90a16e58b1d72616a *src/pip.c
     87a2ae7ea33b16f2d57f9d62a9fbb3fa *src/shapefil.h
     d25fe56b0e4168d277a86e7f451052f4 *src/shpopen.c
     e395537f6a9dd7842108a3aa9be52971 *src/shptree.c
    diff -r -u maptools.orig/src/pip.c maptools/src/pip.c
    --- maptools.orig/src/pip.c 2021-03-19 17:31:50.000000000 +0100
    +++ maptools/src/pip.c  2025-09-29 11:48:03.000000000 +0200
    @@ -42,7 +42,7 @@
        SEXP ret;

        pol.lines = LENGTH(polx); /* check later that first == last */
    -   pol.p = (PLOT_POINT *) Calloc(pol.lines, PLOT_POINT); /* Calloc does error handling */
    +   pol.p = (PLOT_POINT *) R_Calloc(pol.lines, PLOT_POINT); /* change to R_Calloc DGS 2025/09/29 Calloc does error handling */
        for (i = 0; i < LENGTH(polx); i++) {
            pol.p[i].x = NUMERIC_POINTER(polx)[i];
            pol.p[i].y = NUMERIC_POINTER(poly)[i];
    @@ -70,7 +70,7 @@
                default: INTEGER_POINTER(ret)[i] = -1; break;
            }
        }
    -   Free(pol.p);
    +   R_Free(pol.p); /* change to R_Free DGS 2025/09/29 */
        return(ret);
     }



Try to install everything
-------------------------

Make sure that `/sw/apps/R_packages/$VERSION/inst.R` is available, then to see
what remains, do:

    source("inst.R")

if you are in `$VERSIONDIR`, or whatever is appropriate for the location you are in.

When this started after the above, it printed

    Bioconductor version 3.17 (BiocManager 1.30.22), R 4.3.1 (2023-06-16)
    There are a total of 23455 packages available
    104 CRAN packages installed, out of 19899 available
    1 BioConductor-specific packages installed, out of 3556 available

This installs all Bioconductor, then all CRAN packages, iteratively until there is no change.


### inst.R stalls

After many installs, inst.R stalled. We already know from 4.2.1 that several
packages need access to X during installation, so must be installed outside a
screen.

    https://www.mail-archive.com/r-help@r-project.org/msg263560.html

It looked like a few of these suspects might be involved, so I quit the screen
and directly installed them.

    BiocManager::install(c('bioplotbootGUI','cncaGUI','multibiplotGUI','RcmdrPlugin.PcaRobust','RclusTool'),update=FALSE,Ncpus=10)

Two failed: cncaGUI and multibiplotGUI

Remove lock files:

    rm -rf $PREFIX/00LOCK*

#### cncaGUI

Errors during installation:

    ** byte-compile and prepare package for lazy loading
    sh: line 1: 24796 Segmentation fault      (core dumped) R_TESTS= '/sw/apps/R/4.3.1/rackham/lib64/R/bin/R' --no-save --no-restore --no-echo 2>&1 < '/scratch/RtmpjUJuw3/file5e6b690955dc'
    ERROR: lazy loading failed for package 'cncaGUI'

Installed from the repository.

    cd $VERSIONDIR/external
    wget https://ftp.acc.umu.se/mirror/CRAN/src/contrib/cncaGUI_1.1.tar.gz
    R CMD INSTALL cncaGUI_1.1.tar.gz

Still failed. Check DESCRIPTION to see dependencies, from the Imports line:

    tar xf cncaGUI_1.1.tar.gz
    cd cncaGUI
    grep Imports DESCRIPTION

We see

    Imports: rgl, tkrplot, tcltk, tcltk2, shapes, plotrix, MASS

The `rgl` installation above failed, so try again, then install the nonbase dependencies.

    install.packages('rgl', configure.args='--disable-opengl')
    install.packages(c('tkrplot','tcltk2','shapes','plotrix'))

Now install cncaGUI using `devtools::install(".")` within the unpacked tarball. This worked!
within the unpacked tarball, and this worked.

#### multibiplotGUI

Will multibiplotGUI install now?

    install.packages('multibiplotGUI')

Yes!


#### archive

Load libarchive/3.6.2 and build


#### MPI packages, such as Rmpi, Rhpc

Only openmpi/4.1.5 is available with gcc/12.3.0

    #  fully quit R

    cd $VERSIONDIR

    ml openmpi/4.1.5

    R --no-init-file
    install.packages(c("Rmpi","bigGP","doMPI","regRSM"))
    # fully quit R

    cd $TOOLDIR/external_tarballs

    # these were already downloaded for 4.2.1

    R CMD INSTALL Rhpc_0.21-247.tar.gz
    R CMD INSTALL metaMix_0.3.tar.gz   # this depends on Rmpi

    ml -openmpi

    cd $VERSIONDIR

#### Packages requiring libzmq: clustermq, rzmq

Latest is still libzmq/4.3.4

    # fully quit R

    ml libzmq/4.3.4

    R --no-init-file
    BiocManager::install(c("clustermq","rzmq"), update=FALSE)
    # fully quit R

    ml -libzmq

#### OpenBUGS and MultiBUGS dependent packages: R2OpenBUGS, BRugs, pbugs

    # fully quit R
    ml OpenBUGS/3.2.3

    R --no-init-file
    BiocManager::install(c("R2OpenBUGS","BRugs"), update=FALSE)
    # fully quit R

    cd $VERSIONDIR/external
    cd pbugs
    git pull  # still to date
    git status # DESCRIPTION still edited
    cd ..

    R --no-init-file
    install.packages('pbugs', repos=NULL)
    ml -OpenBUGS

#### R2MultiBUGS for MultiBUGS/2.0-gcc12.3.0. This also loads openmpi/4.1.5

    # fully quit R
    ml MultiBUGS/2.0-gcc12.3.0

    R --no-init-file
    devtools::install_github("MultiBUGS/R2MultiBUGS")

    # fully quit R

    ml -MultiBUGS



### Restart 

    cd $VERSIONDIR
    ./installed.R -c

produces

    The R_packages/4.3.1 omnibus module for R version 4.3.1 (2023-06-16) and BioConductor version 3.17

    A total of 23173 R packages are installed
    A total of 23478 packages are available in CRAN and BioConductor
    19603 CRAN packages are installed, out of 19919 available
    3530 BioConductor-specific packages are installed, out of 3559 available
    38 other R packages are installed. These are not in CRAN/BioConductor, are only available in the CRAN/BioConductor archives, or are hosted on github, gitlab or elsewhere


Restart installations within R, but **outside a screen** since we are so far along.

    R --no-init-file
    options(BiocManager.check_repositories = FALSE)
    source("inst.R")

When this restart ends, we got just a handful of packages not installed.

    No change in number of packages not installed: 345 so quitting
    After iteration 2 :
    19603 CRAN packages installed, out of 19919 available
    3530 BioConductor-specific packages installed, out of 3559 available
    Warning message:
    In install.packages(...) : installation of 345 packages failed:

Now try to install other dependencies.

    cd $TOOLDIR/external_tarballs/

    R CMD INSTALL rsnps_0.6.0.tar.gz
    R CMD INSTALL spp_1.16.0.tar.gz
    R CMD INSTALL clusterCrit_1.2.8.tar.gz
    R CMD INSTALL kmlShape_0.9.5.tar.gz
    R CMD INSTALL ReorderCluster_2.0.tar.gz
    R CMD INSTALL propr_4.2.6.tar.gz
    R CMD INSTALL EntropyExplorer_1.1.tar.gz
    R CMD INSTALL SPARQL_1.16.tar.gz
    R CMD INSTALL mppa_1.0.tar.gz
    R CMD INSTALL GenKern_1.2-60.tar.gz
    R CMD INSTALL vbsr_0.0.5.tar.gz
    R CMD INSTALL baseflow_0.13.2.tar.gz
    R CMD INSTALL mGSZ_1.0.tar.gz
    R CMD INSTALL sampSurf_0.7-6.tar.gz
    R CMD INSTALL spatstat.core_2.4-4.tar.gz
    R CMD INSTALL captioner_2.2.3.tar.gz

    cd $VERSIONDIR

Try to address some of the ones that couldn't be installed.

  - BGmix
  - biplotbootGUI
  - ChemmineOB
  - cuda.ml
  - DeepBlueR
  - deeptrafo
  - duckdb
  - FlexReg
  - gpg
  - gpuMagic
  - gWidgets2tcltk
  - HIBAG
  - HilbertVisGUI
  - image.textlinedetector
  * iplots
  - JFE
  * loon
  - mlpack
  - networkscaleup
  - odbc
  - OmicsLonDA
  - OpenCL
  - opencv
  - openCyto
  - optbdmaeAT
  - optrcdmaeAT
  * proj4      # load PROJ.4 instead of PROJ when building
  * vol2birdR  # load PROJ.4 instead of PROJ/9.1.1 when building
  - (rawrr)    # nope
  - Rcplex
  - RcppMeCab
  - RcppSimdJson
  - (redland)    # nope
  - (redux)    # nope
  - RmecabKo
  * Rmpfr      # unload everything, then load only R/4.3.1 and set R_LIBS_USER. It will only work with the system mpfr and gmp
  - RODBC
  - ROracle
  * Rpoppler   #  load glib as a Poppler prerequisite
  - RProtoBuf  # turns out, this builds with protobuf/21.12-gcc10.3.0 but not the newer protobuf/24.3-gcc12.3.0 because abseil has a ridiculous number of separately specified libraries and pkg-config gets very confused
  - RQuantLib
  - (rsbml)   # nope
  - rstanarm
  - rswipl
  - soptdmaeA
  * spectralGraphTopology
  - ssh
  - switchboard
  - symengine
  - tesseract
  - tkImgR
  - TTAinterfaceTrendAnalysis
  - uHMM
  * vapour
  * abstr
  * acumos
  - angstroms
  - (truncated)


Examine installation failures using inst1.R
-------------------------------------------

Nor looking at a few of the standard ones that failed, and why, using a single-run script inst1.R.R.

Run this and save the output. Modified from the help for `sink()`.

     zz <- file("inst1.Rout", open = "wt")
     sink(zz)
     sink(zz, type = "message")

     source("inst1.R")

     sink(type = "message")
     sink()

Looks like this is not capturing all of the build output, just the "well behaved" output from R.

Many installed from this list. What are the numbers now?

    ./installed.R -c

Produces

    The R_packages/4.3.1 omnibus module for R version 4.3.1 (2023-06-16) and BioConductor version 3.17

    A total of 23377 R packages are installed
    A total of 23486 packages are available in CRAN and BioConductor
    19790 CRAN packages are installed, out of 19927 available
    3544 BioConductor-specific packages are installed, out of 3559 available
    41 other R packages are installed. These are not in CRAN/BioConductor, are only available in the CRAN/BioConductor archives, or are hosted on github, gitlab or elsewhere

This is enough. Move to the external packages, see below.


#### AlphaHull3D  ... punt, see 4.3.1

#### RcppCGAL

      install.packages(c('RcppCGAL', 'approxOT', 'raybevel', 'WeightedTreemaps', 'WpProj'), Ncpus=20)




External packages
-----------------

Several R packages found here are not on CRAN or BioConductor, as a result of either user requests or requirements by other modules.

### Basic guidelines

* For a github-hosted package that is not part of CRAN, see ASCAT, rrbgen or STITCH.  If the instructions of the package recommend using something like `devtools::github_install("repository/packagename")`, then the package is one of these.
* For a gitlab-hosted package that is not part of CRAN, see ASCAT, rrbgen or STITCH.  If the instructions of the package recommend using something like `devtools::gitlab_install("repository/packagename")`, then the package is one of these.
* For an "expired" CRAN package that is still in its archive, see igraph0.
* For a "deprecated" BioConductor package that is still in its github repository, see DESeq.
* For a "custom" R package that is part of another module, see dnase2tf.  This latter one uses a command within R.



### cmdstanr

Two steps.  This requires installing the cmdstanr package from a custom repository:

    install.packages("cmdstanr", repos = c("https://mc-stan.org/r-packages/", getOption("repos")))

Then, downloading the latest CmdStan to `$TOOLDIR/external`.  As of this writing, this is

    cd $TOOLDIR/external_tarballs
    [[ -f cmdstan-2.33.1.tar.gz ]] || wget https://github.com/stan-dev/cmdstan/releases/download/v2.33.1/cmdstan-2.33.1.tar.gz

Add wording to module help to use the following:

If you see "Floating point exception" when using functions from the 'brms'
package, it can be more stable when using the option `backend='cmdstanr'`.  The
'cmdstanr' package is installed in this module, but in order to use it, you
must also separately install the tool CmdStan into your home directory. This
can be installed from an UPPMAX-local file using the following commands within
R:

    library(cmdstanr)
    install_cmdstan(release_url="file:///sw/apps/R_packages/external_tarballs/cmdstan-2.33.1.tar.gz")

You can then use the `backend='cmdstanr'` option with brms functions.




### dyno

Make sure ImageMagick and giflib are loaded.

    module load ImageMagick/7.0.11-3 giflib/5.1.4

    devtools::install_github("dynverse/dyno")

This build popped up the message

    >  devtools::install_github("dynverse/dyno")
    >  Using github PAT from envvar GITHUB_PAT
    >  Downloading GitHub repo dynverse/dyno@HEAD
    >  These packages have more recent versions available.
    >  It is recommended to update all of them.
    >  Which would you like to update?
    >
    >  1: All
    >  2: CRAN packages only
    >  3: None
    >  4: dynfeature (1.0.1 -> b6fa729b1...) [GitHub]
    >  5: dynplot    (1.1.2 -> d64b25cd5...) [GitHub]
    >  6: dynwrap    (1.2.3 -> d7233776f...) [GitHub]
    >
    >  Enter one or more numbers, or an empty line to skip updates: 1

Had to choose '1' a couple times to get all packages updated ... wait... is dynverse now part of CRAN ?


### xps  needs ROOT/6.22.08

Pull from Bioconductor git repository and install from their clones.  ROOT/6.26.10 is too recent.  We have to do a little gcc module finesse to use the older ROOT.

    mkdir $VERSIONDIR/external
    cd $VERSIONDIR/external
    git clone https://git.bioconductor.org/packages/xps


    module load ROOT/6.22.08
    module load gcc/12.3.0

Then within R, in the `$VERSIONDIR/external/` directory,

    install.packages('xps', repos=NULL)

Then

    module unload ROOT
    module load gcc/12.3.0



### Archived BioConductor packages

Deprecated or temporary build problems, but packages still rely on these.  Pull
them from the Bioconductor git or tarball repository and install from there.
KEGG.db is superceded by KEGGREST but PGSEA doesn't know that.

    mkdir -p $VERSIONDIR/external
    cd $VERSIONDIR/external
    wget --timestamping http://bioconductor.org/packages/3.11/data/annotation/src/contrib/KEGG.db_3.2.4.tar.gz
    R CMD INSTALL KEGG.db_3.2.4.tar.gz

Instead of doing a fresh clone, just did a `git pull` within each:

    git clone https://git.bioconductor.org/packages/DESeq
    git clone https://git.bioconductor.org/packages/prada
    git clone https://git.bioconductor.org/packages/PGSEA
    git clone https://git.bioconductor.org/packages/rTANDEM
    git clone https://git.bioconductor.org/packages/FunciSNP
    git clone https://git.bioconductor.org/packages/FunciSNP.data
    git clone https://git.bioconductor.org/packages/Roleswitch
    git clone https://git.bioconductor.org/packages/facsDorit
    git clone https://git.bioconductor.org/packages/metagenomeFeatures
    git clone https://git.bioconductor.org/packages/RDAVIDWebService

Then within R, in the same `$VERSIONDIR/external` directory,

    install.packages(c('DESeq','prada','PGSEA','rTANDEM','FunciSNP.data','Roleswitch','facsDorit','FunciSNP','metagenomeFeatures','RDAVIDWebService'), repos=NULL)

Once these are installed, many others can be installed.  Another round of `source('inst1.R')` followed by `./installed.R -c` gives us:

    The R_packages/4.3.1 omnibus module for R version 4.3.1 (2023-06-16) and BioConductor version 3.17

    A total of 23426 R packages are installed
    A total of 23490 packages are available in CRAN and BioConductor
    19817 CRAN packages are installed, out of 19931 available
    3544 BioConductor-specific packages are installed, out of 3559 available
    63 other R packages are installed. These are not in CRAN/BioConductor, are only available in the CRAN/BioConductor archives, or are hosted on github, gitlab or elsewhere


### lme4qtl, harmony, LDna, ampvis2, CaSpER, loomR, SeuratDisk, SeuratWrappers, kBET, presto, ArchR, sgi, ASCAT, ggnet, STAAR, cblindplot

Github-hosted packages.  Make sure hdf5/1.14.0 is loaded, loomR uses it.

For 4.5.1, for monocle3, the hassle of installing BPCells.  And others now.  grr is in the CRAN archive.

    https://cran.r-project.org/src/contrib/Archive/grr/grr_0.9.5.tar.gz
    R CMD INSTALL grr_0.9.5.tar.gz

    install.packages(c('compoisson','phylosim','FField'), Ncpus=20)
    devtools::install_github('cole-trapnell-lab/monocle3', dependencies=TRUE)
    devtools::install_github("variani/lme4qtl", ref='master')
    devtools::install_github("immunogenomics/harmony", ref = 'master')
    devtools::install_github("petrikemppainen/LDna", ref = 'master')
    devtools::install_github("madsalbertsen/ampvis2")
    devtools::install_github("akdess/CaSpER")
    devtools::install_github("mojaveazure/loomR", ref = "develop")

    wget https://cran.r-project.org/src/contrib/Archive/huge/huge_1.3.5.tar.gz
    R CMD INSTALL huge_1.3.5.tar.gz

    BiocManager::install("metagMisc")
    remotes::install_github("zdk123/SpiecEasi")
    devtools::install_github("stefpeschel/NetCoMi", dependencies=TRUE)

    devtools::install_github("mojaveazure/seurat-disk")
    devtools::install_github('immunogenomics/presto')
    remotes::install_github('satijalab/azimuth', ref = 'master')
    remotes::install_github("satijalab/seurat-wrappers")

    devtools::install_github('theislab/kBET')
    devtools::install_github("GreenleafLab/ArchR", ref="master")
    devtools::install_github(repo="krumsieklab/sgi", subdir="sgi")
    devtools::install_github('VanLoo-lab/ascat/ASCAT')
    devtools::install_github("briatte/ggnet")
    devtools::install_github("ducciorocchini/cblindplot")
    devtools::install_github("RoseString/SCOPfunctions")
    devtools::install_github("McGranahanLab/TcellExTRECT")
    devtools::install_github('WSpiller/MVMR')
    devtools::install_github("danro9685/CIMLR", ref="R")
    devtools::install_gitlab('CarlBrunius/MUVR')
    devtools::install_github('xuranw/MuSiC')
    devtools::install_github('SGDDNB/ShinyCell', upgrade="never", force=TRUE, build_vignettes=TRUE)
    devtools::install_github("chris-mcginnis-ucsf/DoubletFinder", build_vignettes=TRUE)

STAAR and its tutorials work with several other packages not provided with CRAN or BioConductor.

    BiocManager::install("GENESIS")
    BiocManager::install("TxDb.Hsapiens.UCSC.hg38.knownGene")
    remotes::install_github("xihaoli/STAAR", Ncpus=20)
    remotes::install_github("xihaoli/MultiSTAAR", Ncpus=20)
    remotes::install_github("zilinli1988/SCANG", Ncpus=20)
    remotes::install_github("xihaoli/STAARpipeline",ref="main", Ncpus=20)
    remotes::install_github("xihaoli/STAARpipelineSummary",ref="main", Ncpus=20)

HDL installs from a subdirectory of its repository.

    remotes::install_github(repo="zhenin/HDL", subdir="HDL")

### BPCells  (this is outdated for 4.5.1)

This appears not to require an older hdf5, so just leave hdf5/1.14.0 loaded.

No update since last download, v0.1.0 is still the latest tagged version.

    cd $VERSIONDIR/external
    wget https://github.com/bnprks/BPCells/archive/refs/tags/v0.1.0.tar.gz
    tar xf v0.1.0.tar.gz

Edit its configure to pull from HDF5_LIB and HDF5_INCLUDE, and to remove the
use of `-march=native` which will, when built on rackham, fail on snowy.

    vim BPCells-0.1.0/configure

A diff of the old and new configure is:

  Old                                    New

24  HDF5_CFLAGS=""                       HDF5_CFLAGS="-I${HDF5_INCLUDE}"
25  HDF5_LIBS="-lhdf5"                   HDF5_LIBS="-L${HDF5_LIB} -lhdf5"

75  echo "ARCH_FLAG='$ARCH_FLAG'"        echo "ARCH_FLAG='$ARCH_FLAG'"
76                                       ARCH_FLAG=''
77                                       echo "ARCH_FLAG='$ARCH_FLAG'"


Now within R:

    install.packages('BPCells-0.1.0', repos=NULL)
    q()

Unload the hdf5 module and make sure the BPCells.so library can find it:

    module unload hdf5/1.14.0
    ldd /sw/apps/R_packages/4.3.1/rackham/BPCells/libs/BPCells.so

If so it worked correctly, so load the newer one:

    module load hdf5/1.14.0



### HDL

We install this from its subdirectory above.  The repository also contains some
scripts and datasets that the users may wish to use.  Added a note to the
module help, and defined the new mf file variable `reposroot` to point to
`$VERSIONDIR/external`.


### velocyto.R  (still valid for 4.5.1)

This has not been updated, so follow the same procedure.

I forked the https://github.com/velocyto-team/velocyto.R repository to
https://github.com/douglasgscofield/velocyto.R to enable building off
`BOOST_ROOT` and there have been no further changes to the original repository
at least since R_packages/4.0.0. Build with newer toolchain here.  This needs
`hdf5r` installed, see above.

Outside R, load the boost module compatible with the version of gcc used to build R:

    module load boost/1.83.0-gcc12.3.0

Then inside R:

    BiocManager::install('pcaMethods')
    devtools::install_github("douglasgscofield/velocyto.R")

And verify outside R:

    module unload boost
    ldd /sw/apps/R_packages/4.3.1/rackham/velocyto.R/libs/velocyto.R.so


### Banksy  VoltRon


    BiocManager::install('Banksy')

    wget https://github.com/BIMSBbioinfo/VoltRon/archive/refs/tags/v0.2.2.tar.gz
    module load OpenCV/4.12.0 tesseract/4.1.3
    R CMD INSTALL VoltRon_0.2.2.tar.gz

### igraph0, CoxBoost, rrbgen, STITCH, EasyQC, EasyQC2, contamMix, LRAcluster, compoisson, phylosim, FField

Also, install an outdated package `igraph0`, which has been superseded by
`igraph` (installed above) but needed by some older procedures.

    install.packages(c('CoxBoost', 'bigsnpr'), Ncpus=20)

    cd /sw/apps/R_packages/external_tarballs

    R CMD INSTALL igraph0_0.5.7.tar.gz
    R CMD INSTALL rrbgen_0.0.6.tar.gz
    R CMD INSTALL STITCH_1.8.4.tar.gz       # downloaded new
    R CMD INSTALL EasyQC_23.8.tar.gz
    R CMD INSTALL EasyQC2_1.1.2.tar.gz      # new package
    R CMD INSTALL EasyStrata2_1.2.7.tar.gz  # new package
    R CMD INSTALL Easy2_1.2.1.tar.gz        # new package

    R CMD INSTALL contamMix_1.0-11.tar.gz
    R CMD INSTALL LRAcluster_1.0.tgz

    R CMD INSTALL compoisson_0.3.tar.gz
    R CMD INSTALL phylosim_3.0.5.tar.gz
    R CMD INSTALL FField_0.1.0.tar.gz


### dnase2tf

Added the module dnase2tf from the source under source tree directory for
calcDFT/1.0.1.  No update since 1.0.1.

Inside R:

    install.packages('/sw/bioinfo/calcDFT/1.0.1/src/dnase2tf', repos=NULL, type="source")



### SAIGE

**NOTE** SAIGE is now installed in its own module, SAIGE/0.42.1 on its first installation.


### MDInstruments, MRPracticals, TwoSampleMR

Install github-hosted packages MDInstruments and MRPracticals.  Download the
latest releases from <https://github.com/MRCIEU/MRInstruments/releases> and
<https://github.com/WSpiller/MRPracticals>.  Note that MRPracticals does not
have regular releases, and they also require another github-hosted package
called TwoSampleMR.  So, we do the above to set up our R environment and do all
this inside R:


    devtools::install_github("MRCIEU/TwoSampleMR")
    devtools::install_github("MRCIEU/MRInstruments")

MRPracticals does not install because if its vignettes. Create a tarball separately and install from that.

    cd $VERSIONDIR/external
    git clone https://github.com/WSpiller/MRPracticals
    module load pandoc/3.1.3  # regresses texlive version
    module load texlive/2023-08-14  # restore it, pandoc won't care
    cd MRPracticals
    R

and within R,

    tools::buildVignettes(dir = '.', tangle = TRUE)
    devtools::build('.')

This builds the now-vignette-containing `MRPracticals_0.0.1.tar.gz` in the parent directory.
Then, exit R, cd to the parent directory, which is `$VERSIONDIR/external`, and
install from the tarball.

    cd ..
    R CMD INSTALL MRPracticals_0.0.1.tar.gz


### arrow

arrow is installed as a normal R package. Do the following check within R

    library(arrow)
    packageVersion('arrow')
    codec_is_available('lz4')
    codec_is_available('zstd')

If either of the codec statements is FALSE (both were TRUE this time), then
reinstall using the following to build arrow with LZ4 and ZSTD and other
features.  What is filled in for ARROWVERSION is what is printed by the
packageVersion() command within R.

    cd $VERSIONROOT/external
    ARROWVERSION=13.0.0.1
    wget https://cran.r-project.org/src/contrib/arrow_${ARROWVERSION}.tar.gz
    export LIBARROW_MINIMAL=false
    ARROW_WITH_ZLIB=ON ARROW_WITH_ZSTD=ON ARROW_WITH_LZ4=ON ARROW_WITH_BZ2=ON ARROW_R_DEV=true R CMD INSTALL arrow_${ARROWVERSION}.tar.gz



### CrIMMix


CrIMMix cannot be installed for 4.3.1 nor 4.2.1.

    devtools::install_github("CNRGH/crimmix", upgrade='never')

    Error: object 'sgcca' is not exported by 'namespace:RGCCA'
    Execution halted
    ERROR: lazy loading failed for package 'CrIMMix'
    * removing '/sw/apps/R_packages/4.3.1/rackham/CrIMMix'

Same error with 4.3.1.



Final run
---------

    source('inst1.R')

The outside R, in $VERSIONDIR (as of 2023-10-11):

    ./installed.R -c

    The R_packages/4.3.1 omnibus module for R version 4.3.1 (2023-06-16) and BioConductor version 3.17

    A total of 23476 R packages are installed
    A total of 23535 packages are available in CRAN and BioConductor
    19809 CRAN packages are installed, out of 19976 available
    3544 BioConductor-specific packages are installed, out of 3559 available
    121 other R packages are installed. These are not in CRAN/BioConductor, are only available in the CRAN/BioConductor archives, or are hosted on github, gitlab or elsewhere


Adding a new package
--------------------

Setup.

    cd /sw/apps/R_packages/4.3.1
    source source-for-setup
    chmod u+w rackham

Within R, for both CRAN and BioConductor packages, we use
`BiocManager::install(update=FALSE)` which ultimately uses R's own
`install.packages()`.


    new.packages = c('package_a')
    if (! requireNamespace("BiocManager"))
        install.packages("BiocManager")
    BiocManager::install(new.packages, update=FALSE, Ncpus=10)
    BiocManager::install(new.packages, update=FALSE, Ncpus=10)

This will fail if it wants to update packages, as they will still be
write-protected. Ideally, this would not update packages, we want to
fix on the installed versions here.

Quit R, and relock the entire tree to cover any new installations
as a result of the above.

    chmod -R -w rackham


After adding new packages
-------------------------

Get a count of installed packages, and a list of installed packages.

    cd $VERSIONDIR
    ./installed.R -c | tee counts.txt
    ./installed.R -t > table.txt
    ../create_html_table.pl table.txt > table.html

Add this to the appropriate section of <http://www.uppmax.uu.se/support/user-guides/r_packages-module-guide/>

We always need to write-protect this module, as well as the corresponding R module.



Note about the mf file
----------------------

Though this build procedure sets `R_LIBS_USER` to ease installing R packages,
the mf file for the module sets `R_LIBS_SITE`, not `R_LIBS_USER`.  This is so
users can freely use `R_LIBS_USER` to refer to their own or project-specific R
package trees without fearing conflicting with this module.


Note about sqlite when running under RStudio
--------------------------------------------

See R_packages-4.3.1_install-README.md

In short, when using monocle3 within RStudio, there needs to be a load of
`sqlite/3.34.0` prior to running `rstudio` so that the proper sqlite library is
"pre-loaded."


Adding a handful of other packages
==================================

first round
-----------

    dd <- read.delim('/sw/apps/R_packages/external_tarballs/BioConductor-3.22-t1.txt', header=FALSE, colClasses="character")[,1]
    BiocManager::install(dd)

Packages listed in /sw/apps/R_packages/external_tarballs/BioConductor-3.22-t1.txt are:

    BSgenome BSgenome.Alyrata.JGI.v1 BSgenome.Amellifera.BeeBase.assembly4
    BSgenome.Amellifera.NCBI.AmelHAv3.1 BSgenome.Amellifera.UCSC.apiMel2
    BSgenome.Amellifera.UCSC.apiMel2.masked BSgenome.Aofficinalis.NCBI.V1
    BSgenome.Athaliana.TAIR.04232008 BSgenome.Athaliana.TAIR.TAIR9
    BSgenome.Btaurus.UCSC.bosTau3 BSgenome.Btaurus.UCSC.bosTau3.masked
    BSgenome.Btaurus.UCSC.bosTau4 BSgenome.Btaurus.UCSC.bosTau4.masked
    BSgenome.Btaurus.UCSC.bosTau6 BSgenome.Btaurus.UCSC.bosTau6.masked
    BSgenome.Btaurus.UCSC.bosTau8 BSgenome.Btaurus.UCSC.bosTau9
    BSgenome.Btaurus.UCSC.bosTau9.masked BSgenome.Carietinum.NCBI.v1
    BSgenome.Celegans.UCSC.ce10 BSgenome.Celegans.UCSC.ce11
    BSgenome.Celegans.UCSC.ce2 BSgenome.Celegans.UCSC.ce6
    BSgenome.Cfamiliaris.UCSC.canFam2 BSgenome.Cfamiliaris.UCSC.canFam2.masked
    BSgenome.Cfamiliaris.UCSC.canFam3 BSgenome.Cfamiliaris.UCSC.canFam3.masked
    BSgenome.Cjacchus.UCSC.calJac3 BSgenome.Cjacchus.UCSC.calJac4
    BSgenome.CneoformansVarGrubiiKN99.NCBI.ASM221672v1
    BSgenome.Creinhardtii.JGI.v5.6 BSgenome.Dmelanogaster.UCSC.dm2
    BSgenome.Dmelanogaster.UCSC.dm2.masked BSgenome.Dmelanogaster.UCSC.dm3
    BSgenome.Dmelanogaster.UCSC.dm3.masked BSgenome.Dmelanogaster.UCSC.dm6
    BSgenome.Drerio.UCSC.danRer10 BSgenome.Drerio.UCSC.danRer11
    BSgenome.Drerio.UCSC.danRer5 BSgenome.Drerio.UCSC.danRer5.masked
    BSgenome.Drerio.UCSC.danRer6 BSgenome.Drerio.UCSC.danRer6.masked
    BSgenome.Drerio.UCSC.danRer7 BSgenome.Drerio.UCSC.danRer7.masked
    BSgenome.Dvirilis.Ensembl.dvircaf1 BSgenome.Ecoli.NCBI.20080805
    BSgenome.Gaculeatus.UCSC.gasAcu1 BSgenome.Gaculeatus.UCSC.gasAcu1.masked
    BSgenome.Ggallus.UCSC.galGal3 BSgenome.Ggallus.UCSC.galGal3.masked
    BSgenome.Ggallus.UCSC.galGal4 BSgenome.Ggallus.UCSC.galGal4.masked
    BSgenome.Ggallus.UCSC.galGal5 BSgenome.Ggallus.UCSC.galGal6
    BSgenome.Gmax.NCBI.Gmv40 BSgenome.Hsapiens.1000genomes.hs37d5
    BSgenome.Hsapiens.NCBI.GRCh38 BSgenome.Hsapiens.NCBI.T2T.CHM13v2.0
    BSgenome.Hsapiens.UCSC.hg17 BSgenome.Hsapiens.UCSC.hg17.masked
    BSgenome.Hsapiens.UCSC.hg18 BSgenome.Hsapiens.UCSC.hg18.masked
    BSgenome.Hsapiens.UCSC.hg19 BSgenome.Hsapiens.UCSC.hg19.masked
    BSgenome.Hsapiens.UCSC.hg38 BSgenome.Hsapiens.UCSC.hg38.dbSNP151.major
    BSgenome.Hsapiens.UCSC.hg38.dbSNP151.minor BSgenome.Hsapiens.UCSC.hg38.masked
    BSgenome.Hsapiens.UCSC.hs1 BSgenome.Mdomestica.UCSC.monDom5
    BSgenome.Mfascicularis.NCBI.5.0 BSgenome.Mfascicularis.NCBI.6.0
    BSgenome.Mfuro.UCSC.musFur1 BSgenome.Mmulatta.UCSC.rheMac10
    BSgenome.Mmulatta.UCSC.rheMac2 BSgenome.Mmulatta.UCSC.rheMac2.masked
    BSgenome.Mmulatta.UCSC.rheMac3 BSgenome.Mmulatta.UCSC.rheMac3.masked
    BSgenome.Mmulatta.UCSC.rheMac8 BSgenome.Mmusculus.UCSC.mm10
    BSgenome.Mmusculus.UCSC.mm10.masked BSgenome.Mmusculus.UCSC.mm39
    BSgenome.Mmusculus.UCSC.mm8 BSgenome.Mmusculus.UCSC.mm8.masked
    BSgenome.Mmusculus.UCSC.mm9 BSgenome.Mmusculus.UCSC.mm9.masked
    BSgenome.Osativa.MSU.MSU7 BSgenome.Ppaniscus.UCSC.panPan1
    BSgenome.Ppaniscus.UCSC.panPan2 BSgenome.Ptroglodytes.UCSC.panTro2
    BSgenome.Ptroglodytes.UCSC.panTro2.masked BSgenome.Ptroglodytes.UCSC.panTro3
    BSgenome.Ptroglodytes.UCSC.panTro3.masked BSgenome.Ptroglodytes.UCSC.panTro5
    BSgenome.Ptroglodytes.UCSC.panTro6 BSgenome.Rnorvegicus.UCSC.rn4
    BSgenome.Rnorvegicus.UCSC.rn4.masked BSgenome.Rnorvegicus.UCSC.rn5
    BSgenome.Rnorvegicus.UCSC.rn5.masked BSgenome.Rnorvegicus.UCSC.rn6
    BSgenome.Rnorvegicus.UCSC.rn7 BSgenome.Scerevisiae.UCSC.sacCer1
    BSgenome.Scerevisiae.UCSC.sacCer2 BSgenome.Scerevisiae.UCSC.sacCer3
    BSgenome.Sscrofa.UCSC.susScr11 BSgenome.Sscrofa.UCSC.susScr3
    BSgenome.Sscrofa.UCSC.susScr3.masked BSgenome.Tgondii.ToxoDB.7.0
    BSgenome.Tguttata.UCSC.taeGut1 BSgenome.Tguttata.UCSC.taeGut1.masked
    BSgenome.Tguttata.UCSC.taeGut2 BSgenome.Vvinifera.URGI.IGGP12Xv0
    BSgenome.Vvinifera.URGI.IGGP12Xv2 BSgenome.Vvinifera.URGI.IGGP8X BSgenomeForge
    GenomeAdapt GenomeAdmixR GenomeInfoDb GenomeInfoDbData
    MafDb.1Kgenomes.phase1.GRCh38 MafDb.1Kgenomes.phase1.hs37d5
    MafDb.1Kgenomes.phase3.GRCh38 MafDb.1Kgenomes.phase3.hs37d5 drosgenome1.db
    drosgenome1cdf drosgenome1probe genomeIntervals genomes genomewidesnp5Crlmm
    genomewidesnp6Crlmm metagenomeFeatures metagenomeSeq pd.drosgenome1
    pd.genomewidesnp.5 pd.genomewidesnp.6 rGenomeTracks rGenomeTracksData refGenome


picking up what didn't install
------------------------------

    install.packages('robust', Ncpus=20)
    BiocManager::install('qvalue')

    wget https://cran.r-project.org/src/contrib/Archive/GenomeAdapt/GenomeAdapt_1.0.0.tar.gz
    R CMD INSTALL GenomeAdapt_1.0.0.tar.gz

    remotes::install_github("HCBravoLab/metagenomeFeatures", Ncpus=20)
    BiocManager::install('metagenomeSeq')


second round
------------

    dd <- read.delim('/sw/apps/R_packages/external_tarballs/BioConductor-3.22-t2.txt', header=FALSE, colClasses="character")[,1]
    BiocManager::install(dd)

Packages listed in /sw/apps/R_packages/external_tarballs/BioConductor-3.22-t2.txt are:

    BSgenome.Hsapiens.UCSC.hg38.dbSNP151.major
    BSgenome.Hsapiens.UCSC.hg38.dbSNP151.minor FunciSNP FunciSNP.data FunctanSNP
    ICSNP PolyPhen.Hsapiens.dbSNP131 SIFT.Hsapiens.dbSNP132 SIFT.Hsapiens.dbSNP137
    SNPRelate SNPannotator SNPassoc SNPediaR SNPfiltR SNPhood SNPhoodData SNPknock
    SNPlocs.Hsapiens.dbSNP144.GRCh37 SNPlocs.Hsapiens.dbSNP144.GRCh38
    SNPlocs.Hsapiens.dbSNP149.GRCh38 SNPlocs.Hsapiens.dbSNP150.GRCh38
    SNPlocs.Hsapiens.dbSNP155.GRCh37 SNPlocs.Hsapiens.dbSNP155.GRCh38
    XtraSNPlocs.Hsapiens.dbSNP144.GRCh37 XtraSNPlocs.Hsapiens.dbSNP144.GRCh38 atSNP
    beadarraySNP cpvSNP minSNPs survSNP pd.081229.hg18.promoter.medip.hx1
    pd.2006.07.18.hg18.refseq.promoter pd.2006.07.18.mm8.refseq.promoter
    pd.2006.10.31.rn34.refseq.promoter pd.ag pd.aragene.1.0.st pd.aragene.1.1.st
    pd.atdschip.tiling pd.ath1.121501 pd.barley1 pd.bovgene.1.0.st
    pd.bovgene.1.1.st pd.bovine pd.bsubtilis pd.cangene.1.0.st pd.cangene.1.1.st
    pd.canine pd.canine.2 pd.celegans pd.charm.hg18.example pd.chicken
    pd.chigene.1.0.st pd.chigene.1.1.st pd.chogene.2.0.st pd.chogene.2.1.st
    pd.citrus pd.clariom.d.human pd.clariom.s.human pd.clariom.s.human.ht
    pd.clariom.s.mouse pd.clariom.s.mouse.ht pd.clariom.s.rat pd.clariom.s.rat.ht
    pd.cotton pd.cyngene.1.0.st pd.cyngene.1.1.st pd.cyrgene.1.0.st
    pd.cyrgene.1.1.st pd.cytogenetics.array pd.drogene.1.0.st pd.drogene.1.1.st
    pd.drosgenome1 pd.drosophila.2 pd.e.coli.2 pd.ecoli pd.ecoli.asv2
    pd.elegene.1.0.st pd.elegene.1.1.st pd.equgene.1.0.st pd.equgene.1.1.st
    pd.feinberg.hg18.me.hx1 pd.feinberg.mm8.me.hx1 pd.felgene.1.0.st
    pd.felgene.1.1.st pd.fingene.1.0.st pd.fingene.1.1.st pd.genomewidesnp.5
    pd.genomewidesnp.6 pd.guigene.1.0.st pd.guigene.1.1.st pd.hc.g110 pd.hg.focus
    pd.hg.u133.plus.2 pd.hg.u133a pd.hg.u133a.2 pd.hg.u133a.tag pd.hg.u133b
    pd.hg.u219 pd.hg.u95a pd.hg.u95av2 pd.hg.u95b pd.hg.u95c pd.hg.u95d pd.hg.u95e
    pd.hg18.60mer.expr pd.ht.hg.u133.plus.pm pd.ht.hg.u133a pd.ht.mg.430a
    pd.hta.2.0 pd.hu6800 pd.huex.1.0.st.v2 pd.hugene.1.0.st.v1 pd.hugene.1.1.st.v1
    pd.hugene.2.0.st pd.hugene.2.1.st pd.maize pd.mapping250k.nsp
    pd.mapping250k.sty pd.mapping50k.hind240 pd.mapping50k.xba240 pd.margene.1.0.st
    pd.margene.1.1.st pd.medgene.1.0.st pd.medgene.1.1.st pd.medicago pd.mg.u74a
    pd.mg.u74av2 pd.mg.u74b pd.mg.u74bv2 pd.mg.u74c pd.mg.u74cv2 pd.mirna.1.0
    pd.mirna.2.0 pd.mirna.3.0 pd.mirna.3.1 pd.mirna.4.0 pd.moe430a pd.moe430b
    pd.moex.1.0.st.v1 pd.mogene.1.0.st.v1 pd.mogene.1.1.st.v1 pd.mogene.2.0.st
    pd.mogene.2.1.st pd.mouse430.2 pd.mouse430a.2 pd.mta.1.0 pd.mu11ksuba
    pd.mu11ksubb pd.nugo.hs1a520180 pd.nugo.mm1a520177 pd.ovigene.1.0.st
    pd.ovigene.1.1.st pd.pae.g1a pd.plasmodium.anopheles pd.poplar pd.porcine
    pd.porgene.1.0.st pd.porgene.1.1.st pd.rabgene.1.0.st pd.rabgene.1.1.st
    pd.rae230a pd.rae230b pd.raex.1.0.st.v1 pd.ragene.1.0.st.v1 pd.ragene.1.1.st.v1
    pd.ragene.2.0.st pd.ragene.2.1.st pd.rat230.2 pd.rcngene.1.0.st
    pd.rcngene.1.1.st pd.rg.u34a pd.rg.u34b pd.rg.u34c pd.rhegene.1.0.st
    pd.rhegene.1.1.st pd.rhesus pd.rice pd.rjpgene.1.0.st pd.rjpgene.1.1.st
    pd.rn.u34 pd.rta.1.0 pd.rusgene.1.0.st pd.rusgene.1.1.st pd.s.aureus pd.soybean
    pd.soygene.1.0.st pd.soygene.1.1.st pd.sugar.cane pd.tomato pd.u133.x3p
    pd.vitis.vinifera pd.wheat pd.x.laevis.2 pd.x.tropicalis pd.xenopus.laevis
    pd.yeast.2 pd.yg.s98 pd.zebgene.1.0.st pd.zebgene.1.1.st pd.zebrafish
    org.Ag.eg.db org.At.tair.db org.Bt.eg.db org.Ce.eg.db org.Cf.eg.db org.Dm.eg.db
    org.Dr.eg.db org.EcK12.eg.db org.EcSakai.eg.db org.Gg.eg.db org.Hs.eg.db
    org.Mm.eg.db org.Mmu.eg.db org.Mxanthus.db org.Pt.eg.db org.Rn.eg.db
    org.Sc.sgd.db org.Ss.eg.db org.Xl.eg.db org zebrafish.db zebrafish.db0
    zebrafishRNASeq zebrafishcdf zebrafishprobe vegalite vegan vegan3d vegawidget
    vegclust vegdata vegperiod vegtable mogene.1.0.st.v1frmavecs
    mogene10stprobeset.db mogene10sttranscriptcluster.db mogene10stv1cdf
    mogene10stv1probe mogene11stprobeset.db mogene11sttranscriptcluster.db
    mogene20stprobeset.db mogene20sttranscriptcluster.db mogene21stprobeset.db
    mogene21sttranscriptcluster.db Rattus.norvegicus

picking up what didn't install in the second round
--------------------------------------------------

    BiocManager::install(c('TxDb.Hsapiens.UCSC.hg19.knownGene', 'ChIPpeakAnno', 'snpStats'))

    cd /sw/apps/R_packages/external_tarballs
    wget https://www.bioconductor.org/packages/3.18/bioc/src/contrib/beadarraySNP_1.68.0.tar.gz
    wget https://cran.r-project.org/src/contrib/Archive/SNPknock/SNPknock_0.8.2.tar.gz
    wget https://bioconductor.org/packages/3.11/bioc/src/contrib/FunciSNP_1.32.0.tar.gz
    R CMD INSTALL beadarraySNP_1.68.0.tar.gz
    R CMD INSTALL SNPknock_0.8.2.tar.gz
    R CMD INSTALL FunciSNP_1.32.0.tar.gz
    R CMD INSTALL FunciSNP.data_1.21.0.tar.gz

Continuing ...
--------------

    wget https://cran.r-project.org/src/contrib/Archive/CodeDepends/CodeDepends_0.6.6.tar.gz
    R CMD INSTALL CodeDepends_0.6.6.tar.gz

    BiocManager::install("rebook")
    BiocManager::install("OSCA.intro")


Installing all AnnotationData packages ...
------------------------------------------

    dd <- read.delim('/sw/apps/R_packages/external_tarballs/AnnotationData-3.22.txt', header=FALSE, colClasses="character")[,1]
    BiocManager::install(dd)

Packages listed in /sw/apps/R_packages/external_tarballs/AnnotationData-3.22.txt are:

    GenomeInfoDbData GO.db org.Hs.eg.db org.Mm.eg.db HDO.db
    TxDb.Hsapiens.UCSC.hg19.knownGene reactome.db BSgenome.Hsapiens.UCSC.hg38
    TxDb.Hsapiens.UCSC.hg38.knownGene EnsDb.Hsapiens.v86 org.Rn.eg.db
    hgu133plus2.db BSgenome.Mmusculus.UCSC.mm10 BSgenome.Hsapiens.UCSC.hg19
    JASPAR2020 TxDb.Mmusculus.UCSC.mm10.knownGene
    IlluminaHumanMethylation450kanno.ilmn12.hg19 DO.db BSgenome.Mmusculus.UCSC.mm39
    FDb.InfiniumMethylation.hg19 IlluminaHumanMethylationEPICanno.ilm10b4.hg19
    IlluminaHumanMethylation450kmanifest org.At.tair.db
    IlluminaHumanMethylationEPICmanifest BSgenome.Rnorvegicus.UCSC.rn6 hgu95av2.db
    hgu133a.db hgu133plus2cdf org.Sc.sgd.db org.Dm.eg.db EnsDb.Hsapiens.v75
    TxDb.Dmelanogaster.UCSC.dm3.ensGene EnsDb.Mmusculus.v79
    IlluminaHumanMethylationEPICv2anno.20a1.hg38 BSgenome.Hsapiens.NCBI.GRCh38
    org.Dr.eg.db hgu95av2cdf Homo.sapiens IlluminaHumanMethylationEPICv2manifest
    hgu95av2probe hugene10sttranscriptcluster.db PFAM.db BSgenome.Celegans.UCSC.ce2
    TxDb.Mmusculus.UCSC.mm9.knownGene TxDb.Hsapiens.UCSC.hg18.knownGene hgu95a.db
    illuminaHumanv4.db BSgenome.Hsapiens.1000genomes.hs37d5
    BSgenome.Hsapiens.UCSC.hg18 BSgenome.Scerevisiae.UCSC.sacCer2
    BSgenome.Dmelanogaster.UCSC.dm3 org.Ce.eg.db SNPlocs.Hsapiens.dbSNP144.GRCh37
    drosophila2probe hgu133aprobe SNPlocs.Hsapiens.dbSNP155.GRCh38
    SNPlocs.Hsapiens.dbSNP155.GRCh37 org.Bt.eg.db org.Ss.eg.db org.EcK12.eg.db
    TxDb.Athaliana.BioMart.plantsmart22 SNPlocs.Hsapiens.dbSNP144.GRCh38 hgu133acdf
    org.Gg.eg.db JASPAR2024 org.Mmu.eg.db hgu133a2cdf pd.hugene.1.0.st.v1
    JASPAR2022 IlluminaHumanMethylationEPICanno.ilm10b2.hg19
    TxDb.Rnorvegicus.UCSC.rn4.ensGene TxDb.Celegans.UCSC.ce6.ensGene
    EnsDb.Hsapiens.v79 pd.hg.u133.plus.2 hgu133a2.db Mus.musculus org.Cf.eg.db
    mouse4302.db PolyPhen.Hsapiens.dbSNP131 JASPAR2018 illuminaHumanv3.db
    BSgenome.Mmusculus.UCSC.mm9 TxDb.Hsapiens.UCSC.hg19.lincRNAsTranscripts
    BSgenome.Celegans.UCSC.ce11 FDb.UCSC.tRNAs SIFT.Hsapiens.dbSNP132
    SIFT.Hsapiens.dbSNP137 BSgenome.Hsapiens.UCSC.hg38.masked pd.huex.1.0.st.v2
    BSgenome.Scerevisiae.UCSC.sacCer3 TxDb.Celegans.UCSC.ce11.ensGene hgu95acdf
    BSgenome.Ecoli.NCBI.20080805 hgu219.db rae230aprobe hu6800.db rae230a.db
    BSgenome.Hsapiens.UCSC.hg19.masked org.Xl.eg.db BSgenome.Rnorvegicus.UCSC.rn5
    BSgenome.Scerevisiae.UCSC.sacCer1 org.Pt.eg.db
    TxDb.Mmusculus.UCSC.mm39.knownGene soybeancdf BSgenome.Drerio.UCSC.danRer7
    TxDb.Dmelanogaster.UCSC.dm6.ensGene XtraSNPlocs.Hsapiens.dbSNP144.GRCh38
    TxDb.Mmusculus.UCSC.mm10.ensGene hugene20sttranscriptcluster.db humanCHRLOC
    oligoData pd.mapping50k.xba240 org.Pf.plasmo.db pd.hg.u95av2 org.Ag.eg.db
    human.db0 BSgenome.Dmelanogaster.UCSC.dm6 lumiHumanAll.db org.EcSakai.eg.db
    mogene10sttranscriptcluster.db TxDb.Scerevisiae.UCSC.sacCer3.sgdGene
    pd.hg18.60mer.expr rat2302.db pd.genomewidesnp.6 miRBaseVersions.db
    Orthology.eg.db pd.hta.2.0 hugene10stv1cdf BSgenome.Athaliana.TAIR.TAIR9
    BSgenome.Celegans.UCSC.ce10 lumiHumanIDMapping hgu95av2 mouse4302cdf
    pd.mogene.1.0.st.v1 PANTHER.db pd.hugene.2.0.st hgu133plus2probe
    genomewidesnp6Crlmm TxDb.Rnorvegicus.UCSC.rn5.refGene illuminaHumanv2.db
    metaboliteIDmapping SNPlocs.Hsapiens.dbSNP150.GRCh38
    TxDb.Hsapiens.UCSC.hg38.refGene ChemmineDrugs hugene11sttranscriptcluster.db
    hta20transcriptcluster.db phastCons100way.UCSC.hg19 hgu133b.db
    pd.genomewidesnp.5 pd.hg.u133a TxDb.Athaliana.BioMart.plantsmart28 HPO.db
    grasp2db mogene20sttranscriptcluster.db miRNAtap.db pd.hugene.1.1.st.v1
    pd.mapping250k.nsp Rattus.norvegicus hgfocus.db pd.mogene.2.0.st
    hugene21sttranscriptcluster.db pd.mapping50k.hind240
    huex10sttranscriptcluster.db BSgenome.Drerio.UCSC.danRer11 pd.mapping250k.sty
    hgug4112a.db pd.hg.u219 ath1121501.db mgu74a.db pd.hu6800 pd.hugene.2.1.st
    BSgenome.Cfamiliaris.UCSC.canFam3 mouse.db0 primeviewcdf
    TxDb.Mmusculus.UCSC.mm39.refGene MPO.db pd.mouse430.2 illuminaMousev2.db
    yeast2.db mouse430a2.db pd.hg.u95a rat2302cdf TxDb.Rnorvegicus.UCSC.rn6.refGene
    pd.clariom.d.human chimp.db0 u133x3p.db ath1121501cdf bovine.db0 hgfocusprobe
    hugene10stprobeset.db pd.clariom.s.human phastCons100way.UCSC.hg38
    arabidopsis.db0 BSgenome.Rnorvegicus.UCSC.rn4 hthgu133a.db moe430a.db
    HsAgilentDesign026652.db rat.db0 hgu133bcdf illuminaHumanv1.db fly.db0
    genomewidesnp5Crlmm pd.rg.u34a pig.db0 yeast.db0 ag.db pd.mg.u74c pd.yeast.2
    ragene11stprobeset.db chicken.db0 hgu219cdf mgu74av2.db pd.moe430b
    pd.moex.1.0.st.v1 POCRCannotation.db canine.db0 human370v1cCrlmm pd.hg.u95c
    BSgenome.Ggallus.UCSC.galGal3 celegans.db chicken.db pd.mogene.2.1.st
    pd.rae230a GenomicState human610quadv1bCrlmm pd.tomato SHDZ.db worm.db0
    canine2.db drosophila2.db pd.hg.u133a.2 rhesus.db0 rwgcod.db zebrafish.db0
    hthgu133pluspmcdf pd.ecoli pd.maize pd.pae.g1a BSgenome.Dmelanogaster.UCSC.dm2
    BSgenome.Osativa.MSU.MSU7 hthgu133acdf pd.poplar pd.rae230b pd.rhesus pd.rice
    anopheles.db0 EnsDb.Rnorvegicus.v79 mgug4122a.db mwgcod.db pd.raex.1.0.st.v1
    pd.ragene.1.0.st.v1 BSgenome.Drerio.UCSC.danRer10
    clariomdhumantranscriptcluster.db hwgcod.db mogene10stv1cdf pd.soybean rnu34.db
    FDb.InfiniumMethylation.hg18 hgu133atagcdf pd.citrus pd.drosgenome1 pd.hg.u95d
    pd.ht.hg.u133.plus.pm pd.rg.u34c pd.wheat rgu34a.db ecoliK12.db0
    hgu133plus2frmavecs mogene21sttranscriptcluster.db pd.mg.u74a xenopus.db0
    malaria.db0 pd.rg.u34b pd.yg.s98 TxDb.Drerio.UCSC.danRer10.refGene hgu95ccdf
    moe430bcdf pd.ag pd.hc.g110 pd.mogene.1.1.st.v1 BSgenome.Mmusculus.UCSC.mm8
    maizeprobe mogene10stprobeset.db pd.cotton pd.mg.u74b rae230acdf ricecdf
    u133x3pcdf hgu95d.db hgu95dcdf hugene11stprobeset.db
    pd.2006.07.18.hg18.refseq.promoter pd.porcine riceprobe
    BSgenome.Celegans.UCSC.ce6 hgu133afrmavecs hgu95bcdf
    mogene11sttranscriptcluster.db Norway981.db pd.barley1 agprobe chickencdf
    cottoncdf ecoliprobe h10kcod.db hapmap370k hgu133atagprobe hguDKFZ31.db
    hguqiagenv3.db lumiMouseAll.db maizecdf mgu74bcdf pd.chicken pd.hg.focus
    ri16cod.db ygs98.db bovinecdf clariomshumantranscriptcluster.db excluderanges
    IlluminaHumanMethylation27k.db MafDb.ExAC.r1.0.nonTCGA.hs37d5 mouse4302probe
    paeg1aprobe pd.bovine pd.canine pd.mu11ksuba pd.rat230.2 pd.u133.x3p
    pd.x.tropicalis plasmodiumanophelescdf rae230b.db rae230bcdf
    ragene11sttranscriptcluster.db synaptome.db BSgenome.Cfamiliaris.UCSC.canFam2
    BSgenome.Hsapiens.NCBI.T2T.CHM13v2.0 ecolicdf hgu133a2probe hgu95b.db
    hthgu133pluspmprobe mouse430a2cdf pd.ath1.121501 pd.hg.u95e pd.ht.mg.430a
    pd.s.aureus poplarcdf rhesuscdf wheatprobe ygs98probe barley1cdf canineprobe
    h20kcod.db hgu95ecdf OperonHumanV3.db pd.cytogenetics.array pd.moe430a
    pd.mu11ksubb rtu34.db wheatcdf xenopuslaevisprobe BSgenome.Btaurus.UCSC.bosTau3
    BSgenome.Hsapiens.UCSC.hg17 BSgenome.Mfascicularis.NCBI.5.0 celeganscdf cMAP
    drosgenome1cdf hgfocuscdf hgu95aprobe hgu95c.db indac.db LAPOINTE.db mgu74acdf
    mgu74aprobe mi16cod.db MmAgilentDesign026655.db Mu22v3.db pd.e.coli.2
    pd.mirna.4.0 pd.ovigene.1.0.st xtropicalisprobe ath1121501probe barley1probe
    bovineprobe ecoliSakai.db0 hgu133bprobe hgu95e.db medicagocdf mgu74c.db
    moe430acdf nugohs1a520180.db pd.bovgene.1.1.st pd.drosophila.2 pd.hg.u95b
    saureusprobe zebrafishcdf canine.db canine2cdf citruscdf drosgenome1probe
    illuminaMousev1.db illuminaRatv1.db mgu74b.db mgu74cv2probe moe430aprobe
    pd.aragene.1.0.st pd.hg.u133a.tag pd.mg.u74av2 pd.vitis.vinifera
    pd.zebgene.1.1.st rgu34c.db vitisviniferaprobe BSgenome.Drerio.UCSC.danRer6
    BSgenome.Ggallus.UCSC.galGal4 celegansprobe hcg110.db hi16cod.db mgu74av2cdf
    mgu74cprobe mgu74cv2cdf PartheenMetaData.db pd.bsubtilis pd.mg.u74cv2
    pd.rhegene.1.1.st poplarprobe rgu34cprobe rhesusprobe RmiR.hsa bovine.db
    BSgenome.Mmulatta.UCSC.rheMac10 ecoli2probe HuO22.db illuminaHumanWGDASLv4.db
    illuminaMousev1p1.db lumiMouseIDMapping MafDb.1Kgenomes.phase3.hs37d5
    mgu74av2probe mgu74bprobe pd.charm.hg18.example pd.equgene.1.1.st
    pd.mouse430a.2 pd.rjpgene.1.1.st porcinecdf porcineprobe primeviewprobe
    rat2302probe rgug4131a.db SNPlocs.Hsapiens.dbSNP149.GRCh38 xlaevis.db
    BSgenome.Drerio.UCSC.danRer5 BSgenome.Mmusculus.UCSC.mm9.masked
    BSgenome.Ptroglodytes.UCSC.panTro2 drosophila2cdf FDb.UCSC.snp135common.hg19
    hgu95bprobe hgu95cprobe hgu95dprobe hgu95eprobe htmg430pmcdf hu6800probe
    hugene10stv1probe IlluminaHumanMethylation27kanno.ilmn12.hg19 m10kcod.db
    mgu74ccdf mogene10stv1probe mouse430a2probe pd.hg.u133b pd.ht.hg.u133a
    pd.rhegene.1.0.st pd.zebrafish rae230bprobe rgu34b.db RnAgilentDesign028282.db
    tomatoprobe u133aaofav2cdf vitisviniferacdf BSgenome.Athaliana.TAIR.04232008
    BSgenome.Mmusculus.UCSC.mm10.masked canine2probe citrusprobe hu35ksubc.db
    IlluminaHumanMethylation27kmanifest illuminaHumanv2BeadID.db lumiRatAll.db
    lumiRatIDMapping mgu74bv2probe pd.bovgene.1.0.st pd.canine.2
    pd.ragene.1.1.st.v1 pd.ragene.2.0.st pd.sugar.cane pd.x.laevis.2 rgu34aprobe
    rgu34bprobe caninecdf ecoliasv2probe FDb.UCSC.snp137common.hg19 hthgu133aprobe
    htmg430pmprobe htratfocuscdf moe430bprobe mogene11stprobeset.db
    pd.clariom.s.mouse pd.ecoli.asv2 pd.feinberg.hg18.me.hx1 pd.ovigene.1.1.st
    pd.xenopus.laevis rgug4130a.db RmiR.Hs.miRNA soybeanprobe u133x3pprobe
    xlaevis2probe BSgenome.Amellifera.BeeBase.assembly4
    BSgenome.Btaurus.UCSC.bosTau6 cottonprobe hgug4100a.db hgug4110b.db
    htratfocusprobe illuminaHumanWGDASLv3.db MafDb.1Kgenomes.phase1.hs37d5
    medicagoprobe moex10sttranscriptcluster.db pd.cangene.1.0.st pd.mirna.3.1
    pd.mta.1.0 porcine.db synaptome.data xenopuslaeviscdf xtropicaliscdf
    yeast2probe BSgenome.Btaurus.UCSC.bosTau9 BSgenome.Gaculeatus.UCSC.gasAcu1
    chickenprobe Hs6UG171.db htmg430acdf htmg430bprobe hu35ksubb.db hu35ksubcprobe
    JazaeriMetaData.db Mu15v1.db nugohs1a520180cdf nugohs1a520180probe pd.mg.u74bv2
    pd.plasmodium.anopheles pd.porgene.1.1.st plasmodiumanophelesprobe
    ragene10sttranscriptcluster.db sugarcaneprobe BSgenome.Btaurus.UCSC.bosTau4
    BSgenome.Mmulatta.UCSC.rheMac2 ecoli2.db hgu219probe hthgu133bprobe
    HuExExonProbesetLocationHg18 HuExExonProbesetLocationHg19 moe430b.db
    MoExExonProbesetLocation mogene20stprobeset.db pd.aragene.1.1.st pd.celegans
    pd.cyngene.1.1.st pd.cyrgene.1.0.st ragene10stprobeset.db zebrafishprobe
    BSgenome.Alyrata.JGI.v1 drosgenome1.db GGHumanMethCancerPanelv1.db
    htrat230pmprobe mgug4121a.db mirna10cdf mu11ksubbprobe nugomm1a520177probe
    pd.2006.07.18.mm8.refseq.promoter pd.feinberg.mm8.me.hx1 pd.mirna.1.0
    pd.mirna.2.0 pd.ragene.2.1.st pd.rn.u34 pd.soygene.1.1.st pd.zebgene.1.0.st
    r10kcod.db ragene10stv1cdf TxDb.Celegans.UCSC.ce11.refGene xlaevis2cdf
    adme16cod.db BSgenome.Amellifera.UCSC.apiMel2 CTCF hthgu133bcdf hu35ksubaprobe
    hu35ksubdprobe mgu74bv2cdf mu11ksuba.db mu11ksubaprobe mu19ksubb.db
    pd.cyrgene.1.1.st pd.porgene.1.0.st TxDb.Ggallus.UCSC.galGal5.refGene
    BSgenome.Sscrofa.UCSC.susScr3 clariomsmousetranscriptcluster.db hthgu133b.db
    htmg430aprobe htmg430bcdf hu35ksubd.db IlluminaHumanMethylation450kprobe
    mu19ksubc.db pd.cyngene.1.0.st pd.equgene.1.0.st RaExExonProbesetLocation
    ragene21stprobeset.db TxDb.Drerio.UCSC.danRer11.refGene agcdf
    BSgenome.Ptroglodytes.UCSC.panTro3 EnsDb.Mmusculus.v75 hgubeta7.db hgug4101a.db
    hgug4845a.db hthgu133afrmavecs hu35ksuba.db hu35ksubbprobe
    hugene21stprobeset.db mm24kresogen.db pd.felgene.1.0.st pd.felgene.1.1.st
    pd.mirna.3.0 ragene20stprobeset.db rtu34probe
    TxDb.Scerevisiae.UCSC.sacCer2.sgdGene zebrafish.db
    BSgenome.Btaurus.UCSC.bosTau6.masked BSgenome.Hsapiens.UCSC.hg18.masked
    BSgenome.Tgondii.ToxoDB.7.0 hs25kresogen.db htrat230pmcdf hu6800cdf
    hugene20stprobeset.db m20kcod.db nugomm1a520177cdf pd.cangene.1.1.st
    pd.medicago tomatocdf AHEnsDbs BSgenome.Mmusculus.UCSC.mm8.masked hgug4111a.db
    MafDb.1Kgenomes.phase3.GRCh38 mgu74cv2.db mu19ksuba.db
    pd.081229.hg18.promoter.medip.hx1 pd.2006.10.31.rn34.refseq.promoter
    pd.rcngene.1.1.st ragene10stv1probe ragene20sttranscriptcluster.db ygs98cdf
    hugene.1.0.st.v1frmavecs mgug4120a.db mu11ksubb.db test3cdf
    FDb.FANTOM4.promoters.hg19 huex10stprobeset.db HuExExonProbesetLocation
    humanomni25quadv1bCrlmm mgug4104a.db rgu34bcdf SomaScan.db
    BSgenome.Hsapiens.UCSC.hg38.dbSNP151.major BSgenome.Rnorvegicus.UCSC.rn7
    clariomdhumanprobeset.db LymphoSeqDB MafDb.gnomAD.r2.1.GRCh38 pedbarrayv10.db
    rgu34acdf rtu34cdf mogene21stprobeset.db mouse4302frmavecs mpedbarray.db
    pd.margene.1.1.st pd.rusgene.1.1.st pd.soygene.1.0.st pedbarrayv9.db
    ragene21sttranscriptcluster.db rguatlas4k.db EPICv2manifest gp53cdf
    human650v3aCrlmm mu19ksubbcdf pd.rabgene.1.1.st rgug4105a.db rnu34probe
    XtraSNPlocs.Hsapiens.dbSNP144.GRCh37 BSgenome.Hsapiens.UCSC.hg38.dbSNP151.minor
    BSgenome.Mmulatta.UCSC.rheMac3 BSgenome.Rnorvegicus.UCSC.rn5.masked
    BSgenome.Sscrofa.UCSC.susScr11 hguatlas13k.db hpAnnot humanomni1quadv1bCrlmm
    mguatlas5k.db pd.drogene.1.0.st pd.nugo.hs1a520180 pd.nugo.mm1a520177
    pd.rjpgene.1.0.st pd.rusgene.1.0.st saureuscdf BSgenome.Btaurus.UCSC.bosTau8
    BSgenome.Cfamiliaris.UCSC.canFam3.masked
    BSgenome.Gaculeatus.UCSC.gasAcu1.masked cyp450cdf ecoli2cdf human1mduov3bCrlmm
    human370quadv3cCrlmm moex10stprobeset.db pd.elegene.1.1.st pd.guigene.1.1.st
    rattoxfxprobe rnu34cdf Roberts2005Annotation.db hcg110cdf human550v3bCrlmm
    paeg1acdf pd.elegene.1.0.st ratCHRLOC test2cdf test3probe
    BSgenome.Amellifera.UCSC.apiMel2.masked BSgenome.Drerio.UCSC.danRer7.masked
    BSgenome.Ggallus.UCSC.galGal4.masked fitCons.UCSC.hg19 hcg110probe hu35ksubacdf
    hu35ksubbcdf human1mv1cCrlmm human660quadv1aCrlmm mgu74bv2.db mu11ksubbcdf
    mu6500subdcdf pd.chigene.1.0.st pd.chogene.2.0.st pd.margene.1.0.st
    pd.medgene.1.0.st pd.rcngene.1.0.st phastCons7way.UCSC.hg38 raex10stprobeset.db
    TxDb.Rnorvegicus.UCSC.rn7.refGene yeast2cdf
    BSgenome.Btaurus.UCSC.bosTau3.masked hivprtplus2cdf hu35ksubdcdf
    humanomniexpress12v1bCrlmm LowMACAAnnotation nugomm1a520177.db
    TxDb.Btaurus.UCSC.bosTau9.refGene ye6100subdcdf
    BSgenome.Drerio.UCSC.danRer6.masked BSgenome.Rnorvegicus.UCSC.rn4.masked
    BSgenome.Sscrofa.UCSC.susScr3.masked BSgenome.Tguttata.UCSC.taeGut1
    bsubtilisprobe ecoliasv2cdf hgu133a2frmavecs hthgu133pluspm.db hu6800subacdf
    hu6800subbcdf humancytosnp12v2p1hCrlmm MafDb.ExAC.r1.0.hs37d5 mirna102xgaincdf
    mu6500subccdf pd.chogene.2.1.st pd.fingene.1.0.st pd.rabgene.1.0.st
    phastCons30way.UCSC.hg38 rgu34ccdf TxDb.Hsapiens.BioMart.igis
    BSgenome.Hsapiens.UCSC.hg17.masked BSgenome.Mmulatta.UCSC.rheMac2.masked
    BSgenome.Mmulatta.UCSC.rheMac3.masked BSgenome.Ptroglodytes.UCSC.panTro2.masked
    MafDb.gnomADex.r2.1.hs37d5 mirna20cdf mu19ksubccdf mu6500subacdf
    pd.chigene.1.1.st pd.drogene.1.1.st pd.fingene.1.1.st rattoxfxcdf sugarcanecdf
    test1cdf BSgenome.Btaurus.UCSC.bosTau4.masked
    BSgenome.Ggallus.UCSC.galGal3.masked BSgenome.Ggallus.UCSC.galGal6 bsubtiliscdf
    hu35ksubccdf MafDb.ExAC.r1.0.GRCh38 mirna10probe pd.clariom.s.human.ht
    pd.medgene.1.1.st pd.rta.1.0 raex10sttranscriptcluster.db
    clariomshumanhttranscriptcluster.db MafH5.gnomAD.v4.0.GRCh38
    mta10transcriptcluster.db mu11ksubacdf mu19ksubacdf pd.guigene.1.0.st
    TxDb.Sscrofa.UCSC.susScr11.refGene ye6100subbcdf
    BSgenome.Cfamiliaris.UCSC.canFam2.masked BSgenome.Drerio.UCSC.danRer5.masked
    BSgenome.Mfuro.UCSC.musFur1 BSgenome.Ptroglodytes.UCSC.panTro3.masked
    clariomsmousehttranscriptcluster.db ENCODExplorerData geneplast.data
    hu6800subccdf huex.1.0.st.v2frmavecs MafDb.gnomAD.r2.1.hs37d5
    MafDb.TOPMed.freeze5.hg19 mu6500subbcdf pd.clariom.s.mouse.ht ye6100subacdf
    EnsDb.Rnorvegicus.v75 hta20probeset.db hu6800subdcdf
    MafDb.1Kgenomes.phase1.GRCh38 mouseCHRLOC rta10transcriptcluster.db
    TxDb.Mmulatta.UCSC.rheMac10.refGene BSgenome.Mmulatta.UCSC.rheMac8
    BSgenome.Vvinifera.URGI.IGGP12Xv2 htmg430pm.db mta10probeset.db ye6100subccdf
    BSgenome.Hsapiens.UCSC.hs1 BSgenome.Ptroglodytes.UCSC.panTro5
    BSgenome.Vvinifera.URGI.IGGP8X geneplast.data.string.v91 humanomni5quadv1bCrlmm
    TxDb.Athaliana.BioMart.plantsmart25 TxDb.Athaliana.BioMart.plantsmart51
    TxDb.Rnorvegicus.BioMart.igis BSgenome.Vvinifera.URGI.IGGP12Xv0 chromhmmData
    mouse430a2frmavecs pd.clariom.s.rat pd.clariom.s.rat.ht
    BSgenome.Ggallus.UCSC.galGal5 BSgenome.Ptroglodytes.UCSC.panTro6
    BSgenome.Tguttata.UCSC.taeGut2 EuPathDB
    IlluminaHumanMethylationEPICanno.ilm10b3.hg19 MafDb.TOPMed.freeze5.hg38
    mogene.1.0.st.v1frmavecs rGenomeTracksData rta10probeset.db
    TxDb.Btaurus.UCSC.bosTau8.refGene TxDb.Sscrofa.UCSC.susScr3.refGene
    ygs98frmavecs BioMartGOGeneSets BSgenome.Dmelanogaster.UCSC.dm3.masked
    BSgenome.Tguttata.UCSC.taeGut1.masked Hspec MafDb.gnomADex.r2.1.GRCh38
    TxDb.Ggallus.UCSC.galGal4.refGene TxDb.Ggallus.UCSC.galGal6.refGene
    TxDb.Mmulatta.UCSC.rheMac3.refGene TxDb.Mmulatta.UCSC.rheMac8.refGene
    UniProtKeywords BSgenome.Amellifera.NCBI.AmelHAv3.1 BSgenome.Gmax.NCBI.Gmv40
    clariomsrattranscriptcluster.db hthgu133plusa.db
    TxDb.Ptroglodytes.UCSC.panTro4.refGene GeneSummary
    MafDb.ExAC.r1.0.nonTCGA.GRCh38 BSgenome.Aofficinalis.NCBI.V1
    TENET.AnnotationHub AHMeSHDbs alternativeSplicingEvents.hg19
    BSgenome.Mfascicularis.NCBI.6.0 TxDb.Ptroglodytes.UCSC.panTro5.refGene
    alternativeSplicingEvents.hg38 BSgenome.Carietinum.NCBI.v1
    BSgenome.Creinhardtii.JGI.v5.6 BSgenome.Dmelanogaster.UCSC.dm2.masked
    BSgenome.Mdomestica.UCSC.monDom5 EpiTxDb.Hs.hg38
    IlluminaHumanMethylationMSAmanifest rat2302frmavecs org.Mxanthus.db
    BSgenome.Cjacchus.UCSC.calJac3 BSgenome.Cjacchus.UCSC.calJac4
    BSgenome.Ppaniscus.UCSC.panPan2 TxDb.Cfamiliaris.UCSC.canFam3.refGene
    BSgenome.Ppaniscus.UCSC.panPan1 AHLRBaseDbs AHPathbankDbs
    BSgenome.Btaurus.UCSC.bosTau9.masked BSgenome.Dvirilis.Ensembl.dvircaf1
    hspeccdf AHCytoBands AHPubMedDbs AHWikipathwaysDbs
    clariomsrathttranscriptcluster.db htrat230pm.db htratfocus.db
    TxDb.Rnorvegicus.UCSC.rn6.ncbiRefSeq
    BSgenome.CneoformansVarGrubiiKN99.NCBI.ASM221672v1 EpiTxDb.Sc.sacCer3
    IlluminaHumanMethylationMSAanno.ilm10a1.hg38 UCSCRepeatMasker
    ath1121501frmavecs CENTREannotation AlphaMissense.v2023.hg38 cadd.v1.6.hg38
    EpiTxDb.Mm.mm10 phastCons35way.UCSC.mm39 TxDb.Ptroglodytes.UCSC.panTro6.refGene
    htmg430a.db org.Hbacteriophora.eg.db AlphaMissense.v2023.hg19 gwascatData
    hthgu133plusb.db htmg430b.db TxDb.Hsapiens.UCSC.hg19.refGene cadd.v1.6.hg19
    ontoProcData phyloP35way.UCSC.mm39 scAnnotatR.models
    TxDb.Cfamiliaris.UCSC.canFam4.refGene TxDb.Cfamiliaris.UCSC.canFam5.refGene
    TxDb.Cfamiliaris.UCSC.canFam6.refGene

Timeout downloading https://bioconductor.org/packages/3.22/data/annotation/src/contrib/MafDb.gnomAD.r2.1.GRCh38_3.10.0.tar.gz so adjust timeout.

    wget https://bioconductor.org/packages/3.22/data/annotation/src/contrib/MafDb.gnomAD.r2.1.GRCh38_3.10.0.tar.gz
    R CMD INSTALL MafDb.gnomAD.r2.1.GRCh38_3.10.0.tar.gz

*OR ALTERNATIVELY*

    options(timeout = 1200)
    BiocManager::install('MafDb.gnomAD.r2.1.GRCh38')


Installing all ExperimentData packages ...
------------------------------------------

    dd <- read.delim('/sw/apps/R_packages/external_tarballs/ExperimentData-3.22.txt', header=FALSE, colClasses="character")[,1]
    BiocManager::install(dd)

Packages listed in /sw/apps/R_packages/external_tarballs/ExperimentData-3.22.txt are:

    TCGAbiolinksGUI.data celldex ALL HSMMSingleCell airway geneLenDataBase scRNAseq
    bcellViper tximportData dorothea pasilla RNAseqData.HNRNPC.bam.chr14 sesameData
    affydata msigdb ChAMPdata GSVAdata msdata pasillaBamSubset TENxPBMCData
    Illumina450ProbeVariants.db minfiData bladderbatch golubEsets faahKO depmap
    curatedMetagenomicData humanStemCell gageData FlowSorted.Blood.450k pRolocdata
    spatialLIBD ALLMLL zebrafishRNASeq flowWorkspaceData FlowSorted.Blood.EPIC
    DMRcatedata curatedTCGAData RTCGA.clinical SpikeInSubset STexampleData
    yeastNagalakshmi muscData systemPipeRdata TENxBrainData CLL DropletTestFiles
    KEGGdzPathwaysGEO macrophage JASPAR2014 JASPAR2016 MOFAdata ELMER.data
    MouseGastrulationData h5vcData breastCancerMAINZ minfiDataEPIC DLBCL
    breastCancerVDX fibroEset HDCytoData methylclockData breastCancerUPP
    QDNAseq.hg19 CCl4 hapmap100kxba RTCGA.mRNA RnBeads.hg19 breastCancerNKI fission
    ewceData RTCGA.rnaseq maqcExpression4plex breastCancerTRANSBIG
    tweeDEseqCountData estrogen RforProteomics yeastRNASeq hapmapsnp6
    breastCancerUNT HelloRangesData leeBamViews AffymetrixDataTestFiles
    IlluminaDataTestFiles microbiomeDataSets bsseqData curatedOvarianData
    lumiBarnes genomationData EGSEAdata RnBeads.hg38 lungExpression yeastCC
    chipenrich.data GWASdata RTCGA.miRNASeq SpikeIn gaschYHS RnaSeqSampleSizeData
    RTCGA.mutations DAPARdata leukemiasEset easierData hapmapsnp5 DuoClustering2018
    rcellminerData RnBeads.mm9 crisprScoreData pumadata yeastExpData harbChIP
    KEGGandMetacoreDzPathwaysGEO MAQCsubset mvoutData Neve2006 ProData beta7
    gcspikelite Hiiragi2013 derfinderData ecoliLeucine RTCGA.methylation RTCGA.RPPA
    SBGNview.data RTCGA.CNV SFEData AmpAffyExample AneuFinderData ccdata
    RUVnormalizeData imcdatasets dyebiasexamples HCAData HEEBOdata RTCGA.PANCAN12
    antiProfilesData M3DExampleData MEDIPSData hapmap100khind QDNAseq.mm10
    RcisTarget.hg19.motifDBs.cisbpOnly.500bp curatedBladderData kidpack
    mosaicsExample TabulaMurisSenisData frmaExampleData
    PWMEnrich.Hsapiens.background SNAGEEdata colonCA davidTiling HMP16SData
    MEEBOdata cancerdata dressCheck Fletcher2013b RnBeads.mm10 TCGAMethylation450k
    bronchialIL13 ITALICSData mCSEAdata SomaticCancerAlterations FANTOM3and4CAGE
    RMassBankData signatureSearchData CardinalWorkflows miRNATarget NxtIRFdata
    TBX20BamSubset XhybCasneuf breakpointRdata BloodCancerMultiOmics2017
    LungCancerLines ChIPXpressData ConnectivityMap curatedBreastData
    GeuvadisTranscriptExpr mtbls2 metaMSdata PasillaTranscriptExpr pepDat
    tinesath1probe ffpeExampleData hapmap500knsp PREDAsampledata
    PWMEnrich.Dmelanogaster.background aracne.networks cMap2data grndata HD2013SGI
    hgu2beta7 brgedata chromstaRData mammaPrintData beadarrayExampleData COSMIC.67
    SingleCellMultiModal CopyhelpeR hapmap500ksty scpdata affycompData fabiaData
    simpIntLists TENxVisiumData Affyhgu133Plus2Expr
    FlowSorted.CordBloodCombined.450k HMP2Data TabulaMurisData Fletcher2013a
    FlowSorted.DLPFC.450k IHWpaper SNAData FlowSorted.CordBloodNorway.450k
    prebsdata TargetSearchData COPDSexualDimorphism.data FlowSorted.CordBlood.450k
    pd.atdschip.tiling plotgardenerData tissueTreg Affymoe4302Expr
    GenomicDistributionsData HiCDataHumanIMR90 HIVcDNAvantWout03 tinesath1cdf
    PWMEnrich.Mmusculus.background TCGAWorkflowData Iyer517 DeSousa2013
    EatonEtAlChIPseq ReactomeGSA.data SCLCBam seqc stemHypoxia ARRmData
    minionSummaryData rheumaticConditionWOLLBOLD msd16s OMICsPCAdata RegParallel
    seventyGeneData Single.mTEC.Transcriptomes BeadArrayUseCases PathNetData FIs
    GSBenchMark COHCAPanno DrugVsDiseasedata HiContactsData rRDPData BioImageDbs
    HarmanData LiebermanAidenHiC2009 yeastGSData Affyhgu133aExpr ASICSdata
    timecoursedata WES.1KG.WUGSC MSMB blimaTestingData DvDdata GSE62944
    LungCancerACvsSCCGEO lydata ptairData chipseqDBData cnvGSAdata NCIgraphData
    biotmleData HiCDataLymphoblast MMDiffBamSubset PCHiCdata RnBeads.rn5
    shinyMethylData TargetScoreData KOdata RITANdata seq2pathway.data
    healthyFlowData hgu133plus2barcodevecs WGSmapp Affyhgu133A2Expr furrowSeg
    RGMQLlib ChimpHumanBrainData PepsNMRData MerfishData serumStimulation tartare
    hgu133plus2CellScore MethylAidData prostateCancerCamcap prostateCancerGrasso
    diggitdata msPurityData NanoporeRNASeq topdownrdata CluMSIDdata
    MouseThymusAgeing biscuiteerData orthosData RRBSdata DonaPLLP2013 HCATonsilData
    ChIPexoQualExample ListerEtAlBSseq NGScopyData nullrangesData bodymapRat
    DExMAdata miRcompData msqc1 SNPhoodData SomatiCAData TCGAcrcmRNA
    VariantToolsData adductData flowPloidyData scMultiome CRCL18
    mouse4302barcodevecs SpatialDatasets CONFESSdata CopyNeutralIMA
    epimutacionsData MetaGxBreast optimalFlowData scanMiRData vulcandata
    AshkenazimSonChr21 prostateCancerVarambally QUBICdata sampleClassifierData
    scTHI.data AssessORFData BeadSorted.Saliva.EPIC microRNAome nanotubes
    prostateCancerTaylor RNAmodR.Data EpiMix.data hgu133abarcodevecs
    OnassisJavaLibs diffloopdata MUGAExampleData prostateCancerStockholm
    cfToolsData fourDNData PtH2O2lipids CellMapperData DNAZooData NestLink
    NetActivityData SubcellularSpatialData tofsimsData curatedAdipoRNA SVM2CRMdata
    TENxBUSData etec16s gpaExample octad.db clustifyrdatahub gDRtestData oct4
    spqnData GIGSEAdata HumanAffyData MicrobiomeBenchmarkData CytoMethIC
    TCGAcrcmiRNA TMExplorer WeberDivechaLCdata xcoredata curatedTBData EpipwR.data
    gDNAinRNAseqData curatedAdipoChIP GSE103322 LRcellTypeMarkers MACSdata
    marinerData GSE13015 HarmonizedTCGAData MetaScope MethylSeqData
    PhyloProfileData raerdata scATAC.Explorer TENxXeniumData TumourMethData
    CLLmethylation curatedPCaData emtdata mcsurvdata celarefData curatedAdipoArray
    FieldEffectCrc healthyControlsPresenceChecker HighlyReplicatedRNASeq
    multiWGCNAdata qPLEXdata SimBenchData VectraPolarisData BioPlex
    SingleMoleculeFootprintingData humanHippocampus2024 MetaGxPancreas smokingMouse
    TimerQuant MouseAgingData ObMiTi scaeData tuberculosis GSE159526 HiBED
    preciseTADhub CoSIAdata muleaData ProteinGymR spatialDmelxsim bugphyzz LegATo
    TransOmicsData eoPredData JohnsonKinaseData muSpaData TENET.ExperimentHub
    homosapienDEE2CellScore MetaGxOvarian curatedCRCData CENTREprecomputed
    AWAggregatorData iModMixData ChIPDBData DoReMiTra nmrdata

Final cleanup.

    wget https://bioconductor.org/packages/3.19/data/experiment/src/contrib/curatedCRCData_2.35.0.tar.gz
    R CMD INSTALL curatedCRCData_2.35.0.tar.gz

    git clone --recursive https://git.bioconductor.org/packages/MetaGxOvarian

    install.packages('MetaGxOvarian', repos=NULL)

    wget https://cran.r-project.org/src/contrib/reticulate_1.45.0.tar.gz
    module load python/3.12.7
    R CMD INSTALL reticulate_1.45.0.tar.gz

    BiocManager::install("BeadDataPackR")
    BiocManager::install("beadarrayExampleData")

    git clone --recursive https://git.bioconductor.org/packages/beadarray

    install.packages('beadarray', repos=NULL)

    BiocManager::install("BeadDataPackR")

    
liana
=====

    remotes::install_github('saezlab/liana')


The remainder of BioConductor 3.22
==================================

Install the remainder of BioConductor 3.22.  Created bioc.inst1.R to manage this.

    setwd("/sw/apps/R_packages/4.5.1")
    source("bioc.inst1.R")

Several failed to install.

    AlphaMissenseR BayesSpace BiocWorkflowTools CAGEWorkflow CAGEfightR CAGEr
    CBNplot CCPlotR CSOA CVXR ChemmineOB ChromSCape ClustIRR CuratedAtlasQueryR
    CytoML FLAMES GladiaTOX HMP2Data HPO.db HilbertVisGUI IntEREst Moonlight2R OHCA
    PMCMRplus QUBIC RMariaDB RNAseq123 RankProd RbowtieCuda RcisTarget RedisParam
    Rmpfr Rmpi SingleMoleculeFootprinting SpaceTroope SpatialExperimentIO SpectriPy
    adductomicsR alabaster.sfe archive arrow autonomics cTRAP ccfindR cfDNAPro
    cytoviewer dandelionR destiny duckdb epivizrStandalone gD gDRcore gDRstyle
    gDRutils geneXtendeR git2r gmapR iBBiG maEndToEnd mosbi nearBynding octad
    openCyto pqsfinder redux rexposome rqubic rsbml runibic sfarrow tiledb xenLite

and others

Could not install several because 'duckdb' kept kitting the 1800s install
timeout.  So:

    q()
    export _R_INSTALL_PACKAGES_ELAPSED_TIMEOUT_="2h"
    R --no-init-file

and go again. It worked!

HMP2Data fails.

    Installing package(s) 'HMP2Data'
    trying URL 'https://bioconductor.org/packages/3.22/data/experiment/src/contrib/HMP2Data_1.24.0.tar.gz'
    Content type 'application/x-gzip' length 5396882 bytes (5.1 MB)
    ==================================================
    downloaded 5.1 MB

    * installing *source* package �HMP2Data� ...
    ** this is package �HMP2Data� version �1.24.0�
    ** using staged installation
    ** R
    ** data
    ** inst
    ** byte-compile and prepare package for lazy loading
    Error: object �id� is not exported by 'namespace:dplyr'
    Execution halted
    ERROR: lazy loading failed for package �HMP2Data�
    * removing �/sw/apps/R_packages/4.5.1/rackham/HMP2Data�

Continuing. biclust archived.

    install.packages('additivityTests')

    wget https://cran.r-project.org/src/contrib/Archive/biclust/biclust_2.0.3.1.tar.gz
    R CMD INSTALL biclust_2.0.3.1.tar.gz

    q()
    module load boost/1.83.0-gcc12.3.0
    R --no-init-file

    BiocManager::install(c('pqsfinder')

    q()
    module unload boost
    module load alphafold/3.0.1 alphafold_dataset/3.0.1
    R --no-init-file

    BiocManager::install(c('AlphaMissenseR'))

    q()
    module unload alphafold alphafold_dataset
    R --no-init-file

    wget https://cran.r-project.org/src/contrib/Archive/pryr/pryr_0.1.6.tar.gz
    R CMD INSTALL pryr_0.1.6.tar.gz

    BiocManager::install(c('CAGEfightR','CAGEr','CAGEWorkflow'))

Cannot install 'BayesSpace','BiocWorkflowTools' because the former needs arrow and the latter, git2r.
    
For Rmpfr:

    install.packages('Rmpfr', configure.args='--with-mpfr-include=$MPFR_ROOT/include --with-mpfr-lib=$MPFR_ROOT/lib')

For others:

    install.packages('RApiSerialize')

    wget https://cran.r-project.org/src/contrib/Archive/ggbump/ggbump_0.1.0.tar.gz
    R CMD INSTALL ggbump_0.1.0.tar.gz
    wget https://cran.r-project.org/src/contrib/Archive/qs/qs_0.27.3.tar.gz
    R CMD INSTALL qs_0.27.3.tar.gz
    wget https://cran.r-project.org/src/contrib/Archive/blaster/blaster_1.0.7.tar.gz
    R CMD INSTALL blaster_1.0.7.tar.gz

    q()
    module load openbabel/3.1.1-gcc12.3.0 boost/1.83.0-gcc12.3.0

Fix up RPATH for libopenbabel.so.7

    patchelf --set-rpath '/sw/libs/boost/1.83.0-gcc12.3.0/rackham/lib:/sw/libs/zlib/1.3.1/rackham/lib:/sw/libs/bzip2/1.0.8/rackham/lib:/sw/apps/xz/5.2.6/rackham/lib:/sw/apps/openbabel/3.1.1-gcc12.3.0/rackham/lib:/sw/comp/gcc/13.3.0_rackham/lib64' /sw/apps/openbabel/3.1.1-gcc12.3.0/rackham/lib/libopenbabel.so.7
    R --no-init-file

    R --no-init-file

    BiocManager::install('ChemmineOB', configure.args='--with-openbabel-include=$OPENBABEL_ROOT/include/openbabel3 --with-openbabel-lib=$OPENBABEL_ROOT/lib')

    q()
    module unload openbabel  
    R --no-init-file

    BiocManager::install(c('CBNplot','CCPlotR','CSOA','CVXR','ChromSCape','ClustIRR','CuratedAtlasQueryR'))

    q()
    module load openmpi/4.1.6
    R --no-init-file

    install.packages('Rmpi')
    install.packages('doMPI')
    install.packages('bigGP')


    module load MariaDB/10.2.11

    install.packages(c('RMariaDB','RMySQL'))


    wget https://cran.r-project.org/src/contrib/Archive/fuzzyjoin/fuzzyjoin_0.1.6.1.tar.gz
    wget https://cran.r-project.org/src/contrib/Archive/seqminer/seqminer_9.7.tar.gz
    R CMD INSTALL fuzzyjoin_0.1.6.1.tar.gz
    R CMD INSTALL seqminer_9.7.tar.gz
   
    BiocManager::install('HiCool')

HiCool will install many additional things when first run, as conda environments in the user's home.

    q()
    module load tbb/2020.3
    R --no-init-file

    BiocManager::install("openCyto")

Using rust/1.85.1.

    chmod -R u+w /sw/comp/rust/1.85.1/rackham

    BiocManager::install(c('FLAMES'))
    BiocManager::install(c('GladiaTOX'))

HPO.db  fails:

    BiocManager::install(c('HPO.db'))
    ...
    Error: package or namespace load failed for �HPO.db�:
     .onLoad failed in loadNamespace() for 'HPO.db', details:
      call: NULL
      error: Replaced by more current version
       Resource removed on: 2024-05-02

HilbertVisGUI needs gtkmm and GTK+ and is not installed.

    BiocManager::install(c('IntEREst','Moonlight2R','OHCA'))
    BiocManager::install(c('FLAMES','GladiaTOX'))
    BiocManager::install('QUBIC')
    BiocManager::install('RankProd')

These need git2r (libgit2) and are not installed:

    RNAseq123
    epivizrStandalone
    gDRstyle

These need CUDA and are not installed:

    RbowtieCuda

These need arrow and are not installed:

    RcisTarget

These need libhiredis and are not installed:

    RedisParam
    redux

SingleMoleculeFootprinting fails with:

    Error: object �filter� is not exported by 'namespace:plyranges'

This builds arrow from scratch and works!

    SpaceTrooper
    SpatialExperimentIO

Cannot be built with available python packages.  That's ok.

    SpectriPy

adductomicsR

    wget https://cran.r-project.org/src/contrib/Archive/smoother/smoother_1.3.tar.gz
    R CMD INSTALL smoother_1.3.tar.gz

    BiocManager::install("adductomicsR")
    
continuing ...

    module load libarchive/3.6.2

    BiocManager::install("archive")
    BiocManager::install("autonomics")
    BiocManager::install("sfarrow")
    BiocManager::install("alabaster.sfe")
    BiocManager::install("cTRAP")
    BiocManager::install("ccfindR")

cfDNAPro failes because

    BiocManager::install("cfDNAPro")
    ...
    Error: object �filter� is not exported by 'namespace:plyranges'
    Execution halted

continuing ...

    BiocManager::install("cytoviewer")
    BiocManager::install("destiny")
    BiocManager::install("dandelionR")
    BiocManager::install("GD")
    BiocManager::install("gDRutils")
    BiocManager::install("gDRcore")

"gD" not available ??

geneXtendeR errors:

    BiocManager::install("geneXtendeR")
    ...
    Error: object �id� is not exported by 'namespace:dplyr'
    Execution halted

    BiocManager::install("")
    BiocManager::install("")
    BiocManager::install("")

gmapR errors:

    BiocManager::install("gmapR")
    ...
    ** testing if installed package can be loaded from temporary location
    Error: package or namespace load failed for �gmapR� in dyn.load(file, DLLpath = DLLpath, ...):
     unable to load shared object '/sw/apps/R_packages/4.5.1/rackham/00LOCK-gmapR/00new/gmapR/libs/gmapR.so':
      /sw/apps/R_packages/4.5.1/rackham/00LOCK-gmapR/00new/gmapR/libs/gmapR.so: undefined symbol: __isoc23_sscanf

continuing ...

    BiocManager::install("iBBiG")

    git clone https://git.bioconductor.org/packages/arrayQualityMetrics

    install.packages('setRNG')
    install.packages('arrayQualityMetrics', repos=NULL)
    BiocManager::install("maEndToEnd")
    BiocManager::install("mosbi")

errors:

    BiocManager::install("nearBynding")
    ...
    Error: object �filter� is not exported by 'namespace:plyranges'
    Execution halted

    BiocManager::install("octad")
    ...
    Error: object �id� is not exported by 'namespace:dplyr'
    Execution halted

    BiocManager::install("rsbml")
    ...
    Error: package or namespace load failed for �rsbml�:
     .onLoad failed in loadNamespace() for 'rsbml', details:
      call: dyn.load(file, DLLpath = DLLpath, ...)
      error: unable to load shared object '/sw/apps/R_packages/4.5.1/rackham/00LOCK-rsbml/00new/rsbml/libs/rsbml.so':
      /sw/libs/libSBML/5.20.2/rackham/lib/libsbml.so.5: undefined symbol: _ZTI14FbcSBasePlugin
    Error: loading failed
    Execution halted
    ERROR: loading failed


continuing ...

    BiocManager::install("rexposome")
    BiocManager::install("rqubic")
    BiocManager::install("runibic")
    BiocManager::install("sfarrow")  # already installed by earlier actions
    BiocManager::install("xenLite")

errors:

    BiocManager::install("tiledb")  # already installed by earlier actions
    ...
    ** testing if installed package can be loaded from temporary location
    Error: package or namespace load failed for �tiledb� in dyn.load(file, DLLpath = DLLpath, ...):
     unable to load shared object '/sw/apps/R_packages/4.5.1/rackham/00LOCK-tiledb/00new/tiledb/libs/tiledb.so':
      /lib64/libm.so.6: version `GLIBC_2.27' not found (required by /sw/apps/R_packages/4.5.1/rackham/00LOCK-tiledb/00new/tiledb/libs/../tiledb/lib/libtiledb.so.2.29)
    Error: loading failed
    Execution halted
    ERROR: loading failed


continuing ...

    BiocManager::install(c('ChIPseeker','clusterProfiler','DOSE','enrichplot','GOSemSim','meshes',"ReactomePA"))

All are installed.

Final wrapup:

    BiocManager::install()
    BiocManager::valid()

    'getOption("repos")' replaces Bioconductor standard repositories, see
    'help("repositories", package = "BiocManager")' for details.
    Replacement repositories:
        CRAN: https://ftp.acc.umu.se/mirror/CRAN/

    * sessionInfo()

    R version 4.5.1 (2025-06-13)
    Platform: x86_64-pc-linux-gnu
    Running under: CentOS Linux 7 (Core)

    Matrix products: default
    BLAS/LAPACK: /sw/libs/openblas/0.3.29/rackham/lib/libopenblas_haswellp-r0.3.29.so;  LAPACK version 3.12.0

    locale:
     [1] LC_CTYPE=en_US.utf-8       LC_NUMERIC=C
     [3] LC_TIME=en_US.utf-8        LC_COLLATE=en_US.utf-8
     [5] LC_MONETARY=en_US.utf-8    LC_MESSAGES=en_US.utf-8
     [7] LC_PAPER=en_US.utf-8       LC_NAME=C
     [9] LC_ADDRESS=C               LC_TELEPHONE=C
    [11] LC_MEASUREMENT=en_US.utf-8 LC_IDENTIFICATION=C

    time zone: Europe/Stockholm
    tzcode source: system (glibc)

    attached base packages:
    [1] stats     graphics  grDevices utils     datasets  methods   base

    loaded via a namespace (and not attached):
    [1] BiocManager_1.30.27 compiler_4.5.1      tools_4.5.1

    Bioconductor version '3.22'

      * 0 packages out-of-date
      * 2 packages too new

    create a valid installation with

      BiocManager::install(c(
        "basilisk.utils", "OmnipathR"
      ), update = TRUE, ask = FALSE, force = TRUE)

    more details: BiocManager::valid()$too_new, BiocManager::valid()$out_of_date

    Warning message:
    0 packages out-of-date; 2 packages too new


At the end:

    A total of 5426 R packages are installed
    A total of 26846 packages are available in CRAN and BioConductor
    1690 CRAN packages are installed, out of 23173 available
    3631 BioConductor-specific packages are installed, out of 3673 available
    103 other R packages are installed. These are not in CRAN/BioConductor, are only available in the CRAN/BioConductor archives, or are hosted on github, gitlab or elsewhere


