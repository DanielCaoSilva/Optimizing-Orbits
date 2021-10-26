clear all;
close all;
clc;

%Daniel Silva 
%Comparing different optimization methods

%Load the Gradient and Distance Function
obj = load("gradient.mat");
gradient = obj.gd;
dist = obj.d;
gradFunc = obj.gradFunc;
distFunc = obj.distFunc;
contourObj = load("contGRID.mat");
contourGRID = contourObj.contourGrid;


%Initialize Things
syms t ta tb;
initial_start = [3;3];
x_k = initial_start;

for i = 1:100
    %Steepest Descent (Symbolically)
%     g = subs(gradient,[ta;tb],x_k(:,i));
%     phi(:,i) = subs(dist,[ta;tb],x_k(:,i)-t.*g);
%     dir = vpasolve(diff(phi(:,i)==0),t);
%     x_k(:,i+1) = x_k(:,i) - dir.*g;
    
    %Steepest Descent (As Anon matlabFucntion w/fminsearch)
    gradientAt = feval(gradFunc,x_k(1,i),x_k(2,i));
    phi_anon = @(t) distFunc(x_k(1,i)-t.*gradientAt(1,1),x_k(2,i)-t.*gradientAt(2,1));
    dir_anon = fminsearch(phi_anon,0);
    x_k(:,i+1) = x_k(:,i) - dir_anon.*gradientAt;
    
    %Plot Stuff
    fprintf('ta_%d = \n',i-1);
    disp(x_k(:,i));    
    figure(1);
    clf;
    %labels=cellstr(num2str((0:i)'));
    contourf(contourGRID(:,:,1),contourGRID(:,:,2),contourGRID(:,:,3));
    hold on;
    plot(x_k(1,:),x_k(2,:),'-.');
    title('Steepest Descent');
    xlabel('ta1 Axis');
    ylabel('ta2 Axis');
    %text(x_k(1,:),x_k(2,:),labels,'VerticalAlignment','bottom',...,
    %    'HorizontalAlignment','right');
    grid on;
    hold on;
    pause(0.001);
end


