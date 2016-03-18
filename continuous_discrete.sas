data dtidata; 
set a.tu_bad;
format dti2 $15.;
if dti<=0.6 then dti2='1_0-0.6';
	else if dti<=0.8 then dti2='2_0.6-0.8'; 
	else if dti<=1.0 then dti2='3_0.8-1.0'; 
	else dti2='4_over 1.0';
run;

proc sql;
	create table inq3 as
	select dti2, sum(bad)/count(*) as bad_rate
	from dtidata
	group by dti2;
	;
quit;

proc sgplot data=inq3;
vline dti2 / response=bad_rate; run;