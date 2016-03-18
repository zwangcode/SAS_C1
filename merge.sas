proc sql;
	create table merged as 
	select a.cluster, a.variable,b.iv, a.rsquareratio
	from r2 (where=(numberofclusters=5)) a 
	left join 
	ivall b
	on a.variable=b.tablevar
	; 
quit;