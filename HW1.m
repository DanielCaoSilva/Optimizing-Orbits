clear all;
close all;
clc;

%Daniel Silva 
%Mat 5800 - Programming 

%Problem 1 
x = -5:0.1:5;
y = (-1/4)*x.^2 + 1;
figure;
ineqplot('x > -3/2',[-5 5], 'b');
hold on;
ineqplot('4*x.^2 + 9*y.^2 <= 36',[-5 5], 'r');
hold on;
plot(x,y);
hold on;
x0 = 4; y0 = 2;
for r = 2:.1:3
    ezplot(@(x,y) (x-x0).^2+(y-y0).^2 -r^2)
    hold on;
end
title("NLP Problem 1.1");


