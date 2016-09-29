function indx = find_index( association, it )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
tmp=[];
    for jt=1:length(association)
        if association(jt)==it
            tmp=[tmp jt];
        end
    end
indx=tmp;

end

