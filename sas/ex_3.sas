data example3;
input rain@@;
time=intnx('month','1jan1945'd, _n_-1);
format time monyy5.;
cards;
69.3 80.0 40.9 74.9	84.6 101.1 225.0 95.3 100.6	48.3 144.5 128.3
38.4 52.3 68.6 37.1	148.6 218.7 131.6 112.8	81.8 31.0 47.5 70.1
96.8 61.5 55.6 171.7 220.5 119.4 63.2 181.6	73.9 64.8 166.9	48.0
137.7 80.5 105.2 89.9 174.8	124.0 86.4 136.9 31.5 35.3 112.3 143.0
160.8 97.0 80.5	62.5 158.2 27.6 165.9 106.7 92.2	63.2 26.2 77.0
52.3 105.4 144.3 49.5 116.1	54.1 148.6 159.3 85.3 67.3 112.8 59.4
;
*��ӡ����;
proc print data=example3;
*����ʱ��ͼ;
proc gplot data=example3;
plot rain*time=1;
symbol1 c=red v=star i=join;
*����arima;
proc arima data=example3;
identify var=rain nlag=24;
run;
