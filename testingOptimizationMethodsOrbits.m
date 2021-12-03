clear all;
close all;
clc;

%Daniel Silva 
%Comparing different optimization methods

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


%Initialize Things
syms t ta tb;
initial_start = [2;2];
x_k = initial_start;

[x_sd] = SteepestDescentWithArmijo(0.25,0.001,[0;0],gradFunc,distFunc);
%[x_newton] = NewtonsMethodHigherDims(1,0.001,[0;0],gradFunc,hessFunc,distFunc);


mi = 75:125;
figure;
contourf(contourGRID(mi,mi,1),contourGRID(mi,mi,2),contourGRID(mi,mi,3));
hold on;
plot(x_sd(1,:),x_sd(2,:),'-k');
title(["SD starting [0;0] epsil = 0.001 END:" num2str(x_sd(1,end)) num2str(x_sd(2,end)) ]);
% hold on;
% plot(x_newton(1,:),x_newton(2,:),'-r');
hold off;

[x_sd] = SteepestDescentWithArmijo(0.25,0.001,[-2;-1],gradFunc,distFunc);
figure;
contourf(contourGRID(mi,mi,1),contourGRID(mi,mi,2),contourGRID(mi,mi,3));
hold on;
plot(x_sd(1,:),x_sd(2,:),'-k');
title(["SD starting [-2;-1] epsil = 0.001 END:" num2str(x_sd(1,end)) num2str(x_sd(2,end)) ]);
hold off;

figure;
res = 9;
iter = -res:.1:res;
resLength = length(iter);
store = zeros(resLength*resLength,5);
k = 1;
for i = iter
    for j = iter
        x_k = SteepestDescentWithArmijo(1,0.001,[i;j],gradFunc,distFunc);
        %x_n = NewtonsMethodHigherDims(1,0.001,[i;j],gradFunc,hessFunc,distFunc);
        store(k,:) = [x_k(1,end),x_k(2,end),distFunc(x_k(1,end),x_k(2,end)),i,j];%,x_n(1,end),x_n(2,end),distFunc(x_n(1,end),x_n(2,end))];
        %storeN = [storeN ; x_n(1,end),x_n(2,end),distFunc(x_k(1,end),x_k(2,end)),i,j];
        k = k + 1;
        plot(x_k(1,:),x_k(2,:));
        hold on;
    end
end
hold off;



[C,ia,ic] = uniquetol(store(:,1:2),1e-2,'ByRows',true);
%[Cn,ian,icn] = uniquetol(store(:,6:7),1e-2,'ByRows',true);
store = [store ic];
cMp = flip(reshape(ic,resLength,resLength));
%cMpn = flip(reshape(icn,resLength,resLength));

figure;
xP = [-res res];
yp = [res -res];
im = image(xP,yp,cMp,'CDataMapping','scaled');
%colormap prism
%colormap hsv
colormap summer
set(gca,'YDir','normal')
colorbar()


% hold on;
% contour(contourGRID(:,:,1),contourGRID(:,:,2),contourGRID(:,:,3),'k','Fill','off','LineWidth',1);
% hold off;

% figure;
% xP = [-res res];
% im = image(xP,xP,cMpn,'CDataMapping','scaled');
% colormap prism
% colorbar()
%hold on;
%contour(contourGRID(:,:,1),contourGRID(:,:,2),contourGRID(:,:,3),'k','Fill','off','LineWidth',3);
%hold off;



    


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