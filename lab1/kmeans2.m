function q_vec = kmeans2(data, N, k )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
    interval=[min(min(data)) max(max(data))];
    
    %generating random quantization vectors of dim kx1.
    q_vec=randi(round(interval),N,k);
    
    tmp=size(data);
    tmp=tmp(2);
for Y=1:35 
    Y
    association=[];
    for it=1:tmp
       association=[association find_association(q_vec,data(:,it))]; 
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
           q_vec(:,it)=randi(round(interval),N,1);
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

