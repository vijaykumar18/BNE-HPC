#!/bin/sh
#
#SBATCH -A Vijayabc               # Replace ACCOUNT with your group account name 
#SBATCH -J  make_predict           # The job name
#SBATCH --gres=gpu:2             # Request 1 gpu (Up to 2 gpus per GPU node)
#SBATCH -c 32                    # Number of cores to use (12 in this case)
#SBATCH -N 2				#two nodes
#SBATCH --time 2-23:00                # Runtime in D-HH:MM
#SBATCH --mem-per-cpu=4G          # The memory the job will use per cpu core

module load MATLAB
echo "Launching MATLAB scripts"
date

# Run the 1of  12 MATLAB scripts in parallel
matlab -nosplash -nodisplay -nodesktop -r "make_predict_1" #&

# Wait for all background jobs to finish
wait

echo "All MATLAB jobs completed."
date

# End of Script
