function [ S ] = Smetric( A )
%
%   S = Smetric(A)
%
% calculates the sum of squared non-diagonal-elements

    % eye(size(A))==0 reaches all non-diagonal-elements
    nd = A(eye(size(A))==0);
    S  = sum(nd.^2) ;

end

