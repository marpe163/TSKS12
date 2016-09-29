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
R=pic(:,:,1);
G=pic(:,:,2);
B=pic(:,:,3);
Rvec=reshape(R,1,256*256);
Gvec=reshape(G,1,256*256);
Bvec=reshape(B,1,256*256);
data=[Rvec;Gvec;Bvec];

q_vec = kmeans2(data,3,4);
rdypic=data;

for it=1:length(rdypic)
    col=find_association(q_vec,rdypic(:,it));
    rdypic(:,it)=q_vec(:,col);
end

Rvec=rdypic(1,:);
Gvec=rdypic(2,:);
Bvec=rdypic(3,:);
im=zeros(256,256,3);
im(:,:,1)=reshape(Rvec,256,256);
im(:,:,2)=reshape(Gvec,256,256);
im(:,:,3)=reshape(Bvec,256,256);
imshow(im)
