#Data Challenge

This app contains the solution to the following problem:
Given a set S of pairs of usernames corresponding to first degree relationships in a social network, write a program to output each user’s i-th degree friends, for every positive i less than or equal to N, for some fixed N. A successful solution can be scaled to very large S, using parallel and distributed computing techniques.


Implementation:
I use Apache Pig, a Map-Reduce high-level dataflow scripting language, within a Bash wrapper script.



Running the program:
The program is currently set to run locally on a single machine. The machine must have Pig installed. On Mac OS X, Pig can be installed using the homebrew package management system, with the following command: `brew install pig`.
For other operating systems, Cloudera provides an installation guide at http://www.cloudera.com/content/cloudera/en/documentation/cdh4/v4-2-2/CDH4-Installation-Guide/cdh4ig_topic_16_2.html .


All other dependencies are included in this directory.

The program can be run through the following command: `bash nth_degree.sh`

Files:
* names.tsv -- A list of tab-separated names. This can be replaced by the names
that will be processed.
* nth_degree.sh -- The main program file. The number of degrees i to be traversed can be
set using the N_DEGREE variable.
* solution_file_n/part-r-00000 -- The final solutions file for the nth degree calculation, where N was set using the N_DEGREE variable.
* grouped_data_n -- Intermediary files generated in the solution generation process.
