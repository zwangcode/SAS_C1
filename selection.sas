%let varlist = active_bk age_oldest_trade dti num_inquiries_1y num_inquiries_3m num_inquiries_6m num_tot_trade_1y num_trade_auto_1y num_trade_card_1y
num_trade_co_3y num_trade_mtg_1y tot_trade_limit tot_trade_open trade_util
wrst_dq_sts_1y wrst_dq_sts_3m; 

proc logistic data=a.tu_bad descending;
model bad = &varlist / selection=forward sle=0.05 details; run;

proc logistic data=a.tu_bad descending;
model bad = &varlist / selection=backward sls=0.05; run;

proc logistic data=a.tu_bad descending;
model bad =num_trade_co_3y age_oldest_trade dti wrst_dq_sts_3m; run;

proc logistic data=a.tu_bad descending;
model bad = &varlist / selection=stepwise sle=0.05 sls=0.05 details; run;

proc logistic data=a.tu_bad descending;
model bad =num_trade_co_3y age_oldest_trade dti; run;
