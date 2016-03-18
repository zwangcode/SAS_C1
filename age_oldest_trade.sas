proc sql;
	create table inq2 as
	select age_oldest_trade, sum(bad)/count(*) as bad_rate
	from a.tu_bad
	/*where age_oldest_trade <=10*/
	group by age_oldest_trade;
	/*order by age_oldest_trade;*/
	;
quit;

proc sgplot data=inq2;
vline age_oldest_trade / response=bad_rate; run;