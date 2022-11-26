function [T,Iout] = intermeans(Iin)

    thres_curr = 0;
    thres_new = mean(Iin(:));
    
    while thres_curr ~= thres_new  
        thres_curr = thres_new;
        
        mu1 = mean(Iin (Iin <= thres_curr));
        mu2 = mean(Iin (Iin >  thres_curr));
 
        thres_new = uint8((mu1+mu2)/2);
    end  
    T      = thres_new;
    T_norm = double(thres_new)/255;
    Iout = imbinarize(Iin,T_norm);
      
end