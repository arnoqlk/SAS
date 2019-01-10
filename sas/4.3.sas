data a;
input x;
difx=dif(x);
dif12x=dif12(dif(x));
t=intnx('month','01jan1973'd,_n_-1);
format t monyy.;
cards;
9007
8106
8928
9137
10017
10826
11317
10744
9713
9938
9161
8927
7750
6981
8038
8422
8714
9512
10120
9823
8743
9129
8710
8680
8162
7306
8124
7870
9387
9556
10093
9620
8285
8433
8160
8034
7717
7461
7776
7925
8634
8945
10078
9179
8037
8488
7874
8647
7792
6957
7726
8106
8890
9299
10625
9302
8314
8850
8265
8796
7836
6892
7791
8129
9115
9434
10484
9827
9110
9070
8633
9240
;
/*proc gplot data=a;
plot x*t dif12x*t;
symbol c=red v=star i=join;
run;*/
proc arima data=a;
identify var=x(1) minic p=(0:5) q=(0:5);
estimate q=1 p=(1)(12) noint;
forecast lead=5 id=t out=out;
run;
proc gplot data=out;
plot x*t=1 forecast*t=2 l95*t=3 u95*t=3/overlay;
symbol1 c=black i=join v=star;
symbol2 c=red i=join v=star;
symbol3 c=blue i=join v=star;
run;