#!/bin/bash

# ipyrad testing on simulated data
# adapted from this tutorial: http://ipyrad.readthedocs.io/tutorial_intro_cli.html

# test ipyrad install
ipyrad -v

# set up project directory
mkdir pyrad_project
cd pyrad_project

# download data files
wget https://github.com/dereneaton/ipyrad/raw/master/tests/ipsimdata.tar.gz

# expand data files 
# ipsimdata/ contains multiple data files, we'll only use some of them
tar -xvzf ipsimdata.tar.gz

# inspect data
cd ipsimdata
zcat rad_example_R1_.fastq.gz | head # use gzcat instead on Mac
cd ..

# create parameter file (iptest represents the name of the project)
ipyrad -n iptest

# add data files (relative to where being run)
# this can also be accomplished by opening the parameter file in nano,
# then editing the relevant lines as follows: 
# ./ipsimdata/rad_example_R1_.fastq.gz         ## [2] [raw_fastq_path]
# ./ipsimdata/rad_example_barcodes.txt         ## [3] [barcodes_path]
sed -i '/## \[2\]/c\.\/ipsimdata\/rad_example_R1_\.fastq\.gz                    ## [2] [raw_fastq_path]: Location of raw non-demultiplexed fastq files' params-iptest.txt
sed -i '/## \[3\]/c\.\/ipsimdata\/rad_example_barcodes\.txt                     ## [3] [barcodes_path]: Location of barcodes file' params-iptest.txt

# demultiplex files
ipyrad -p params-iptest.txt -s 1
# list output files
ls iptest_fastqs
# fetch informative results
ipyrad -p params-iptest.txt -r

# filter reads
ipyrad -p params-iptest.txt -s 2
# view output
ls iptest_edits/
# get current stats
ipyrad -p params-iptest.txt -r

# cluster reads
ipyrad -p params-iptest.txt -s 3
# show assembly stats
ipyrad -p params-iptest.txt -r

# estimate error rate and heterozygosity
ipyrad -p params-iptest.txt -s 4
# summary stats
ipyrad -p params-iptest.txt -r

# perform consensus base calling 
ipyrad -p params-iptest.txt -s 5
# show results
ipyrad -p params-iptest.txt -r

# cluster across samples
ipyrad -p params-iptest.txt -s 6

# filter and write output files
ipyrad -p params-iptest.txt -s 7
# final output files in iptest_outfiles

# alternatively, run everything at once
#ipyrad -p params-iptest.txt -1234567

