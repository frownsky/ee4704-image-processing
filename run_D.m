%%%%% Section D %%%%%
% This m file is used to test your code for Section D
% Ensure that when you run this script file
%--- 1.
I       = imread('./letter.bmp');
[T, I1] = intermeans(I);     % thresholding
temp    = bwboundaries(I1);  % extract boundary
B       = fliplr(temp{1,1}); % extract boundary
B1      = B(1:10:end,:);     % re-sample by taking every 10th data of B

a_low   = -3;      % minimum allowable a
a_high  = 3;       % maximum allowable a

b_low   = -2000;   % minimum allowable b
b_high  = 2000;    % maximum allowable b

a_inc   = 0.05;    % increment
b_inc   = 1;       % increment

a       = [a_low:a_inc:a_high];
b       = [b_low:b_inc:b_high];

a_len   = size(a,2);
b_len   = size(b,2);

edges   = B1; 
table   = zeros([size(edges,1),size(a,2)]);
accumulator = zeros([b_len,a_len]);

edges_len = size(edges,1);
table_col_len = size(table,2);
table_row_len = size(table,1);
 
for a_i = 1:a_len 
        for e = 1:edges_len
            x = edges(e,1);
            y = edges(e,2);
            table(e,a_i) = -(x)*a(a_i) + y;  % every row in table represents a line in a-b space
        end
end

for a_i = 1:table_col_len
    for b_j = 1:table_row_len
        offset = abs(b_low);
        b_curr = (table(b_j,a_i) + offset)/b_inc; % transform b by adding offset and divide by increment level
        if (b_curr >= 1)                          % ensure no zero or negative indices
            p = 0;
            q = a_i;
            if (b_curr > (ceil(b_curr) - b_inc/2))
                p = ceil(b_curr);
            elseif (b_curr <= (floor(b_curr) + b_inc/2))
                p = floor(b_curr);
            end
            accumulator(p, q) = accumulator(p, q) + 1;   
        end
    end
end

A = flipud(accumulator);
% subplot(1,2,1);
% imshow(I);
% subplot(1,3,1);

imshow(I);
hold("on")

% detected lines and their gradient and intercept
x = (1:1:400)';

% for recording
table_grad_int = [];

n = 20; % number of extractions
for l = 1:n
    maximum = max(A(:));          % find the maximum cell(s)
    [r,c]   = find(A==maximum);   % find the indices of the maximum cell(s)
    r       = r(1);               % if multiple max detected, take the first one's row
    c       = c(1);               % if multiple max detected, take the first one's col
    mi      = a(c);               % use the row index to get the respective gradient
    bi      = b(b_len-r+1);       % use the col index to get the respective intercept
    table_grad_int(end+1,:) = [mi bi];
    plot(x,mi*x+bi,'LineWidth',1);
    A(r,c) = 0; % remove max 
    hold("on")
end

hold("off")
% subplot(1,3,2);
% scatter(table_grad_int(:,1),table_grad_int(:,2));
saveas(gcf,'letter_line','bmp');


% extra: k-means clustering (Need MATLAB's Machine Learning toolkit)
% changes: extraction = 80, B1 = B;

% rng(1); % For reproducibility
% clusters = 6; % since there's 6 lines needed to detect
% [idx,C] = kmeans(table_grad_int,clusters);
% 
% hold("off")
% subplot(1,3,3);
% imshow(I);
% hold("on")
% for l = 1:clusters
%     mi = C(l,1);
%     bi = C(l,2);
%     plot(x,mi*x+bi,'LineWidth',1.5,'Color','White');
%     hold("on")
% end