function q_vec = k_means(data, N, k )
% Implementation of the K-means algorithm

    %Used when generating random cluster points.
    a=min(min(data));
    b=max(max(data));
    
    %generating k random quantization vectors of dim Nx1.
    q_vec=(b-a)*rand(N,k)+a; 
    %q_vec=[data(:,1) data(:,4)] %for task 1.
    
    tmp=size(data);
    tmp=tmp(2);
    acc_dist=1;
    old_acc_dist=0;
    counter=0;
    
%Iterate until there is no further reduction in distortion.
while acc_dist~=old_acc_dist 
    counter=counter+1;
    delta=abs(acc_dist-old_acc_dist);
    
    %Print info. on current distortion and the current iteration.
    if mod(counter,1)==0 
       counter; 
       delta;
    end
    
    %Associating finding the closest cluster point to all data points.
    %Also calculates distortion (acc_dist).
    
    association=[];
    old_acc_dist=acc_dist;
    acc_dist=0;
    for it=1:tmp
        [col, min_dist]=find_association(q_vec,data(:,it));
        acc_dist=acc_dist+min_dist;
       association=[association col]; 
    end
    
    %update cluster points to be the mean of their associated data points.
    for it=1:k
       indx=find_index(association,it);
       if length(indx)>0
          A=[];
          
          for jt=indx
              A=[A data(:,jt)];
          end
          
          q_vec(:,it)=column_mean(A);
          
       else
           %If a cluster point has no data points associated to it,
           %Randomize!
           q_vec(:,it)=(b-a)*rand(N,1)+a;
       end
       
    end
    
%     %For presenting the results in task 1
%     subplot(2,2,counter);
%     plot(q_vec(1,:),q_vec(2,:),'b*');
%     hold on
%     plot(data(1,:),data(2,:),'ro')
%     title([num2str(counter) sprintf(' iteration(s)') ])

end
end

