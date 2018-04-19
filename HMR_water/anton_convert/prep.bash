#/bin/bash -u -e -x -o pipefail

JOBNAME=ARF_bigwater_HMRall
WD=/anton2fs/raw/$USER/$JOBNAME/production1
ASW=v2software/1.36.0c7/bin

anton2 prep $WD
