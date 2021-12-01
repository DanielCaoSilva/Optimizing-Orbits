clear all;
close all;
clc;

syms t t1 t2

%Plotting Orbits

%[A, P, phi]
param1 = [10, 2, pi/8];
param2 = [4, 1, -pi/7];

T1 = [cos(param1(3)), sin(param1(3)) ;
      -sin(param1(3)), cos(param1(3))];
T2 = [cos(param2(3)), sin(param2(3)) ;
      -sin(param2(3)), cos(param2(3))];

P1 = [ (param1(2) - param1(1))/2 + ((param1(2) + param1(1)))/2*cos(t);
       sqrt(param1(2)*param1(1))*sin(t)];
P2 = [ (param2(2) - param2(1))/2 + ((param2(2) + param2(1)))/2*cos(t);
       sqrt(param2(2)*param2(1))*sin(t)];

O1 = T1*P1;
O2 = T2*P2;

%Contour Lines

x1_t1=subs(O1(1), t, t1);
x2_t2=subs(O1(2), t, t2);
y1_t1=subs(O2(1), t, t1);
y2_t2=subs(O2(2), t, t2);

dist = (1/2)*((x1_t1 - x2_t2)^2 + (y1_t1-y2_t2)^2);


G = gradient(dist);

figure;
ezplot(O1(1), O1(2));
hold on;
ezplot(O2(1), O2(2));
hold off;

figure; 
fcontour(dist, [0 10]);

