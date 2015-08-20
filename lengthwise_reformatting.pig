%default input 'input';
%default output 'output';

data = load '$input' using PigStorage('\t') as (name_1, name_2) ;

data_reverse_connections = foreach data generate name_2 as name_1, name_1 as name_2;
data = union data, data_reverse_connections;
data = distinct data;


grouped_names = group data by name_1;

/*lengthwise_data = foreach grouped_names generate group, data.name_2;*/
lengthwise_data = foreach grouped_names {
	sorted = order data by name_2;
	generate group, sorted;
}
lengthwise_data = foreach lengthwise_data generate group, sorted.name_2;
/*lengthwise_data = order lengthwise_data by group;*/


store lengthwise_data into '$output';

