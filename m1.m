clear all;
close all;
clc;

syms x1 x2 x3 x4 x5 x6 z

A1 = [4,-4;
     -4,0];

eigenValsA1 = eig(A1);

f1 = 2*x1^2-4*x1*x2-8*x1+3*x2;
H1 = hessian(f1,[x1,x2]);


f1 = 2*x1^2-4*x1*x2-8*x1+3*x2;
H1 = hessian(f1,[x1,x2]);

disp(eigenValsA1);
disp(H1);