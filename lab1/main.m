% Main script for lab 1. 

%Task 1
data=[1 1;1.5 2;3 4;5 7;3.5 5;4.5 5;3.5 4.5]';
q=kmeans2(data,2,2)
hold off
plot(q(1,:),q(2,:),'rx')
hold on
plot(data(1,:),data(2,:),'bo')

%% Task 2
pic=imread('parrot5.jpg');
pic=im2double(pic);
tmp=size(pic);
data=[];
for it=1:tmp(1)
   for jt=1:tmp(2)
       tmp1=[pic(it,jt,1);pic(it,jt,2);pic(it,jt,3)];
       data = [data tmp1];
   end
   it
end
q_vec = kmeans2(data,3,16);
%%
for it=1:length(data)
    col=find_association(q_vec,data(:,it));
    col
    data(:,it)=q_vec(:,col);
end

rdypic=zeros(256,256,3);
counter=1;

for kt=1:256
    
    for it=1:256
        disp('wololo')
        rdypic(it,jt,:)
            rdypic(it,jt,:)=data(:,counter);
            rdypic(it,jt,:)
            counter=counter+1;
    end
end