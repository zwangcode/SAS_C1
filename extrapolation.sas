proc logistic data=a.tu_ri_approved descending;
model bad = age_oldest_trade dti trade_util wrst_dq_sts_1y num_trade_co_3y;
score data=a.tu_ri_approved out=approved_scored;
score data=a.tu_ri_reject out=reject_scored; run;

%include "/folders/myfolders/KSROC.sas"; 
%ksroc(data=approved_scored,bad=bad,score=p_1,scoretype=phat,weight=1);



/*add weight to approved accounts */
data tu_ri_approved2; set approved_scored; wt=1;
run;
/* add weight to declined accounts */ 
data tu_ri_reject2;
set reject_scored;
wt=p_1; bad=1; output; wt=1-p_1; bad=0; output;
run;
/* merge data */ data tu_ri_all;
set tu_ri_approved2 tu_ri_reject2; run;


proc logistic data=tu_ri_all descending;
model bad = age_oldest_trade dti trade_util
wrst_dq_sts_1y num_trade_co_3y; score data=tu_ri_all out=tu_ri_all_scored;
weight wt; 
run;

%include "/folders/myfolders/KSROC.sas"; 
%ksroc(data=tu_ri_all_scored,bad=bad,score=p_12,scoretype=phat,weight=wt);