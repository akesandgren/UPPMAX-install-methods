freesurfer/8.1.0-1
========================

<https://surfer.nmr.mgh.harvard.edu/fswiki/FreeSurferWiki>

Used under license:
Custom open-source
<https://surfer.nmr.mgh.harvard.edu/fswiki/FreeSurferSoftwareLicense>

Structure creating script (makeroom_freesurfer_8.1.0-1.sh) moved to /sw/apps/freesurfer/makeroom_8.1.0-1.sh

LOG
---

    makeroom.sh "-t" "freesurfer" "-v" "8.1.0-1" "-c" "apps" "-w" "https://surfer.nmr.mgh.harvard.edu/fswiki/FreeSurferWiki" "-l" "Custom open-source" "-L" "https://surfer.nmr.mgh.harvard.edu/fswiki/FreeSurferSoftwareLicense" "-d" "A software package for the analysis and visualization of structural and functional neuroimaging data from cross-sectional or longitudinal studies." "-f"
    ./makeroom_freesurfer_8.1.0-1.sh

    source /sw/apps/freesurfer/SOURCEME_freesurfer_7.4.1 && cd $SRCDIR
    # wget https://surfer.nmr.mgh.harvard.edu/pub/dist/freesurfer/7.4.1/freesurfer-linux-centos7_x86_64-7.4.1.tar.gz
    wget https://surfer.nmr.mgh.harvard.edu/pub/dist/freesurfer/8.1.0/freesurfer-CentOS7-8.1.0-1.x86_64.rpm
    # tar xzvf freesurfer-linux-centos7_x86_64-7.4.1.tar.gz
    rpm2cpio freesurfer-CentOS7-8.1.0-1.x86_64.rpm | cpio -idmv
    # replicate the structure from the previous versions i.e. move the content from usr/local/freesurfe... to ../rackham
License file
    cd $TOOLDIR
    cp 6.0.0/rackham/license.txt 8.1.0-1/rackham/


A license file is required. If you can't use the one located at /sw/apps/freesurfer/6.0.0/rackham/license.txt, you can get a new one at http://surfer.nmr.mgh.harvard.edu/registration.html
