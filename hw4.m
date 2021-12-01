clear all;
close all;
clc;


f = @(x1,x2) x1.^2 + 2.*x2.^2;

g = @(y1,y2) y1+y2-2==0;

fmesh(f,[-2 2 -2 2]);
hold on;
fmesh(g,[-2 2 -2 2]);

