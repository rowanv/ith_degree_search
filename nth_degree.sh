#!/bin/bash -v

set -e #exits immediate;y if a command exits with a non-zero status
set -o pipefail #echoes all commands before executing
set -x #increases verbosity

#Delete all of the old files
rm -r -f data/ || true
rm -r -f data_dup/ || true
rm -r -f grouped_data* || true
rm -r -f solution_file_*/ || true
rm merged_data_from_grouping_round || true


#Load in data
pig -x local load_data.pig

#Calculate the 2nd-degree connections
pig -x local -p output_file="grouped_data_2" group_data.pig 

#Define the N-degree connections 
NDEGREE=4

#Calculate the N-Degree connections if the degree >= 3
if [ "$NDEGREE"  -ge 3 ]
then

	for i in `seq 3 $NDEGREE`;
	do
		echo "Beginning grouping round"
		echo $i
		pig -x local -p data_to_be_joined="grouped_data_$((i-1))" -p output_file="grouped_data_$i" group_data.pig 
	done
fi

#Concatenate the final answers
cat grouped_data*/* names.tsv > merged_data_from_grouping_round

#Produce lengthwise format
pig -x local -p input="merged_data_from_grouping_round" -p output="solution_file_$NDEGREE" lengthwise_reformatting.pig