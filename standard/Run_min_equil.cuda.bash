#!/bin/bash
#SBATCH -J PzYdProd
#SBATCH --get-user-env
#SBATCH --partition=gpus
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --gres=gpu:1
#SBATCH --time=300:00:00
#SBATCH --mail-user=wesley

#set -e 

source /cm/shared/apps/amber16_cuda/amber.sh

set -e
toppath="step2_charmm2amber.parm7"

echo "running production"
step="step2_charmm2amber"
#for ii in `seq -f "%03g" 0 1 0`
#do
	prev_step=$step
	step="step3_minimization"
	echo "running $step"
	$AMBERHOME/bin/pmemd.cuda  -O -i $step.mdin -c $prev_step.rst7 \
		-p $toppath -r $step.rst7 -ref $prev_step.rst7 \
		-o $step.out -x $step.nc
#done

for ii in `seq 0 1 4`
do
	prev_step=$step
	step="step4.${ii}_equilibration"
	echo "running $step"
	$AMBERHOME/bin/pmemd.cuda  -O -i $step.mdin -c $prev_step.rst7 \
		-p $toppath -r $step.rst7 -ref $prev_step.rst7 \
		-o $step.out -x $step.nc
done

echo "done"


