function [ Aneu , P ] = doPpq( A, p, q )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

global flop; 
if (exist('flop','var')== 0)
    flop = 0;
    fprintf('set global flop = 0');
end

if ~(p<q),
    error('p muss kleiner q sein!');
end

theta = (A(q,q)- A(p,p))./(2*A(p,q));
flop = flop + 2;

if (isfinite(theta))
    t = sign(theta)./(abs(theta) + sqrt(theta.^2 + 1));
    flop = flop + 2; % wie viele flops sind sqrt()?!
else
    t = 0;
end

c   = 1./sqrt(t.^2 + 1); % 2 flops
s   = t.*c;              % 1 flop
tau = s./(1+c);          % 1 flop
flop = flop + 4;

Aneu = A;
for i = 1:size(A,1)

    Aneu(i,p) = A(i,p) - s *( A(i,q) + tau* A(i,p) ); % 2 flops
    Aneu(i,q) = A(i,q) + s* ( A(i,p) - tau* A(i,q) ); % 2 folps
    
    Aneu(p,i) = Aneu(i,p);
    Aneu(q,i) = Aneu(i,q);

    flop = flop + 4; 
end

Aneu(p,p) = A(p,p) - t* A(p,q);
Aneu(q,q) = A(q,q) + t* A(p,q);   
flop = flop + 2;

Aneu(p,q) = 0;          
Aneu(q,p) = 0;

P = speye(size(A));
P(p,p) = c;
P(q,q) = c;
P(p,q) = s;
P(q,p) =-s;

end

