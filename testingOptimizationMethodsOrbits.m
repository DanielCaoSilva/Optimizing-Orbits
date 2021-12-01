clear all;
close all;
clc;

%Daniel Silva 
%Comparing different optimization methods

%Load the Gradient and Distance Function
obj = load("gradientProj.mat");
gradient = obj.gd;
dist = obj.d;
gradFunc = obj.gdFunc;
distFunc = obj.dFunc;
contourObj = load("contGRID.mat");
contourGRID = contourObj.contourGrid;


%Initialize Things
syms t ta tb;
initial_start = [2;2];
x_k = initial_start;

[x_kArm] = SteepestDescentWithArmijo(1,0.01,[2;2],gradFunc,distFunc);

figure;
contourf(contourGRID(:,:,1),contourGRID(:,:,2),contourGRID(:,:,3));
hold on;
plot(x_kArm(1,:),x_kArm(2,:),'-k');
hold off;

figure;
res = 10;
iter = -res:1:res;
resLength = length(iter);
store = [];
for i = iter
    for j = iter
        x_k = SteepestDescentWithArmijo(1,0.01,[i;j],gradFunc,distFunc);
        store = [store ; x_k(1,end),x_k(2,end),distFunc(x_k(1,end),x_k(2,end)),i,j];
        plot(x_k(1,:),x_k(2,:));
        hold on;
    end
end
hold off;

intColors = zeros(100,1);
temp=store(1,1:2);


[C,ia,ic] = unique(store(:,1:2),'rows');
store = [store ic];
cMp = flip(reshape(ic,resLength,resLength)');

figure;
image(cMp,'CDataMapping','scaled');
colorbar()

    


% for i = 1:20
%     %Steepest Descent (Symbolically)
%     g = subs(gradient,[ta;tb],x_k(:,i));
%     phi(:,i) = subs(dist,[ta;tb],x_k(:,i)-t.*g);
%     dir = vpasolve(diff(phi(:,i)==0),t);
%     x_k(:,i+1) = x_k(:,i) - dir.*g;
%     
%     %Steepest Descent (As Anon matlabFucntion w/fminsearch)
% %     gradientAt = feval(gradFunc,x_k(1,i),x_k(2,i));
% %     phi_anon = @(t) distFunc(x_k(1,i)-t.*gradientAt(1,1),x_k(2,i)-t.*gradientAt(2,1));
% %     dir_anon = fminsearch(phi_anon,0);
% %     x_k(:,i+1) = x_k(:,i) - dir_anon.*gradientAt;
%     
%     %Steepest Descent using Armijo's Line search 
%     
%     
%     %Plot Stuff
%     %fprintf('ta_%d = \n',i-1);
%     %disp(x_k(:,i));    
%     figure(1);
%     clf;
%     %labels=cellstr(num2str((0:i)'));
%     contourf(contourGRID(:,:,1),contourGRID(:,:,2),contourGRID(:,:,3));
%     hold on;
%     plot(x_k(1,:),x_k(2,:),'-k');
%     title('Steepest Descent');
%     xlabel('ta1 Axis');
%     ylabel('ta2 Axis');
%     %text(x_k(1,:),x_k(2,:),labels,'VerticalAlignment','bottom',...,
%     %    'HorizontalAlignment','right');
%     grid on;
%     hold on;
%     pause(0.001);
% end

%  plot(x_kArm(1,:),x_kArm(2,:),'-k');
%  hold on; 
%  plot(x_k(1,:),x_k(2,:),'-r');
%  hold off;