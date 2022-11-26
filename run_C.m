%%%%% Section C %%%%%
% This m file is used to test your code for Section C
% Ensure that when you run this script file, the r-theta plot is displayed correctly
%--- 1.
I = imread('./test3.bmp');
[r, theta] = rtheta(I); % calculate r and theta
% plot r-theta graph
scatter(theta,r)