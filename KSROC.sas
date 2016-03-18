/* scoretype should be either "score" or "phat" */

%macro ksroc(data=,bad=,score=,scoretype=,weight=);

%if &scoretype=phat %then %do; 
	%let sortby=descending;
%end;
%else %do;
	%let sortby=;
%end;

proc sql noprint;
select	sum(&weight.*(&bad.=0)), sum(&weight.*(&bad.=1)), sum(&weight.)
into: tot_good, :tot_bad, :tot
from &data.
; quit;

proc sort data=&data.;
by &sortby. &score.;
run;

data ks_&score.;
set &data. end=last;
by &sortby. &score.;
retain cum_good 0 cum_bad 0 cum_pct 0 roc 0;
cum_good+&weight.*(1-&bad.); cum_bad+&weight.*&bad.; cum_pct+&weight./&tot.;
cum_good_pct=cum_good/&tot_good.;
cum_bad_pct=cum_bad/&tot_bad.;
cum_good_pct_lag=lag(cum_good_pct);
cum_bad_pct_lag=lag(cum_bad_pct);
if cum_good_pct_lag=. then cum_good_pct_lag=0;
if cum_bad_pct_lag=. then cum_bad_pct_lag=0;
roc_inc=(cum_bad_pct+cum_bad_pct_lag)*(cum_good_pct-cum_good_pct_lag)/2;
roc+roc_inc;

if last then do;
call symput ("ROC",Roc*100);
end;
run;

proc sql;
create table ksfinal_&score. as
select
	max(abs(cum_bad_pct-cum_good_pct)) as max_abs_ks,
	&ROC as AUC,
	2*(&ROC/100-0.5) as somers_d
from ks_&score.
; quit;

%mend;


%macro decile(data=,score=,scoretype=);

%if &scoretype=phat %then %do; 
	%let sortby=descending;
%end;
%else %do;
	%let sortby=;
%end;

proc sql noprint;
select	sum(&weight.*(&bad.=0)), sum(&weight.*(&bad.=1)), sum(&weight.)
into: tot_good, :tot_bad, :tot, :bad_rt
from &data.
; quit;

proc sort data=&data. out=decile0;
by &sortby. &score.;
run;

data decile1; set decile0;
by &sortby. &score.;
retain cum_good 0 cum_bad 0 cum_pct 0;
cum_good+&weight.*(1-&bad.); cum_bad+&weight.*&bad.; cum_pct+&weight./&tot.;
cum_bad_pct=cum_bad/&tot_bad.;
bad_rt=cum_bad/(cum_good+cum_bad);
gof=bad_rt/&bad_rt.;
if mod(_N_,100)=0;
run;

%mend;