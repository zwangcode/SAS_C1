proc sql;
	create table inq as
	select num_inquiries_3m, sum(bad)/count(*) as bad_rate,bad
	from a.tu_bad
	group by num_inquiries_3m;
	;
quit;