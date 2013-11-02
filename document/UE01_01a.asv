clc; clear all;
global flop;
flop = 0;  % flop counter

n = 7;
maxV = 50;

randSym = (maxV/2)*rand(n) - maxV/2; % creates nxn-matrix
randSym = randSym + randSym';        % create symmetric matrix

Simple = diag(1:n);
Simple(1,n) = 2;
Simple = Simple + Simple'; % create symmetric matrix

%%
clc
%A = Simple;
A = randSym;

Aneu = zeros(size(A));

V = eye(size(A)); % V = P12 P12 P13 ... ;

Iterationszahl=1;  % number of iteration over whole matrix

flo = zeros(Iterationszahl,1); 
D = A; 
for l=1:Iterationszahl%Iterationsschleife

    if ~(mod(l,1000))
        fprintf('Iter = %d \n',l);
    end

    for q=2:n
       for p=1:q-1
        [D, P] = doPpq(D,p,q);
             V = V*P;
       end % p

    end %q
    flo(l) = flop;
end %l

A,D % Ausgabe
lam = [];
for i = 1:n
    lam(i) = D(i,i);
end


lam = sort(lam);
Aeig = sort(eig(A));

% grafische Darstellung der Eigenwerte (oben von eig())
plot([lam ; Aeig'],diag([0 0.5])*ones(2,numel(lam)),'.')
ylim([-2 2])

disp([lam ; Aeig']);

% Test ob V orthogonal ist: V'*V == eye

V'*V
figure(3)
plot(diff(flo),'x'); 
title('Flops pro Iteration');

%% Abhängigkeit von der Dimension n
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
xlabel('size of nxn-matrix ')
ylabel('flops per iteration')

%model:  flops / Iteration = c * N^(gamma)
int = (10:maxn)';   % N-Intervall to calculate exponent gamma
p = polyfit(log(int),log(flo(int)),1);
gamma = p(1);
title(sprintf('Anstieg: %.2f',gamma))
