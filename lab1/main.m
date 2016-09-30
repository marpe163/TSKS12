% Main script for lab 1. 

%Task 1
data=[1 1;1.5 2;3 4;5 7;3.5 5;4.5 5;3.5 4.5]';
q=kmeans2(data,2,2)
hold off
plot(q(1,:),q(2,:),'rx')
hold on
plot(data(1,:),data(2,:),'bo')

%% Task 2
files={'parrot.jpg';'jimi.jpg';'colorburst.jpg'};
for kt=1:length(files)
files{kt}
pic=imread(files{kt});
pic=im2double(pic);

picsize=size(pic);
R=pic(:,:,1);
G=pic(:,:,2);
B=pic(:,:,3);

Rvec=reshape(R,1,picsize(1)*picsize(2));
Gvec=reshape(G,1,picsize(1)*picsize(2));
Bvec=reshape(B,1,picsize(1)*picsize(2));
data=[Rvec;Gvec;Bvec];
colors=[8,16,64];
for color=colors
    color
    q_vec = kmeans2(data,3,color);
    rdypic=data;

    for it=1:length(rdypic)
        col=find_association(q_vec,rdypic(:,it));
        rdypic(:,it)=q_vec(:,col);
    end

    Rvec=rdypic(1,:);
    Gvec=rdypic(2,:);
    Bvec=rdypic(3,:);

    im=zeros(picsize(1),picsize(2),3);
    im(:,:,1)=reshape(Rvec,picsize(1),picsize(2));
    im(:,:,2)=reshape(Gvec,picsize(1),picsize(2));
    im(:,:,3)=reshape(Bvec,picsize(1),picsize(2));

    figure;
 
    subplot(1,2,1);
    imshow(pic);
       title(sprintf('Full color\n'))
    subplot(1,2,2);
    imshow(im);
    title([sprintf('Reconstructed using\n') num2str(color) ' colors'])
end
end