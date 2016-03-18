proc logistic data=a.tu_bad;
model bad= num_tot_trade_1y num_trade_co_3y wrst_dq_sts_1y tot_trade_open num_inquiries_1y age_oldest_trade dti;
run;

proc logistic data=a.tu_bad descending;
model bad= num_trade_co_3y wrst_dq_sts_1y age_oldest_trade dti;
run;

proc logistic data=a.tu_bad descending;
model bad= num_trade_co_3y age_oldest_trade dti;
run;