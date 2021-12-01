clear all;
close all;
clc;

format long

%number of constraints
numG = 4;
%number of variables 
numVar = 2;
%NLP
 f = @(x1,x2) x1.^4 + x2.^4 + 12*x1.^2 + 6*x2.^2 -x1.*x2 -x1-x2;
 g.c1 = @(x1,x2) -x1 - x2 +6;
 g.c2 = @(x1,x2) -2*x1 +x2 +3;
 g.c3 = @(x1,x2) -x1;
 g.c4 = @(x1,x2) -x2;

%f = @(x1,x2) x1.^2 + 2*x2.^2;
%f = @(x1,x2) x1.^3 + x2.^3;
%g.c1 = @(x1,x2) -x1 - x2 +2;
%g.c2 = @(x1,x2) -2*x1 +x2 +3;

global x1 x2 u1 u2 u3 u4 s1 s2 s3 s4
syms x1 x2 u1 u2 u3 u4 s1 s2 s3 s4
% x0 = [0,0,0];
x0 = zeros(1,9);
 L = @(x1,x2,u1,u2,u3,u4,s1,s2,s3,s4) f(x1,x2) + ...
     u1.*(g.c1(x1,x2) + s1) +...
     u2.*(g.c2(x1,x2) + s2) +...
     u3.*(g.c3(x1,x2) + s3) +...
     u4.*(g.c4(x1,x2) + s4);
%L = @(x1,x2,u1,s1) f(x1,x2) + u1.*(g.c1(x1,x2) + s1);

Lsym = sym(L);
stationarity = [diff(Lsym,x1);
                diff(Lsym,x2);
                diff(Lsym,u1);
                diff(Lsym,u2);
                diff(Lsym,u3);
                diff(Lsym,u4)];
                %diff(Lsym,s1);
                %diff(Lsym,s2)];
                

choice = [s1,s2,s3,s4,u1,u2,u3,u4];
%choice = [s1,u1];
%choice = [s1,s1];
c = zeros(9,9,24);
%c = zeros(3,1,4);
for i = 1:24
    %kktSys{i} = subForZero(stationarity,[choice(1),choice(2),choice(3),choice(4)],4);
    kktSys{i} = subForZero(stationarity,[choice(1)],1);
    temp = (struct2array(vpasolve(kktSys{i},x0)));
    sz1 = size(temp,1);
    sz2 = size(temp,2);
    if(sz1 ==  0)
        c(:,:,i) = zeros(9,1);
    else
        c(1:sz1,1:sz2,i) = temp;
    end
    cases(i,:) = [choice(1), choice(2)];
    choice = circshift(choice,1);
end
                
c
disp(cases);
%disp(kktSys{1,3})
function result = subForZero(dL,makeZero,n)
    result = subs(dL,makeZero,zeros(1,n));
end




