function [map,cluster] = EM(imageFile,k)
threshold = 10^(-6);
% use function generate_mu to initialize mus
mu = generate_mu(k);

% use function generate_cov to initialize covariances
cov = generate_cov(k);

% initial alphas as equally
w=ones(k,1)/k;

img=double(imageFile);

[M,N,P]=size(img);
n=M*N;
imgL=img(:,:,1); 
imga=img(:,:,2);
imgb=img(:,:,3);
[cy,cx]=ind2sub([M,N],1:n);

imgL=imgL/255;
imga=imga/255;
imgb=imgb/255;
cy=cy/M;
cx=cx/N;

raw=zeros(n,3);
raw(:,1)=imgL(:);
raw(:,2)=imga(:);
raw(:,3)=imgb(:);

[n,dim]=size(raw);
u=raw(randi([1,n],k,1),:);

v=zeros(k,1);
for ii=1:k
    raw_tmp=raw(ii:k:end,1);
    v(ii,:)=std(raw_tmp);
end

p=zeros(n,k);

u0=u*0;
v0=0*v;
w0=w*0;
energy=sum(sum((u-u0).^2))+sum(sum((v-v0).^2))+(sum((w-w0).^2));
iteration=1;
x_u=zeros(size(raw));
while energy>threshold
    for jj=1:k
        for ss=1:dim
            x_u(:,ss)=raw(:,ss)-u(jj,ss)*ones(n,1);
        end
        x_u=x_u.*x_u;
        p(:,jj)=power(sqrt(2*pi)*v(jj),-1*dim)*exp((-1/2)*sum(x_u,2)./(v(jj).^2));
        p(:,jj)=p(:,jj)*w(jj);
       
    end
    pSum=sum(p,2);
    for jj=1:k
        p(:,jj)=p(:,jj)./pSum;
    end
    
    pSum2=sum(p,1);
    pNorm=p*0;
    for jj=1:k
        pNorm(:,jj)=p(:,jj)/pSum2(jj);
    end
    
    u0=u;v0=v;w0=w;
    

    u=(pNorm.')*raw;

    for jj=1:k
        for ss=1:dim
            x_u(:,ss)=raw(:,ss)-u(jj,ss)*ones(n,1);
        end
        x_u=x_u.*x_u;
        x_uSum=sum(x_u,2);
        v(jj)=sqrt(1/dim*(pNorm(:,jj).')*x_uSum);
    end

    w=(sum(p)/n).';

    iteration=iteration+1;
    energy=sum(sum((u-u0).^2))+sum(sum((v-v0).^2))+(sum((w-w0).^2));

[~, map] = max(p');
[sz1,sz2,~] = size(imageFile);
map = Ary2Img(map, [sz1 sz2]);
cluster=u;

end
end