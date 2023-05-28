#!/bin/bash

# Copyright (c) 2023 brainlife.io
#
# This file is a template for a python-based brainlife.io App
# brainlife stages this git repo, writes `config.json` and execute this script.
# this script reads the `config.json` and execute pynets container through singularity
#
# you can run this script(main) without any parameter to test how this App will run outside brainlife
# you will need to copy config.json.brainlife-sample to config.json before running `main` as `main`
# will read all parameters from config.json
#
# Author: Giulia Bertò
# The University of Texas at Austin

cfa=$1
ref=$2

echo "Computing non-linear warp..."
ANTS 3 -m CC[${ref},${cfa},1,5] -t SyN[0.5] \
    -r Gauss[2,0] -o -i 30x90x20 --use-Histogram-Matching

echo "Applying non-linear warp..."
antsApplyTransforms -e 3 \
	    	-i ${cfa} \
	    	-o output/peaks.nii.gz \
	    	-r ${ref} \
	    	-t 1Warp.nii.gz \
	    	-t 1Affine.txt -v 1
