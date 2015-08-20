%default data_to_be_joined 'data';
%default output_file 'output_file';


data = load '$data_to_be_joined' using PigStorage('\t') as (name_1, name_2) ;
original_data_set = load 'data' using PigStorage('\t') as (name_1, name_2);


/* Each connection is a two-way connection, so including the reverse of the input list */
data_reverse_connections = foreach data generate name_2 as name_1, name_1 as name_2;
data = union data, data_reverse_connections;


grouped = group data by name_1;
grouped_numbers = foreach grouped generate group as node, data.name_2 as connection;


/* Joining back to the original data set to get all n-degree connections */
joined = join data by name_2, original_data_set by name_1;


joined_remove_duplicates = foreach joined generate data::name_1, data::name_2, original_data_set::name_2;



/* Remove self-connections */

filtered_joined_remove_duplicates = filter joined_remove_duplicates by not data::name_1 == original_data_set::name_2;

/*Then have list of nth-degree connections*/
nth_degree_connections = foreach filtered_joined_remove_duplicates generate data::name_1, original_data_set::name_2;



nth_degree_connections = distinct nth_degree_connections;


store nth_degree_connections into '$output_file';
