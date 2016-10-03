function mean_vec = column_mean(data_set)
%Method for finding the column mean of a matrix.
%each data point is represented by a column in the data_set matrix.
tmp=size(data_set);
tmp=tmp(2);
    mean_vec=(sum(data_set')')*1/tmp;
end

