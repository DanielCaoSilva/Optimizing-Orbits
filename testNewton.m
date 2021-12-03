clear all;
close all;
clc;

%Daniel Silva 
%Comparing Newton and Steepest Descent

%Load the Gradient, Distance and Hessian Functions
obj = load("gradientProj.mat");
gradient = obj.gd;
dist = obj.d;
hessian = obj.h;
gradFunc = obj.gdFunc;
distFunc = obj.dFunc;
hessFunc = obj.hFunc;
contourObj = load("contGRID.mat");
contourGRID = contourObj.contourGrid;

k = 1;
iter = .1:.1:10;
T_sd(k) = length(iter);
for i = iter
    tStart = tic;
    x_k = SteepestDescentWithArmijo(i,0.001,[-.5;-1.5],gradFunc,distFunc);
    T_sd(k) = toc(tStart);
    k = k+1;
end


plot(iter,T_sd,'-r');
title("Starting close to min (5,-1)");
xlabel("lambda bar");
ylabel("Time to converge");

