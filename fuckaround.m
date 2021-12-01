clear all;
close all;
clc;

format long
%Daniel Silva 
%The Minimum Distance Between two Orbits 

%Parameters - (A,P,phi) 
param = [10,2, pi/8;
          4,1,-pi/7;
          2,3, pi/2];
% param = [5,15-10*sqrt(2), pi/8;
%          2,6-4*sqrt(2), -pi/7];

%Orbits
%t = linspace(0,.1,1000);
t = 0:.01:25;
tlength = length(t);
% 
% for i = 1:3
%     trigMat(:,:,i) = [cos(param(i,3)),sin(param(i,3));
%                      -sin(param(i,3)),cos(param(i,3))];
%     pMat(:,:,i) = [(param(i,2)-param(i,1))/2 + (param(i,2)+param(i,1))/2 *cos(t);
%                     sqrt(param(i,2)*param(i,1))*sin(t)];
%     orbits(:,:,i) = trigMat(:,:,i)*pMat(:,:,i);
% end

trigMat(:,:,1) = [1,0,0;
                    0,cos(param(1,3)),sin(param(1,3));
                     0,-sin(param(1,3)),cos(param(1,3))];
trigMat(:,:,2) = [cos(param(2,3)),0,sin(param(2,3));
                    0,1,0;
                     -sin(param(2,3)),0,cos(param(2,3))];
trigMat(:,:,3) = [cos(param(3,3)),sin(param(3,3)),0;
                     -sin(param(3,3)),cos(param(3,3)),0;
                     0,0,1];
                 
newTrigMat = trigMat(:,:,1)*trigMat(:,:,2)*trigMat(:,:,3);
                 
pMat(:,:,1) = [(param(1,2)-param(1,1))/2 + (param(1,2)+param(1,1))/2 *cos(t);
                    sqrt(param(1,2)*param(1,1))*sin(t);
                    -sqrt(param(1,2)*cos(t).^2+param(1,2)*sin(t).^2)];
orbits(:,:,1) = newTrigMat*pMat(:,:,1);


pMat(:,:,2) = [(param(2,2)-param(2,1))/2 + (param(2,2)+param(2,1))/2 *cos(t);
                    sqrt(param(2,2)*param(2,1))*sin(t);
                    -sqrt(param(2,2)*cos(t).^2+param(2,2)*sin(t).^2)];
orbits(:,:,2) = newTrigMat*pMat(:,:,2);


pMat(:,:,3) = [(param(3,2)*exp(-t/5 .* cos(t))).*cos(t.*t);
                    (param(3,2)*exp(-t/5 .* cos(t))).*sin(t.*t);
                    -t];
orbits(:,:,3) = newTrigMat*pMat(:,:,3);


%Distance
% minDex = [0,0];
% indexj = -11111;
% indexi = -11111;
% temp = 000;
% [t1,t2] = meshgrid(t);
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
% 
% minVal = [t(indexi),t(indexj),temp]
%minDex


%Plots
% subplot(2,2,1);
% %contourf(t1,t2,d);
% subplot(2,2,2);
% %mesh(t1,t2,d);
% subplot(2,2,3);
% scatter(orbits(1,:,1),orbits(2,:,1),'filled');
% hold on;
% scatter(orbits(1,:,2),orbits(2,:,2),'filled');
% hold off;
% subplot(2,2,4);
for i=1:tlength
    scatter3(orbits(1,:,1),orbits(2,:,1),orbits(3,:,1),5,'filled');
    hold on;
    scatter3(orbits(1,:,2),orbits(2,:,2),orbits(3,:,2),5,'filled');
    hold on;
    scatter3(orbits(1,:,3),orbits(2,:,3),orbits(3,:,3),5,'filled');
    hold on;
    plot3(orbits(1,i,1),orbits(2,i,1),orbits(3,i,1),'or','MarkerSize',5,'MarkerFaceColor','b');
    hold on;
    plot3(orbits(1,i,2),orbits(2,i,2),orbits(3,i,2),'or','MarkerSize',5,'MarkerFaceColor','r');
    hold on;
    plot3(orbits(1,i,3),orbits(2,i,3),orbits(3,i,3),'or','MarkerSize',5,'MarkerFaceColor','g');
    hold off;
    %axis([-10 5 -4 7]);
    pause(.001)
end

