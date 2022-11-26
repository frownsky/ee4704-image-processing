% To compute the r-theta plot;
% input is a boundary image ‘test3.bmp’
% output is the array containing the r-theta value
function [r, theta] = rtheta(Iin)
% find xbar and ybar
    Iin       = Iin > 0;
    [row,col] = size(Iin);
    m         = zeros(2,2);
    f         = Iin;

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

    % xbar = m_10 / m_00
    % ybar = m_01 / m_00
    
    xbar = m(2,1)/m(1,1);
    ybar = m(1,2)/m(1,1);
    
    % filling up r and theta
    len_boundary = sum(Iin(:)> 0);
    r            = zeros(len_boundary,1);
    theta        = zeros(len_boundary,1);
    i = 0;
    for y = 0:(row-1)
        for x = 0:(col-1)
            if f(y+1,x+1) == 1
                % from tutorial 4(b)
                i        = i+1;
                r(i)     = sqrt((x-xbar)^2 + (y-ybar)^2);
                theta(i) = atan2((y-ybar),(x-xbar)) +  (2*pi*((y-ybar)<0)) ;
            end
        end
    end

end
