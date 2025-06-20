# HPC Framework for Bayesian Nonparametric Ensemble (BNE) Model

This document provides instructions for setting up and running the Bayesian Nonparametric Ensemble (BNE) model in a high-performance computing (HPC) environment. The setup includes configurations for various clusters and services, such as:

* Globus setup between local machine (Harmattan), Columbia HPC, TAMU ACES, and NSF Open Storage Network (OSN).
* Columbia HPC account setup on the Insomnia cluster.
* Running BNE on the Insomnia cluster of Columbia HPC.
* NSF ACCESS Accelerate grant and account integration.
* NSF Open Storage Network (OSN) account setup and Globus configuration.
* Texas A\&M University (TAMU) ACES account setup for utilizing the TAMU HPC cluster.



## Setting Up HPC Resources

### 1. Globus Setup Between Harmattan (Local Machine), Columbia HPC, TAMU ACES, and OSN

To set up a Globus transfer between the various locations:

* Install Globus Connect on your local machine (Harmattan) and on the respective clusters (Columbia HPC, TAMU ACES).
* Follow Globus' official guide to link your local machine and HPC systems via Globus Transfer: [Globus Transfer Setup Guide](https://www.globus.org/globus-connect)
* Ensure that you have the correct permissions for each account and destination path.

### 2. Columbia HPC Account (process should be same for your institution HPC account)



### 3. Running BNE on the Insomnia Cluster of Columbia HPC

The `parallel_run_BNE.sh` script allows you to submit jobs to the HPC cluster. Here's how to run the BNE model:

1. Clone this repository to your local machine:

2. Edit the batch script `parallel_run_BNE.sh` to reflect your job parameters (e.g., memory, number of cores).

3. Submit the job to the cluster:

```bash
sbatch parallel_run_BNE.sh
```

4. Monitor the job with the SLURM job scheduler. Check job status using:

```bash
squeue -u yourusername
```

### 4. NSF Access Accelerate Grant Account

To utilize NSF ACCESS-funded HPC clusters, follow these steps:

1. Ensure you have an NSF ACCESS Accelerate grant account. If you do not have one, you can apply for one through the NSF portal: [NSF ACCESS Portal](https://access-ci.org/).
2. Link your NSF Access account to the relevant clusters (e.g., TAMU ACES) by following the official guidelines provided by the NSF and cluster administrators.

### 5. NSF Open Storage Network (OSN) Account and Globus Setup

For large-scale data storage:

1. Apply for an OSN account: [NSF Open Storage Network (OSN) Info](https://access-ci.org/).
2. Once granted access, configure Globus Transfer to facilitate data movement between OSN and your HPC resources.

For more detailed steps on transferring data between the Open Storage Network and your computing cluster, refer to the official [Globus Documentation](https://www.globus.org/documentation).

### 6. Getting Account for TAMU ACES (Texas A\&M Supercomputer)

To get access to TAMU ACES, follow these steps:

1. Apply for an ACES account through ACCESS portal.
2. Once approved, follow the guidelines to configure the TAMU ACES environment.



## Running the Model

### 1. Preprocessing Data with bneR 

Use this article to know about bneR "https://www.sciencedirect.com/science/article/abs/pii/S0301479725000374" and code at "https://github.com/jaime-benavides/bneR"

The preprocessing of the data is done using R via the bneR framework. Ensure that you have R and the necessary libraries installed.

### 2. Prediction with MATLAB

Prediction is done using the MATLAB script `make_predict_1.m`. We need other MATLAB files and functions provided in the "https://github.com/jaime-benavides/bneR/tree/main/code/bne_core".

You can run this script on your HPC system using SLURM:

1. Edit the `parallel_run_BNE.sh` script to adjust the job parameters (e.g., memory, number of cores).
2. Submit the job to the cluster:

```bash
sbatch parallel_run_BNE.sh
```

### 3. Output Data

The output will be generated in the specified folder structure. Data can be downloaded via Globus Transfer or retrieved from the 
