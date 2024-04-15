#!/bin/bash -l
#SBATCH -J Jupyter
#SBATCH -N 1
#SBATCH --ntasks-per-node=1
#SBATCH -c 1                # Cores assigned to each tasks
#SBATCH --time=0-01:00:00
#SBATCH -p batch
#SBATCH --mem=2G           # Request 4GB of memory

Green='\033[0;32m'
Link='\033[4;32m'
End='\033[m'
print_error_and_exit() { echo "***ERROR*** $*"; exit 1; }
module purge || print_error_and_exit "No 'module' command"
export SRUN_CPUS_PER_TASK=$SLURM_CPUS_PER_TASK

# Python 3.X by default (also on system)
module load lang/Python
source jupyter_env/bin/activate

jupyter notebook --ip $(hostname -i) --no-browser  &
pid=$!
sleep 5s
jupyter notebook list
jupyter --paths
jupyter kernelspec list
printf "copy the following ssh tunnel command to another terminal on your local machine:\n" > notebook.log
printf "${Green}ssh -p 8022 -NL 8888:$(hostname -i):8888 ${USER}@access-iris.uni.lu${End} " >> notebook.log
printf "\n\nFinally, head over to the following URL on your local machine to access the Jupyter server:\n" >> notebook.log
grep -m 1 -o -E '\?token=\S+' slurm-"${SLURM_JOB_ID}".out | sed 's|^|http://localhost:8888/|' >> notebook.log
wait $pid
