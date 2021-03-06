listoffiles=[]; 
trainingset=cell(15);
mainpath='dataset';

for j=1:4
    subpath=strcat(mainpath,int2str(j));
    subpath=strcat(subpath,'/');
    listoffiles=dir(fullfile(strcat(subpath,'*.bmp')));
    for k = 1:size(listoffiles,1)
        x=strfind(listoffiles(k).name,'subject01');
        if(size(x,1)~=0)
            n = strcat(subpath,listoffiles(k).name);
            trainingset{1}{end+1} = n;
            %disp(trainingset{1,end});
        end
        x=strfind(listoffiles(k).name,'subject02');
        if(size(x,1)~=0)
            n = strcat(subpath,listoffiles(k).name);
            trainingset{2}{end+1} = n;
            %disp(trainingset{2,end});
        end
        x=strfind(listoffiles(k).name,'subject03');
        if(size(x,1)~=0)
            n = strcat(subpath,listoffiles(k).name);
            trainingset{3}{end+1} = n;
            %disp(trainingset{3,end});
        end
        x=strfind(listoffiles(k).name,'subject04');
        if(size(x,1)~=0)
            n = strcat(subpath,listoffiles(k).name);
            trainingset{4}{end+1} = n;
            %disp(trainingset{4,end});
        end
        x=strfind(listoffiles(k).name,'subject05');
        if(size(x,1)~=0)
            n = strcat(subpath,listoffiles(k).name);
            trainingset{5}{end+1} = n;
            %disp(trainingset{5,end});
        end
        x=strfind(listoffiles(k).name,'subject06');
        if(size(x,1)~=0)
            n = strcat(subpath,listoffiles(k).name);
            trainingset{6}{end+1} = n;
            %disp(trainingset{6,end});
        end
        x=strfind(listoffiles(k).name,'subject07');
        if(size(x,1)~=0)
            n = strcat(subpath,listoffiles(k).name);
           trainingset{7}{end+1} = n;
            %disp(trainingset{7,end});
        end
        x=strfind(listoffiles(k).name,'subject08');
        if(size(x,1)~=0)
            n = strcat(subpath,listoffiles(k).name);
            trainingset{8}{end+1} = n;
            %disp(trainingset{8,end});
        end
        x=strfind(listoffiles(k).name,'subject09');
        if(size(x,1)~=0)
            n = strcat(subpath,listoffiles(k).name);
            trainingset{9}{end+1} = n;
            %disp(trainingset{9,end});
        end
        x=strfind(listoffiles(k).name,'subject10');
        if(size(x,1)~=0)
            n = strcat(subpath,listoffiles(k).name);
            trainingset{10}{end+1} = n;
            %disp(trainingset{10,end});
        end
        x=strfind(listoffiles(k).name,'subject11');
        if(size(x,1)~=0)
            n = strcat(subpath,listoffiles(k).name);
            trainingset{11}{end+1} = n;
            %disp(trainingset{11,end});
        end
        x=strfind(listoffiles(k).name,'subject12');
        if(size(x,1)~=0)
            n = strcat(subpath,listoffiles(k).name);
            trainingset{12}{end+1} = n;
            %disp(trainingset{12,end});
        end
        x=strfind(listoffiles(k).name,'subject13');
        if(size(x,1)~=0)
            n = strcat(subpath,listoffiles(k).name);
            trainingset{13}{end+1} = n;
            %disp(trainingset{13,end});
        end
        x=strfind(listoffiles(k).name,'subject14');
        if(size(x,1)~=0)
            n = strcat(subpath,listoffiles(k).name);
            trainingset{14}{end+1} = n;
            %disp(trainingset{14,end});
        end
        x=strfind(listoffiles(k).name,'subject15');
        if(size(x,1)~=0)
            n = strcat(subpath,listoffiles(k).name);
            trainingset{15}{end+1} = n;
            %disp(trainingset{15,end});
        end
    end
end
A=[];
means=zeros(77760,15);
for i=1:15
    m=size(trainingset{i});
    m=m(2);
    B=[];
    %means(i)=zeros(9);
    for j=1:m
        img=imread(trainingset{i}{j});
        x=size(size(img));
        x=x(2);
        if(x==3)
            img=rgb2gray(img);
        end
        [r c]=size(img);
        temp=reshape(img',r*c,1);
        temp=double(temp);
        B=[B temp];
        A=[A temp];
    end
    %disp(size(B));
    A=[A;];
    x=mean(B,2);
    %disp(size(x));
    for j=1:77760
        for k=1:size(x,2)
            means(j,i)=x(j);
        end
    end
end
overallmean=mean(A,2);
L=A'*A;
[vv dd]=eig(L);
v=[];
d=[];
for i=1:size(vv,2)
    if(dd(i,i)>1e-4)
        v=[v vv(:,i)];
        d=[d dd(i,i)];
    end
end
[B index]=sort(d);
ind=zeros(size(index));
dtemp=zeros(size(index));
vtemp=zeros(size(v));
len=length(index);
for i=1:len
    dtemp(i)=B(len+1-i);
    ind(i)=len+1-index(i);
    vtemp(:,ind(i))=v(:,i);
end
d=dtemp;
v=vtemp;

for i=1:size(v,2)
kk=v(:,i);
temp=sqrt(sum(kk.^2));
v(:,i)=v(:,i)./temp;
end

u=[];
for i=1:size(v,2)
temp=sqrt(d(i));
u=[u (A*v(:,i))];
end

for i=1:size(u,2)
kk=u(:,i);
temp=sqrt(sum(kk.^2));
u(:,i)=u(:,i)./temp;
end


for i=1:size(u,2)
    img=reshape(u(:,i),c,r);
    img=img';
    img=histeq(img,255);
    M=size(trainingset);
    M=M(2);
    if(i<=M)
        subplot(ceil(sqrt(M)),ceil(sqrt(M)),i)
    end
    imshow(img)
    j=j+1;
end


trainomegas=zeros(125,0);
%disp(size(means));
%disp(size(overallmean));
for i=1:15
    tm=means(:,i)-overallmean;
    trainomegas=[trainomegas u'*tm];
    %trainomegas(i)=u'*(means(:,i)-overallmean);
end

testset=cell(15);
listoffiles=dir(fullfile('dataset5/*.bmp'));
%disp(listoffiles);
subpath='dataset5/';
for k = 1:size(listoffiles,1)
        x=strfind(listoffiles(k).name,'subject01');
        if(size(x,1)~=0)
            n = strcat(subpath,listoffiles(k).name);
            testset{1}{end+1} = n;
            %disp(trainingset{1,end});
        end
        x=strfind(listoffiles(k).name,'subject02');
        if(size(x,1)~=0)
            n = strcat(subpath,listoffiles(k).name);
            testset{2}{end+1} = n;
            %disp(trainingset{2,end});
        end
        x=strfind(listoffiles(k).name,'subject03');
        if(size(x,1)~=0)
            n = strcat(subpath,listoffiles(k).name);
            testset{3}{end+1} = n;
            %disp(trainingset{3,end});
        end
        x=strfind(listoffiles(k).name,'subject04');
        if(size(x,1)~=0)
            n = strcat(subpath,listoffiles(k).name);
            testset{4}{end+1} = n;
            %disp(trainingset{4,end});
        end
        x=strfind(listoffiles(k).name,'subject05');
        if(size(x,1)~=0)
            n = strcat(subpath,listoffiles(k).name);
            testset{5}{end+1} = n;
            %disp(trainingset{5,end});
        end
        x=strfind(listoffiles(k).name,'subject06');
        if(size(x,1)~=0)
            n = strcat(subpath,listoffiles(k).name);
            testset{6}{end+1} = n;
            %disp(trainingset{6,end});
        end
        x=strfind(listoffiles(k).name,'subject07');
        if(size(x,1)~=0)
            n = strcat(subpath,listoffiles(k).name);
           testset{7}{end+1} = n;
            %disp(trainingset{7,end});
        end
        x=strfind(listoffiles(k).name,'subject08');
        if(size(x,1)~=0)
            n = strcat(subpath,listoffiles(k).name);
            testset{8}{end+1} = n;
            %disp(trainingset{8,end});
        end
        x=strfind(listoffiles(k).name,'subject09');
        if(size(x,1)~=0)
            n = strcat(subpath,listoffiles(k).name);
            testset{9}{end+1} = n;
            %disp(trainingset{9,end});
        end
        x=strfind(listoffiles(k).name,'subject10');
        if(size(x,1)~=0)
            n = strcat(subpath,listoffiles(k).name);
            testset{10}{end+1} = n;
            %disp(trainingset{10,end});
        end
        x=strfind(listoffiles(k).name,'subject11');
        if(size(x,1)~=0)
            n = strcat(subpath,listoffiles(k).name);
            testset{11}{end+1} = n;
            %disp(trainingset{11,end});
        end
        x=strfind(listoffiles(k).name,'subject12');
        if(size(x,1)~=0)
            n = strcat(subpath,listoffiles(k).name);
            testset{12}{end+1} = n;
            %disp(trainingset{12,end});
        end
        x=strfind(listoffiles(k).name,'subject13');
        if(size(x,1)~=0)
            n = strcat(subpath,listoffiles(k).name);
            testset{13}{end+1} = n;
            %disp(trainingset{13,end});
        end
        x=strfind(listoffiles(k).name,'subject14');
        if(size(x,1)~=0)
            n = strcat(subpath,listoffiles(k).name);
            testset{14}{end+1} = n;
            %disp(trainingset{14,end});
        end
        x=strfind(listoffiles(k).name,'subject15');
        if(size(x,1)~=0)
            n = strcat(subpath,listoffiles(k).name);
            testset{15}{end+1} = n;
            %disp(testset{15,end});
        end
end
total=0;
correct=0;
actual=[];
label=[];
for i=1:15
    m=size(testset{i});
    m=m(2);
    B=[];
    %disp(size(trainomegas));
    %means(i)=zeros(9);
    for j=1:m
        %disp(testset{i}{j});
        actual=[actual i];
        img=imread(testset{i}{j});
        x=size(size(img));
        x=x(2);
        if(x==3)
            img=rgb2gray(img);
        end
        [r c]=size(img);
        temp=reshape(img',r*c,1);
        temp=double(temp);
        %testomega=u'*(temp-overallmean);
        %disp(testomega);
        %disp(testomega);
        min=100000000;
        cat=0;
        for k=1:15
            %disp(k);
            %disp(norm(testomega-trainomegas(k)));
            testomega=u'*(temp-means(:,k));
            if(norm(testomega-trainomegas(:,k))<min)
                %disp('changing to');
                %disp(k);
                min=norm(testomega-trainomegas(:,k));
                cat=k;
            end
        end
        disp(cat);
        label=[label cat];
        disp(i);
        if(cat==i)
            correct=correct+1;
        end
        total=total+1;
    end
end
disp('accuracy');
disp(correct/total);
[C, order]=confusionmat(actual,label);
display(C);