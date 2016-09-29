function q_points = kmeans( training_data,N,k, interval,eps )
%Training a vector quantizer. N is the number of dimensions.
% k is the number of cluster points. interval is a vector [a,b] 
%marking available values for the vectors.

%start with initiation by generating a set of k cluster points randomly.
q_points=randi(interval,N,k);

association = zeros(1,length(training_data)) % to keep track on what training points belong to which cluster point.
new_dist = 0;
old_dist = 10000
%while abs(new_dist - old_dist) > eps
for ittt=1:30 
old_dist=new_dist
    new_dist = 0;
    for it=1:length(training_data)
        distr=10000000000000; % big number.
       for jt=1:k
           tmp=norm(q_points(:,jt)-training_data(:,it));
           if tmp < distr
               distr=tmp;
               association(it)=jt;
           end
       end
       new_dist=new_dist+distr;
    end
    association;
    for it=1:k %update cluster points
        [~,ind]=find(association==it);
        %association
        %ind
        if sum(size(ind))>1 && length(ind)~=0
            disp('Im average')
            training_data(:,ind)
            q_points(:,it)
            q_points(:,it)=(1/length(ind))*sum(training_data(:,ind)')';
            q_points(:,it)
        else
            ind
            disp('Im random')
            q_points(:,it)=randi(interval,N,1);
        end
        
    end
    pause;
    %training_data
    %q_points
    plot(training_data(1,:),training_data(2,:),'rx');
    hold on
    plot(q_points(:,1),q_points(:,2),'bo')
    hold off
end


end

