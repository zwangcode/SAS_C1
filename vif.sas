proc reg data=a.tu outest=out1;
model num_trade_co_3y = age_oldest_trade dti / edf; run;

data out2;
set out1 (keep=_rsq_);
format vif 8.2;
if 0<=_rsq_<1 then vif=1/(1-_rsq_); else vif=99999.99;
run;


proc reg data=a.tu outest=out1;
model age_oldest_trade = num_trade_co_3y dti / edf; run;

data out2;
set out1 (keep=_rsq_);
format vif 8.2;
if 0<=_rsq_<1 then vif=1/(1-_rsq_); else vif=99999.99;
run;



proc reg data=a.tu outest=out1;
model num_inquiries_1y = num_inquiries_3m num_inquiries_6m / edf; run;

data out2;
set out1 (keep=_rsq_);
format vif 8.2;
if 0<=_rsq_<1 then vif=1/(1-_rsq_); else vif=99999.99;
run;


proc reg data=a.tu outest=out1;
model wrst_dq_sts_1y = active_bk age_oldest_trade dti num_inquiries_1y num_inquiries_3m num_inquiries_6m num_tot_trade_1y num_trade_auto_1y num_trade_card_1y num_trade_co_3y num_trade_mtg_1y tot_trade_limit tot_trade_open trade_util wrst_dq_sts_3m/edf; run;

data out2;
set out1 (keep=_rsq_);
format vif 8.2;
if 0<=_rsq_<1 then vif=1/(1-_rsq_); else vif=99999.99;
run;
