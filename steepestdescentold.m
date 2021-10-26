

syms ta tb t 
%f = 2*(ta.^4)+(tb.^2)-4*ta.*tb+5*tb;    
gd = load("gradient.mat");
gradient = gd.gd;
f = gd.d;
%h=hessian(f,[ta,tb]);
%j=transpose(jacobian(f,[ta,tb]));
j = gradient;
check1=0;
check2=0;
%b=inv(h)*j;
numIter=9;
ta_k(:,1)=[0;0];
for i=1:numIter
    tasub=subs(j,ta,ta_k(1,i));
    jac_at_subtb =subs(tasub,tb,ta_k(2,i));
    ta_fake(:,i)= (ta_k(:,i))-(t*jac_at_subtb);
    disp(ta_fake(:,i));
    phi1 = subs(f,ta,ta_fake(1,i));
    phi_final = subs(phi1,tb,ta_fake(2,i));
    diff_phi = diff(phi_final);
  %  e=[0]==diff_phi;
    %temptb=solve(e,t);
%     if size(temptb,1) > 1
%         t_ans(i)=temptb(2);
%         check1=check1+1;
%     else 
%         t_ans(i)=solve(e,t);
%         check2=check2+1;
%     end
    %t_ans(i)=temptb(1);
    temp=solve(diff_phi,t);
    t_ans(i)=temp(1);
    disp(t_ans(i));
    ta_k(:,i+1) = subs(ta_fake(:,i),t,t_ans(i));
    %ta_k(2,i+1) = subs(ta_fake(2,i),t,t_ans(i));
    fprintf('ta_%d = \n',i-1);
    disp(ta_k(:,i));    
    figure(1);
    clf;
    labels=cellstr(num2str([0:i]'));
    plot(ta_k(1,:),ta_k(2,:),'-o');
    title('Steepest Descent');
    xlabel('ta1 Atais');
    ylabel('ta2 Atais');
    text(ta_k(1,:),ta_k(2,:),labels,'VerticalAlignment','bottom',...,
        'HorizontalAlignment','right');
    hold on;
    %atais([-70 70 -70 70]);
    pause(0.001);
end
