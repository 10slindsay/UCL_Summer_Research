#!/bin/bash
#SBATCH --partition COMPUTE
#SBATCH --nodes 1
#SBATCH --ntasks-per-node 1
#SBATCH --mem-per-cpu 12G
#SBATCH --time 20:00:00
#SBATCH --job-name jupyter-notebook
#SBATCH --output jupyter-notebook-%J.log
#Based on https://docs.ycrc.yale.edu/clusters-at-yale/guides/jupyter/
XDG_RUNTIME_DIR=""
port=$(shuf -i8000-9999 -n1)
node=$(hostname -s)
user=$(whoami)
cluster=$(hostname -f | awk -F"." '{print $2}')

# print tunneling instructions jupyter-log

echo -e "To connect:
ssh -N -L ${port}:${node}:${port} ${user}@splinter-login.star.ucl.ac.uk
from zuserver2, then
ssh -N -L ${port}:localhost:${port} ${user}@zuserver2.star.ucl.ac.uk
on a local machine

Use a Browser on your local machine to go to:
localhost:${port}  (prefix w/ https:// if using password)

Remember to scancel job when done. Check output below for access token if
you need it.
"
source /share/apps/anaconda/3-2019.03/etc/profile.d/conda.sh
conda activate
srun -n1 jupyter-notebook --no-browser --port=${port} --ip=${node}


