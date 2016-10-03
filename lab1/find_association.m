function [col,min_dist] = find_association(q_points,vec )
%finds the column in q_points that is closest to the vector vec in
%euclidian space, and returns the column index along with the distance
%between them.
    tmp=size(q_points);
    tmp=tmp(2); %no of columns in q_points.
    min_dist=1000000000;%big number
    curr_dist=0;
    col = 0;
    
    %Brute force approach. Try all possibilities.
    for it=1:tmp
        curr_dist=distance(q_points(:,it),vec);
        if curr_dist < min_dist
           min_dist=curr_dist; 
           col=it; %which column gave the best result?
        end
        
    end

end

