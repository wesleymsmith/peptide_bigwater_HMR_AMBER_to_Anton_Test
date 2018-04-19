#!/bin/bash
#SBATCH -J ARFhmW
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

step=step4.4_equilibration
step_template=step5_production.mdin
for ii in `seq -f "%03g" 0 1 4`
do
	prev_step=$step
	step="step5.${ii}_production"
	cp $step_template ${step}.mdin
	echo "running $step"
	$AMBERHOME/bin/pmemd.cuda  -O -i $step.mdin -c $prev_step.rst7 \
		-p $toppath -r $step.rst7 -ref $prev_step.rst7 \
		-o $step.out -x $step.nc
done

echo "done"


