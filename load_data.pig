data = load 'names.tsv' using PigStorage('\t') as (name_1, name_2) ;
 
/* Each connection can go both ways */
data_reverse_connections = foreach data generate name_2 as name_1, name_1 as name_2;
data = union data, data_reverse_connections;

store data into 'data';
