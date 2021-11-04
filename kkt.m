clear all;
close all;
clc;

format long

%NLP
f = @(x1,x2) x1.^4 + x2.^4 + 12*x1^2 + 6*x2.^2 -x1.*x2 -x1-x2;
g.c1 = @(x1,x2) -x1 - x2 +6;
g.c2 = @(x1,x2) -2*x1 +x2 +3;

syms x1 x2 u1 u2 s1 s2
L = @(x1,x2,u1,u2,s1,s2) f(x1,x2) + u1.*(g.c1(x1,x2) + s1) + u2.*(g.c2(x1,x2) + s2);
Lsym = sym(L);
stationarity = [diff(Lsym,x1);
                diff(Lsym,x2);
                diff(Lsym,u1);
                diff(Lsym,u2)];
                %diff(Lsym,s1);
                %diff(Lsym,s2)];

kktSys.case1 = matlabFunction(subForZero(stationarity,u1,u2));
kktSys.case2 = matlabFunction(subForZero(stationarity,u1,s2));
kktSys.case3 = matlabFunction(subForZero(stationarity,u2,s1));
kktSys.case4 = matlabFunction(subForZero(stationarity,s1,s2));
% fsolve(kktSys.case1,[0,0,0,0])
% feval(kktSys.case1,0,0,0,0)
            

c = zeros(7,4);
z = zeros(1,4);
feasible = zeros(5,4);

% Starting point
x0 = [0.1; 0.1; 0.1; 0; 0; 0; 0]; % x1, x2, x3, u1, u2, s1, s2
% x0 = [0.1; 0.1; 0; 0]; %x1 x2 u1 u2 s1 s2
options = optimset('Algorithm','levenberg-marquardt');
c(:,1) = fsolve(@kktsystem_u1u2,x0, options) % Case 1
c(:,2) = fsolve(@kktsystem_u1s2,x0, options) % Case 2
c(:,3) = fsolve(@kktsystem_s1u2,x0, options) % Case 3
c(:,4) = fsolve(@kktsystem_s1s2,x0, options) % Case 4

% c(:,1) = fsolve(@kktSys.case1,x0, options) % Case 1
% c(:,2) = fsolve(@kktSys.case2,x0, options) % Case 2
% c(:,3) = fsolve(@kktSys.case3,x0, options) % Case 3
% c(:,4) = fsolve(@kktSys.case4,x0, options) % Case 4

for i = 1:4
    z(i) = (c(1,i)-1)^2 + c(2,i)^2 + (c(3,i)-2)^2; 
    [feasible(:,i),optimal] = checkCon(c(:,i));
end
disp(z);
disp(feasible);
printOptimal(optimal);

function [] = printOptimal(opt)
    fprintf("The optimal solution is: \n");
    for i = 1:length(opt)
        fprintf("x_%i: %f\n",i,opt(i));
    end
end

function [check,opt] = checkCon(vals)
    opt = NaN;
    check1 = 0;
    check2 = 0;
    totCheck = 0;
    check1ans = vals(1)^2 + vals(2)^2 + vals(3)^2;
    check2ans = vals(1)^2 - 4*vals(2);
    if(vals(1)^2 + vals(2)^2 + vals(3)^2 <=4)
        check1 = 1;
    end
    if(vals(1)^2 - 4*vals(2) <= 0)
        check2 = 1;
    end
    if(check1 && check2 == 1)
        totCheck = 1;
        opt = vals(1:3);
    end
    check = [check1ans;check2ans;check1;check2;totCheck];
end

function result = subForZero(dL,makeZero1,makeZero2)
    result = subs(dL,[makeZero1 makeZero2],[0 0]);
end

function F = kktsystem_u1u2(x) %u1 = u2 = 0
F = [2*x(1)-2; 
    2*x(2);
    2*x(3)-4;
    x(1)^2+x(2)^2+x(3)^2-4+x(6)^2; 
    x(1)^2-4*x(2)+x(7)^2];
end
function F = kktsystem_u1s2(x) %u1 = s2 = 0
F = [2*x(1)-2+2*x(1)*x(5); 
    2*x(2)-4*x(5);
    2*x(3)-4;
    x(1)^2+x(2)^2+x(3)^2-4+x(6)^2; 
    x(1)^2-4*x(2)];
end
function F = kktsystem_s1u2(x) %s1 = u2 = 0
F = [2*x(1)-2+2*x(1)*x(4); 
    2*x(2)+2*x(2)*x(4);
    2*x(3)-4+2*x(3)*x(4);
    x(1)^2+x(2)^2+x(3)^2-4; 
    x(1)^2-4*x(2)+x(7)^2];
end
function F = kktsystem_s1s2(x) %s1 = s2 = 0
F = [2*x(1)-2+2*x(1)*x(4)+2*x(1)*x(5); 
    2*x(2)+2*x(2)*x(4)-4*x(5);
    2*x(3)-4+2*x(3)*x(4);
    x(1)^2+x(2)^2+x(3)^2-4; 
    x(1)^2-4*x(2)];
end



