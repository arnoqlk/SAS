data my;
input sheep@@;
logx=log(sheep);
difx=dif(logx);
lagx=lag(logx);
year=1867+_n_-1;
cards;
2203  2360  2254  2165  2024  2078  2214  2292  2207  2119  2119  2137
2132  1955  1785  1747  1818  1909  1958  1892  1919  1853  1868  1991
2111  2119  1991  1859  1856  1924  1892  1916  1968  1928  1898  1850
1841  1824  1823  1843  1880  1968  2029  1996  1933  1805  1713  1726
1752  1795  1717  1648  1512  1338  1383  1344  1384  1484  1597  1686
1707  1640  1611  1632  1775  1850  1809  1653  1648  1665  1627  1791
;
proc gplot data=my;
plot sheep*year=1 logx*year=2;
symbol1 i=join v=star c=red;
symbol2 i=join v=star c=red;
run;
proc arima data=my;
identify var=logx nlag=24;
identify var=logx(1) nlag=24;
run;
proc autoreg data=my;
model logx=lagx/nlag=5 lagdep=lagx dwprob archtest;
output out=out p=xp;
run;
proc arima data=my;
identify var=logx nlag=24 minic p=(0:5) q=(0:5); 
estimate p=(1,2)(1);
forecast lead=7 id=year out=forecast;
run;
proc gplot data=forecast;
plot logx*year=2 FORECAST*year=3/overlay;
symbol2 v=star i=none c=black;
symbol3 v=none i=join c=red w=2;
run;