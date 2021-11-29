clear all;
close all;
clc;


syms x a b
f = exp(-a*x^b);

d2 = diff(f,2)

bequalTO1 = subs(d2,b,1)

ezplot(bequalTO1);

