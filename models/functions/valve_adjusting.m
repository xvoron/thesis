run params.m

P = polyfit(lookup_n, lookup_q_n, 3);
Y2 = polyval(P, lookup_n);
P = polyfit(lookup_n, lookup_q_n, 4)
Y3 = polyval(P, lookup_n);
figure
hold on
plot(lookup_n, lookup_q_n, '+')
plot(lookup_n, Y2)
plot(lookup_n, Y3)
x = lookup_n;
Y_3_test = p3*x.^3 + p2*x.^2 + p1*x.^1 + p0;
plot(x, Y_3_test);
