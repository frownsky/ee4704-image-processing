%%%%% Section B %%%%%
% This m file is used to test your code for Section B
% Ensure that when you run this script file, the output images are generated and displayed correctly
%--- 1.
I = imread('./test2.bmp');
[T, IT] = intermeans(I);
% imshow(IT) % display image IT
output = T % display the intermeans threshold
%--- 2
% display the measured feature values
[P, A, C, xbar, ybar, phione] = features(IT)
%--- 3
Topt = 45;
Iopt = I >= Topt; % threshold J with Topt
imshow(Iopt) % display image Iopt
% display the measured feature values
[P, A, C, xbar, ybar, phione] = features(Iopt)

% subplot(1,2,1); imshow(I);
% subplot(1,2,2); imshow(Iopt);