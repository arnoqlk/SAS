data birth;
input br@@;
lagbr=lag(br);
difbr=dif(br);
t=intnx('year','01jan1750'd, _n_-1);
format year monyy7.;
cards;
9 12 8 12 10 10 8 2 0 7 10 9
4 1 7 5 8 9 5 5 6 4 -9 -27 12
10 10 8 8 9 14 7 4 1 1 2 6 7
7 -2 -1 7 12 10 10 4 9 10 9
5 4 3 7 7 6 8 3 4 -5 -14 1
6 3 2 6 1 13 10 10 6 9 10
13 16 14 16 12 8 7 6 9 4
7 12 8 14 11 5 5 5 10 11
11 9 12 13 8 6 10 13 
;
/*proc gplot data=birth;*/
/*plot br*t lagbr*t difbr*t;*/
/*symbol i=join v=star c=red;*/
/*run;*/

/*proc arima data=birth;*/
/*identify var=br;*/
/*identify var=br(1);*/
/*run;*/

/*proc autoreg data=birth;*/
/*model br=t/ nlag=5 dwprob;*/
/*run;*/

/*proc autoreg data=birth;*/
/*model br=lagbr/ lagdep=lagbr nlag=5 dwprob;*/
/*run;*/

proc autoreg data=birth;
model br=lagbr/ lagdep=lagbr garch=(p=1);
output out=out p=p lcl=lcl ucl=ucl cev=cev residual=residual;
run;
data out;
set out;
lcl_residul=-1.96*sqrt(27.47293);
Ucl_residul=1.96*sqrt(27.47293);
Lcl_GARCH=-1.96*sqrt(cev);
Ucl_GARCH=1.96*sqrt(cev);
Lcl_P=P-1.96*sqrt(cev);
Ucl_P=P+1.96*sqrt(cev);
proc gplot data=out;
plot a*t=2  lcl*t=3 ucl*t=3 Lcl_P*t=4 Ucl_P*t=4/overlay;
plot residual*t=2 lcl_residul*t=3 Ucl_residul*t=3 Lcl_GARCH*t=4  Ucl_GARCH*t=4/overlay;
symbol2 c=green i=needle v=none;
symbol3 c=black i=join v=none;
symbol4 c=red i=join v=none ;
run;
