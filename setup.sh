#!/usr/bin/env bash

echo "Setting up experimental environment"

set -x

export PATH=$PATH:/opt/ibm/ILOG/CPLEX_Studio2211/cpoptimizer/bin/x86-64_linux
export GRB_LICENSE_FILE="/opt/gurobi1203/gurobi.lic"
