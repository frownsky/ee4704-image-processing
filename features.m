% To compute the features;
% input is the binary thresholded image
% outputs are the feature values
function [P, A, C, xbar, ybar, phione] = features(Iin)
    % perimeter, area, compactness, centroid, invariant moment 𝜙1
    [row,col] = size(Iin);
    % 1) P: perimeter
    pStruct = regionprops(Iin,'Perimeter');
    P = pStruct.Perimeter;
    % 2) A: area
    A = regionprops(Iin,'Area').Area;
    % 3) C: compactness = (P)^2 / 4*pi*A
    C = (P*P)/(4*pi*A);
    % 4) xbar, ybar: centroid
    m = zeros(2,2);
    f = Iin;
    % m_pq = \sum_x \sum_y (x^p)*(y^p)*f(x,y)
    for p = 0:1
        for q = 0:1
            for x = 1:col
                for y = 1:row 
                    % finding m_00, m_01, m_10, m_11
                    m(p+1,q+1) = m(p+1,q+1) + ((x-1)^p)*((y-1)^q)*f(y,x);
                end
            end
        end
    end

    xbar = m(2,1)/m(1,1); % xbar = m_10 / m_00
    ybar = m(1,2)/m(1,1); % ybar = m_01 / m_00

    % 5) 𝜙1: invariant moment
    mu = zeros(3,3);
    mu_norm = zeros(3,3);
    for p = 0:2
        for q = 0:2
            for x = 1:col
                for y = 1:row 
                    % finding m_00, m_01, m_10, m_11
                    mu(p+1,q+1) = mu(p+1,q+1) + ((x-1-xbar)^p)*((y-1-ybar)^q)*f(y,x);
                end
            end
            if (mu(1,1) ~= 0) % we are guaranteed mu(1,1) is filled after first iteration
                mu_norm(p+1,q+1) = mu(p+1,q+1)/(mu(1,1)^((p+q+2)/2)+1);
            end
        end
    end
    phione = mu_norm(3,1) + mu_norm(1,3); 
end