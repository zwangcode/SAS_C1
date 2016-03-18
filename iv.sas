proc sql;
	create table iv as
	select "DTI"as tablevar,
	sum(pre_iv) as iv from woe
	; 
quit;