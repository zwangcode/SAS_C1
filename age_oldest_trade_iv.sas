proc sql;
	create table iv as
	select "age_oldest_trade"as tablevar,
	sum(pre_iv) as iv from woe
	; 
quit;