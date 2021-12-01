function [x_k]= SteepestDescentWithArmijo(lambda_bar,epsil,startingPoint,g,d)

%lambda_bar = 1;
%epsil = .01;
x_k = startingPoint;
k = 1;
check = 0;
%subs(g,[ta;tb],x_k)
%norm(subs(g,[ta;tb],x_k(:,k)))
%while(norm(subs(g,[ta;tb],x_k(:,k)))>=epsil)
while(norm(eval(g,x_k,k))>=epsil)
%for(i = 1:10000)
    d_k = -1*eval(g,x_k,k);
    %d_k = -1*sub(g,x_k(:,k));
    if(d_k == 0)
        break;
    end
    t = 1;
    bool = 1;
    while(bool)
        lbt = lambda_bar/(2.^t);
        in = x_k(:,k) + lbt*d_k;
        %L = double(sub(d,in));
        L = feval(d,in(1),in(2));
        %U = double(sub(d,x_k(:,k)) + lbt * epsil * sub(g,x_k(:,k)));
        U = eval(d,x_k,k)+lbt*epsil*eval(g,x_k,k);
        check = check + 1;
        if(L<=U)
            bool = 0;
            t = t - 1;
            
        end
        t = t+1;
    end
    %disp(x_k(:,k));
    %disp(double(norm(subs(g,[ta;tb],x_k(:,k)))));
    lambda_k = lbt;
    x_k(:,k+1) = x_k(:,k)+lambda_k*d_k;
    k = k + 1;
end

distVal = d(x_k(1,end),x_k(2,end));



function r = eval(f,x_k,k)
    r = f(x_k(1,k),x_k(2,k));
end

end