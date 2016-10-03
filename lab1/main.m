% Main script for lab 1. 

%Task 1
data=[1 1;1.5 2;3 4;5 7;3.5 5;4.5 5;3.5 4.5]'; %given data

%Plotting the initial set up.
plot(data(1,:),data(2,:),'ro');
hold on
plot(data(1,[1 4]),data(2,[1 4]),'b*')
xlim([0 max(data(1,:))+1]);
ylim([0 max(data(2,:))+1]);
title('After initialization')
legend('Data points','Cluster points','Location','NorthWest')

figure;
q=kmeans(data,2,2)


%% Task 2
files={'parrot.jpg';'jimi.jpg';'colorburst.jpg'};

%iterate over all images
for kt=1:length(files)
files{kt}%Print current image

%read image
pic=imread(files{kt});
pic=im2double(pic);

%Re arrange data to fit our algorithm.
picsize=size(pic);
R=pic(:,:,1);
G=pic(:,:,2);
B=pic(:,:,3);
Rvec=reshape(R,1,picsize(1)*picsize(2));
Gvec=reshape(G,1,picsize(1)*picsize(2));
Bvec=reshape(B,1,picsize(1)*picsize(2));
data=[Rvec;Gvec;Bvec];

colors=[8,16,64];
%Apply the algorithm for all K listed in the colors vector.
for color=colors
    tic
    color
    
    %Apply the algorithm to the data
    q_vec = kmeans(data,3,color);
    rdypic=data;

    %replace all data points with the closest cluster point
    for it=1:length(rdypic)
        col=find_association(q_vec,rdypic(:,it));
        rdypic(:,it)=q_vec(:,col);
    end

    %re arrange the result to the standard image form.
    Rvec=rdypic(1,:);
    Gvec=rdypic(2,:);
    Bvec=rdypic(3,:);
    im=zeros(picsize(1),picsize(2),3);
    im(:,:,1)=reshape(Rvec,picsize(1),picsize(2));
    im(:,:,2)=reshape(Gvec,picsize(1),picsize(2));
    im(:,:,3)=reshape(Bvec,picsize(1),picsize(2));

    %present the result
    figure;
    subplot(1,2,1);
    imshow(pic);
    title(sprintf('Full color\n'))
    subplot(1,2,2);
    imshow(im);
    title([sprintf('Reconstructed using\n') num2str(color) ' colors'])
    toc
end
end