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

T_Newton = [];
T_SD = [];
Newton_it = [];
SD_it = [];
k = 1;
itval = 3;
for i = -itval:1:itval
    for j = -itval:1:itval
        tNewton = tic;
        [x_newton] = NewtonsMethodHigherDims(1,0.001,[i;j],gradFunc,hessFunc,distFunc);
        T_Newton = [T_Newton, toc(tNewton)];
        Newton_it = [Newton_it,length(x_newton)];
        
        tSD = tic;
        [x_sd] =  SteepestDescentWithArmijo(1,0.001,[i;j],gradFunc,distFunc);
        T_SD = [T_SD, toc(tSD)];
        SD_it = [SD_it, length(x_sd)];
        
        k = k+1;
    end
end


figure;
plot(T_Newton,'r');
hold on;
plot(T_SD,'b');
title("CPU Time");
xlabel("Iterations");
ylabel("Time");
hold off;

figure;
plot(Newton_it,'r');
hold on;
plot(SD_it,'b');
title("Iterations to Convergence");
xlabel("");
ylabel("Number of Iterations till convergence");
hold off;
    