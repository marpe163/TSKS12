function q_vec = kmeans2(data, N, k )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
    interval=[min(min(data)) max(max(data))];
    a=interval(1);
    b=interval(2);
    
    %generating random quantization vectors of dim kx1.
    q_vec=randi(round(interval),N,k);
    q_vec=(b-a)*rand(N,k)+a;
    
    tmp=size(data);
    tmp=tmp(2);
    acc_dist=1;
    old_acc_dist=0;
    counter=0;
while acc_dist~=old_acc_dist
    counter=counter+1;
    delta=abs(acc_dist-old_acc_dist);
    if mod(counter,50)==0
       counter
       delta
    end
    association=[];
    old_acc_dist=acc_dist;
    acc_dist=0;
    for it=1:tmp
        [col, min_dist]=find_association(q_vec,data(:,it));
        acc_dist=acc_dist+min_dist;
       association=[association col]; 
    end
    
    %update vectors to be center cluster points
    for it=1:k
       indx=find_index(association,it);
       if length(indx)>0
          A=[];
          for jt=indx
              
              
              A=[A data(:,jt)];
          end
          q_vec(:,it)=column_mean(A);
          
       else
           q_vec(:,it)=(b-a)*rand(N,1)+a;
       end
       
    end
%    
%     figure;
%     plot(q_vec(1,:),q_vec(2,:),'rx');
%     hold on
%     plot(data(1,:),data(2,:),'bo');
%     title(num2str(Y))
%     hold off
    
end
disp('I get here')
end

