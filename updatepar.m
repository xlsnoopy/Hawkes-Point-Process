%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function to estimate parameters from branching probabilities

function [K0, w, mu, sigma]=updatepar(data,p)

N=sum(sum(p));
sumP=0;

t = data(:,3);
x = data(:,1);
y = data(:,2);
w=0;
sigma=0;
mu=0;
for i=1:size(t,1)
    for j= 1:(i-1)
        % parameters are determined by weighted sample mean
        % of inter-point times and square distances
        d = (x(i)-x(j))^2 + (y(i)-y(j))^2;
        
        if d >= 1e-6
            w=w+p(i,j)*(t(i)-t(j));
            sumP=sumP+p(i,j);
            sigma=sigma+p(i,j)*d;
        end
    end
    mu = mu + p(i,i);
    
end

K0=sumP/N;
w=sumP/w;
sigma=(sigma/(2*sumP))^.5;
end