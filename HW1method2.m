clear all;
close all;
clc;

x1 = linspace(-50,50);
x2 = linspace(-50,50);

y1 = 4*x1.^2 + 9*x2.^2;
y2 = x1.^2 + 4*x2;

Li = y1 >= y2;

figure;
plot(x1,y1, x2,y2);
hold on;
patch([x1(Li) fliplr(x1(Li))], [y1(Li) fliplr(y2(Li))], 'r')
hold off
grid