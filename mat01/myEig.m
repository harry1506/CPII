function [ D, V, iter ] = myEig( A, maxIter )
%
%   D = myEig( A );
%  calculates a diagonal matrix with eigenvalues of A on the diagonal
%
%  [ D, V, iter ] = myEig( A, maxIter )
% optional arguments:
%     maxIter:    maximum number of iterations for solving the problem
%                 default = 1000
%
% other return values:
%     V:    product of successive rotation matrixes P_i
%           P1*P2*P3*...*Pi
%     iter: number of preformed iterations
%

if nargin < 2
    maxIter = 1000; % set default argument
end

D = A; 
V = eye(size(A)); % V = P1 P2 P3;

% 1 iteration = loop over all pq's
for iter = 0:(maxIter-1)  
    
    nd = D( eye(size(D))==0 ); % list of nondiagonal elements
    if (abs(nd) == 0)          % if all equal zero
        break;                 % stop iteration
    end
        
    for q=2:size(A,1)
        for p=1:q-1
            
            [D, P] = doPpq(D,p,q); % apply pq-rotation
            V = V*P;               % update V
        
       end % p
    end %q
    
end %iter
end



