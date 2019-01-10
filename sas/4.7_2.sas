data a;
input x@@;
difx=dif(x);
lagx=lag(x);
t=intnx('month','1jan1974'd,_n_-1);
format t monyy.;
cards;
1102 	1151 	1093 	1118 	1168 	1118 	1085 	1135 	1138 	1135 	1235 	1301 
1283 	1250 	1210 	1135 	1085 	1060 	1102 	1151 	1127 	1226 	1217 	1215 
1250 	1210 	1268 	1402 	1486 	1534 	1567 	1585 	1717 	2002 	2086 	2059 
1250 	1210 	1268 	1402 	1486 	1534 	1567 	1585 	1717 	2002 	2086 	2059 
2425 	2326 	2176 	2121 	2000 	2000 	1850 	1640 	1700 	1925 	1850 	1830 
1850 	1790 	1700 	1700 	1750 	1775 	1925 	2000 	1975 	1940 	1889 	1881 
2000 	2024 	1900 	1750 	1649 	1601 	1625 	1609 	1649 	1640 	1640 	1620 
1590 	1526 	1451 	1424 	1424 	1329 	1199 	1179 	1285 	1349 	1265 	1299 
1373 	1440 	1451 	1376 	1325 	1261 	1199 	1219 	1250 	1274 	1365 	1424 
1420 	1385 	1321 	1235 	1215 	1310 	1319 	1319 	1279 	1481 	1956 	2165 
2125 	2087 	1895 	1840 	1874 	1863 	1836 	1894 	2105 	2159 	2131 	2029 
2270 	2411 	2652 	3294 	3360 	3686 	3593 	3482 	3615 	3963 	4328 	4309 
4336 	4382 	4326 	4009 	4000 	4070 	4200 	4278 	4435 	4772 	4812 	4908 
4857 	4865 	4711 	4640 	4877 	4902 	4884 	4833 	4903 	4963 	4804 	4679 
4810 	4571 	4250 	3850 	3775 	3357 	2946 	2342 	1994 	2420 	2464 	2763 
2993 	3108 	2729 	2525 	2457 	2136 	2272 	2175 	2100 	2068 	1955 	1950 
1969 	2025 	1726 	1579 	1768 	1766 	1621 	1692 	1634 	1750 	1620 	1515 
1508 	1525 	1502 	1374 	1212 	1198 	1107 	1052 	1069 	1050 	1098 	1150 
1126 	1200 	1193 	1058 	1043 	1026 	980 	976 	1000 	1210 	1264 	1150 
1117 	1188 	1100 	1040 	1028 	1113 	1154 	1350 	1722 	1616 	1525 	1403 
1497 	1522 	1550 	1575 	1538 	1650 	1800 	1933 	2219 	2606 	2563 	2433 
;
proc gplot data=a;
plot x*t difx*t;
symbol v=star c=red i=join;
run;

proc arima data=a;
identify var=x;
identify var=difx;
run;

* 长期相关性;
proc autoreg data=a;
model x=lagx/ lagdep=lagx noint archtest;
run;

proc autoreg data=a;
model x=lagx/ lagdep=lagx nlag=5 archtest backstep method=ml garch=(q=1) noint;
/*model x=t/nlag=2 garch=(q=1) noint;*/
output out=out p=p residual=residual lcl=lcl ucl=ucl cev=cev;
run;
data out;
set out;
lcl_residul=-1.96*sqrt(21237);
Ucl_residul=1.96*sqrt(21237);
Lcl_GARCH=-1.96*sqrt(cev);
Ucl_GARCH=1.96*sqrt(cev);
Lcl_P=p-1.96*sqrt(cev);
Ucl_P=p+1.96*sqrt(cev); 
run;
proc gplot data=out;
plot x*t=5  lcl*t=3 ucl*t=3 Lcl_P*t=4 Ucl_P*t=4/overlay;
plot residual*t=2 lcl_residul*t=3 Ucl_residul*t=3 Lcl_GARCH*t=4  Ucl_GARCH*t=4/overlay;
symbol2 c=green i=needle v=none;
symbol3 c=black i=join v=none;
symbol4 c=red i=join v=none;
symbol5 c=green i=join v=none;
run; 
