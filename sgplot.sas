proc sgplot data=inq;
vline num_inquiries_3m / response=bad_rate; run;