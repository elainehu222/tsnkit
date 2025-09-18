#!/usr/bin/env bash

rm -rf ./out && mkdir ./out

source ./Python-3.13.7/venv/bin/activate

python3 -m tsnkit.tsnkit.test.benchmark --methods ALL --ins 1-256 -t 7200 -o ./results/

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

