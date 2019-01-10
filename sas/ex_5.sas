*习题5;
data example5;
input sales@@;
time=intnx('month','1jan2000'd, _n_-1);
format time monyy5.;
cards;
153 187 234 212 300 221 201 175 123 104 85 78
134 175	243	227	298	256	237	165	124	106	87 74
145 203 189 214 295 220 231 174 119 85 67 75
117 178 149 178 248 202 162 135 120 96 90 63
;
*打印数据;
proc print data=example5;
*绘制时序图;
proc gplot data=example5;
plot sales*time=1;
symbol1 c=red v=star i=spline;
*计算arima;
proc arima data=example5;
identify var=sales;
run;