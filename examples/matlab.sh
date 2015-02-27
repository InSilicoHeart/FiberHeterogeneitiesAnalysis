#!/bin/sh
#
# Filename: matlab.sh
#
# ./matlab.sh "simplesleep(10,2,'output.txt')"
#

# run matlab in text mode
exec matlab -nodisplay -nosplash -r "$*"
