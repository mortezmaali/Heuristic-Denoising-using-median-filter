image=imread('noisyretina.jpg');
n = 3;
d=floor(n/2);
[m1,n1,w]=size(image);
m2=m1+2*d;
n2=n1+2*d;
for k=1:w
    image_n(1:m2,1:n2,k)=0;
    image_n1(1:m2,1:n2,k)=0;
    image_n(d+1:m2-d,d+1:n2-d,k)=image(:,:,k);
    t=0;
    mm=median(1:n);
    for i=1:m1
        r=0;
        for j=1:n1
            b=(image_n(1+t:n+t,1+r:n+r,k));
            s=std2(b);
            m=mean2(b);
            if b(2,2)>m+0.01*s || b(2,2)<m-0.01*s
                B = reshape(b,[],1);
                B(5)=[];
                st=median(median(B));
                image_n1(mm+t,mm+r,k)=st;
            else
                image_n1(mm+t,mm+r,k)=0;
            end
            r=r+1;
        end
        t=t+1;
    end
end
for k=1:w
    for i=1:m1
        for j=1:n1
            if image_n1(i,j,k)~=0
                image_n(i,j,k)=image_n1(i,j,k);
            end
        end
    end
end
%image_n1(image_n1==0) = image_n;
figure(1);imshow(image);
figure(2);imshow(uint8(image_n));