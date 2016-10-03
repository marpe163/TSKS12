function indx = find_index( association, it )
%Method for creating a vector of the indeces (in the given data ) 
%of the associated data points for the it:th cluster point.
tmp=[];
    for jt=1:length(association)
        if association(jt)==it
            tmp=[tmp jt];
        end
    end
indx=tmp;

end

