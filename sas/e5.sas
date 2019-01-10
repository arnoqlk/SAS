data exam5;
input x@@;
t=intnx('quarter','1jan1978'd,_n_-1);
format t yyq4.;
cards;
40777	41778	43160	45897
41947	44061	44378	47237
43315	43396	44843	46835
42833	43548	44637	47107
42552	43526	45039	47940
43740	45007	46667	49325
44878	46234	47055	50318
46354	47260	48883	52605
48527	50237	51592	55152
50451	52294	54633	58802
53990	55477	57850	61978
;
* x11;
proc x11 data=exam5;
* 季度数据说明;
quarterly date=t;
* 季节调整变量说明;
var x;
* b1 原序列/ d10 季节指数/ d11 季节调整后序列值/ d12 趋势拟合值/ d13 不规则波动值;
output out=out b1=x d10=season d11=adjusted d12=trend d13=irr;
proc gplot data=out;
plot season*t=2 adjusted*t=2 trend*t=2 irr*t=2;
plot x*t=1 adjusted*t=2/overlay;
symbol1 c=black i=join v=star;
symbol2 c=red i=join v=none w=2;
run;
