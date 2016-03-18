%macro test_univ;
	%let var = wrst_dq_sts_3m acq_score num_tot_trade_1y dti trade_util; 
	%do i=1 %to 5;
		%let var&i=%scan(&var,&i); 
		proc means data=sas2.tu noprint;
			var &&var&i;
			output out=distout(drop=_type_ _freq_)
				mean=Mean median=Median min=Min max=Max; 
		run;
		proc append base=summeans data=distout force; 
		run; 
	%end;
%mend; 

%test_univ;