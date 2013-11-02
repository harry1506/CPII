clear all; clc
global flop;
maxn = 50;
randomA = 50*rand(maxn);
randomA = randomA + randomA';

flo = zeros(maxn,1);
for n = 1: maxn
    flop = 0;             % reset global flop counter
    A = randomA(1:n,1:n); % get symmetric nxn-matrix
    [D, V ,iterDone] = myEig(A);
    flo(n) = flop./iterDone;
end

% plot flops per iteration over n
figure(4);
loglog(1:maxn,flo,'x-')
xlabel('size N of NxN-matrix ')
ylabel('flops per iteration')
%%
%model:  flops / Iteration = c * N^(gamma)
int = (10:maxn)';   % N-Intervall to calculate exponent gamma
p = polyfit(log(int),log(flo(int)),1);
gamma = p(1);
title(sprintf('Exponent $\\gamma = %.2f$',gamma))

%% erstelle die Grafik
matlab2tikz('flopsIter.tikz', ...
            'height','4cm', ...
            'width' ,'8cm', ...
            'parseStrings', 1==0,...
            'parseStringsAsMath', 1==0,...
            'checkForUpdates',1==0);
        
%%
x = 1:maxn;
a = flo(x)'./x.^3;
plot(a,'x-')