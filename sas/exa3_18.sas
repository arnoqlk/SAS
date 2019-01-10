data exa3_17;
input grain@@;
time = _n_;
cards;
0.97	0.45	1.61	1.26	1.37	1.43	1.32	1.23	0.84	0.89	1.18
1.33	1.21	0.98	0.91	0.61	1.23	0.97	1.10	0.74	0.80	0.81
0.80	0.60	0.59	0.63	0.87	0.36	0.81	0.91	0.77	0.96	0.93
0.95	0.65	0.98	0.70	0.86	1.32	0.88	0.68	0.78	1.25	0.79
1.19	0.69	0.92	0.86	0.86	0.85	0.90	0.54	0.32	1.40	1.14
0.69	0.91	0.68	0.57	0.94	0.35	0.39	0.45	0.99	0.84	0.62
0.85	0.73	0.66	0.76	0.63	0.32	0.17	0.46			
;
* 时序图;
proc gplot data=exa3_17;
plot grain*time=1;
symbol1 c=red i=join v=star;
* arima;
proc arima data=exa3_17;
identify var=grain nlag=12 minic p=(0:5) q=(0:5);
* 由时序图和BIC准则定阶，p=1,并得出拟合方程;
estimate p=1;
* 模型五年预测;
forecast lead=5 id=time out=results;
* 拟合预期图;
proc gplot data=results;
plot grain*time=1 forecast*time=2 l95*time=3 u95*time=3/overlay;
symbol1 c=black i=none v=star;
symbol2 c=red i=join v=none;
symbol3 c=green i=join v=none l=41;
run;