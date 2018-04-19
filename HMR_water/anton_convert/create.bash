#/bin/bash -u -e -x -o pipefail

JOBNAME=ARF_bigwater_HMRall
DMSFILE=arf.HMR_nonWater.msys_HMR_water.tip3p.dms
ARKFILE=base.ark
#EXTRACFG="--cfg anton.tune.last_time=50000"
WD=/anton2fs/raw/$USER/$JOBNAME/production1
ASW=v2software/1.36.0c7/bin

for ii in `seq 1 1 20`
do echo -n "-"
done
echo ""
echo -n "$JOBNAME "
anton2 create $JOBNAME --workdir $WD --sw $ASW --include $ARKFILE  --cfg boot.file=$DMSFILE  $EXTRACFG
echo "created on `date`"
for ii in `seq 1 1 20`
do echo -n "-"
done
echo ""
