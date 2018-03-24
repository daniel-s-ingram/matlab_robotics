%Robotics, Vision and Control - Peter Corke
%Problem 2.6
% Compute the matrix exponential using the power series. 
% How many terms are required to match the result shown to standard MATLAB
% precision?
function [exponential, terms] = matrix_exponential(A)

[m, n] = size(A);

precision = 2^(-digits);
E = expm(A); %Matrix exponential using the built-in MATLAB function

exponential = eye(m, n);
terms = 0;

while abs(E - (exponential+A^terms/factorial(terms))) > precision
    exponential = exponential + A^terms/factorial(terms);
    terms = terms+1;
end
end