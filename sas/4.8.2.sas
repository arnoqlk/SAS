data a;
input x@@;
difx=dif(x);
dif3x=dif3(difx);
t=_n_-1+1949;
cards;
5589	53120	151489
9983	68132	150681
11083	76471	152893
13217	80873	157627
16131	83111	162794
19288	78772	163216
19376	88955	165982
24605	84066	171024
27421	95309	172149
38109	110119	164309
54410	111893	167554
67219	111279	178581
44988	107673	193189
35261	113495	204956
36418	118784	224248
41786	124074	249017
49100	130709	269296
54951	135635	288224
43089	140653	314237
42095	144948	330354
;
proc gplot;
plot dif3x*t;
symbol v=star c=red i=join;
run;
proc arima;
identify var=dif3x minic p=(0:5) q=(0:5);
estimate p=2 noint;
forecast lead=5 id=t out=out;
proc gplot data=out;
plot dif3x*t=1 forecast*t=2 l95*t=3 u95*t=3/overlay;
symbol1 c=black i=none i=join;
symbol2 c=red i=join v=none;
symbol3 c=green i=join v=none;
run;