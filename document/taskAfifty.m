clc; clear all;
n = 30;             % set dimension
maxV  = 50;         % matrx entries between -50 and 50
randM = (maxV/2)*rand(n) - maxV/2; % creates nxn-matrix
A = randM + randM';                % returns symmetric matrix

D = myEig(A);
d = eig(A);

lam = [];
for i = 1:n
    lam(i) = D(i,i);
end

lam = sort(lam);
d = sort(d);

plot(lam , zeros(1,numel(lam)),'b.')
hold on;
plot(d', 0.5*ones(1,numel(lam)),'r.')
hold off;
ylim([-0.5 1])

set(gca,'YTickLabel',{'eig    ','myEig '},'YTick',[0 0.5]);

matlab2tikz('CPIIeig.tikz', ...
            'height','2cm', ...
            'width' ,'12cm', ...
            'checkForUpdates',1==0);
