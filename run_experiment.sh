#!/usr/bin/env bash

export PATH=$PATH:/opt/ibm/ILOG/CPLEX_Studio2211/cpoptimizer/bin/x86-64_linux
export GRB_LICENSE_FILE="/opt/gurobi1203/gurobi.lic"

rm -rf ./out && mkdir ./out

source /home/cc/Python-3.13.7/venv/bin/activate

nohup python3 -m tsnkit.tsnkit.test.benchmark --methods ALL --ins 1-256 -t 7200 -o ./results/

# This file is loaded automatically onto nodes
source ~/openrc

today=$(date '+%Y-%m-%d')
bucket_name="tsnkit-benchmark_$today"

echo
echo "Uploading results to the object store container $bucket_name"
# Create the bucket if it doesn't exist
swift post $bucket_name

for file in ./results/*; do
	echo "Uploading $file"
	swift upload $bucket_name $file --object-name $(basename $file)
done

