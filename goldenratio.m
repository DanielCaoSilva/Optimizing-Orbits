clear all;
close all;
clc;

n = 300;
for i=1:n
    x=25/i*cos(i);
    y=25/i*sin(i);
    scatter(x,y)
    hold on
    axis([-2 2 -2 2])
    pause(.001)
end