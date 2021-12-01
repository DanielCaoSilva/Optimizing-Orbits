clear all;
close all;
clc;

format long
%Daniel Silva 
%The Minimum Distance Between two Orbits 



%Parameters - (A,P,phi) 
o = 11;
param = [10,2, pi/8;  % P/2014 A2 Hill
          4,1,-pi/7;  % P/2021 N1 ZTF
          .47,.31,deg2rad(3.38); % Mercury 
          .728,.718,deg2rad(3.86); % Venus
          1.02,.98,deg2rad(7.155); % Earth
          1.67,1.38,deg2rad(5.65); % Mars
          5.45,4.95,deg2rad(6.09); % Jupiter
          10,9.02,deg2rad(5.51); % Saturn
          20.1,18.3,deg2rad(6.48); % Uranus
          30.3,30,deg2rad(6.43); % Neptune
          49.9,29.7,deg2rad(11.88)]; % Pluto
% param = [5,15-10*sqrt(2), pi/8;
%          2,6-4*sqrt(2), -pi/7];

%Orbits
%t = linspace(0,.1,1000);
t = 0:.001:10;
tlength = length(t);
for i = 1:o
    trigMat(:,:,i) = [cos(param(i,3)),sin(param(i,3));
                     -sin(param(i,3)),cos(param(i,3))];
    pMat(:,:,i) = [(param(i,2)-param(i,1))/2 + (param(i,2)+param(i,1))/2 *cos(t);
                    sqrt(param(i,2)*param(i,1))*sin(t)];
    orbits(:,:,i) = trigMat(:,:,i)*pMat(:,:,i);
end

%Distance
% minDex = [0,0];
% indexj = -11111;
% indexi = -11111;
% temp = 000;
[t1,t2] = meshgrid(t);
% dist = 0.5.*((orbits(1,:,1)-orbits(1,:,2)).^2+(orbits(2,:,1)-orbits(2,:,2)).^2);
% for i = 1:tlength
%     for j = 1:tlength
%         d(j,i) = 0.5.*((orbits(1,i,1)-orbits(1,j,2)).^2+(orbits(2,i,1)-orbits(2,j,2)).^2);
%         if((i==1)&&(j==1))
%             temp = d(j,i);
%         end
%         if(d(j,i) < temp)
%             indexj = j;
%             indexi = i;
%             temp = d(j,i);
%         end
%         if(d(j,i) <= 0.068680989346037)
%             minDex = [minDex; t(i),t(j)];
%         end
%     end
% end

%minVal = [t(indexi),t(indexj),temp]
%minDex


%Plots
%subplot(2,2,1);
%contourf(t1,t2,d);
%subplot(2,2,2);
%mesh(t1,t2,d);
% subplot(1,2,1);
% for i = 1:o
%     scatter(orbits(1,:,i),orbits(2,:,i),'filled');
%     hold on;
% end
% hold off;
% % scatter(orbits(1,:,1),orbits(2,:,1),'filled');
% % hold on;
% % scatter(orbits(1,:,2),orbits(2,:,2),'filled');
% % hold on;
% % scatter(orbits(1,:,3),orbits(2,:,3),'filled');
% % hold off;
% subplot(1,2,2);
for i=1:tlength
    for j = 1:o
        scatter(orbits(1,:,j),orbits(2,:,j),5,'filled');
        hold on;
        plot(orbits(1,i,j),orbits(2,i,j),'or','MarkerSize',5,'MarkerFaceColor','b');
        hold on;
    end
%     scatter(orbits(1,:,1),orbits(2,:,1),5,'filled');
%     hold on;
%     scatter(orbits(1,:,2),orbits(2,:,2),5,'filled');
%     hold on;
%     scatter(orbits(1,:,3),orbits(2,:,3),5,'filled');
%     hold on;
%     plot(orbits(1,i,1),orbits(2,i,1),'or','MarkerSize',5,'MarkerFaceColor','b');
%     hold on;
%     plot(orbits(1,i,2),orbits(2,i,2),'or','MarkerSize',5,'MarkerFaceColor','r');
%     hold on;
%     plot(orbits(1,i,3),orbits(2,i,3),'or','MarkerSize',5,'MarkerFaceColor','g');
    hold off;
    axis([-50 30 -40 50]);
    pause(.001)
end

