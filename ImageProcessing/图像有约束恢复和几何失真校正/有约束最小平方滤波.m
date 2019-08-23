clear;
close all;

%通过模拟水平运动模糊建立退化函数
d=5;
h=zeros(2*d+1,2*d+1);       %分配数组
h(d+1,1:2*d+1)=1/(2*d);

I=imread('E:\coding\fft\FFT.jpg');
I=rgb2gray(I);
[m,n]=size(I);
fe=zeros(m+2*d,n+2*d);
fe(1:m,1:n)=I;
he=zeros(m+2*d,n+2*d);
he(1:2*d+1,1:2*d+1)=h;
F=fft2(fe);
H=fft2(he);
G=fft2(double(I));
[M,N]=size(G);

p=[0 -4 0;1 -4 1 ;0 1 0];
[m,n]=size(p);
pp=zeros(M,N);
pp(1:m,1:n)=p;
P=fft2(pp);
k1=0.001;
for u=1:M;
    for v=1:N;
        i=abs(H(u,v));
        i=i.^2;
        j=abs(P(u,v));
        j=k1*(j.^2);
        H1(u,v)=i./H(u,v);
         s(u,v)=(H1(u,v)./(i+j));
         r(u,v)=s(u,v).*G(u,v);
    end
end
r=ifft2(r);
r=uint8(real(r));
subplot(1,2,1);imshow(I);title('原始图像');axis on;
subplot(1,2,2);imshow(r);title('约束最小平方滤波');axis on