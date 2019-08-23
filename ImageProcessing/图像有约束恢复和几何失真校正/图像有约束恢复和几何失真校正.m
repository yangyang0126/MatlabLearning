clear;
close all;

%通过模拟水平运动模糊建立退化函数
d=5;
h=zeros(2*d+1,2*d+1);       %分配数组
h(d+1,1:2*d+1)=1/(2*d);

% add noise
I=imread('E:\coding\fft\FFT.jpg');
I=rgb2gray(I);
[m,n]=size(I);
fe=zeros(m+2*d,n+2*d);
fe(1:m,1:n)=I;
he=zeros(m+2*d,n+2*d);
he(1:2*d+1,1:2*d+1)=h;
F=fft2(fe);
H=fft2(he);
g=imnoise(uint8(ifft2(F.*H)),'gaussian',0,0.0001);
G=fft2(double(g));
subplot(2,4,1);imshow(I);title('原始图像');axis on;
subplot(2,4,2);imshow(g);title('水平运动模糊退化');axis on

%维纳滤波
k=0.05;
[m,n]=size(G);
for u=1:m;
     for v=1:n;
         i=abs(H(u,v));
         i=i.^2;
         s(u,v)=(1/H(u,v)*(i./(i+k)));
         r(u,v)=s(u,v).*G(u,v);
     end
end
 
r=ifft2(r);
r=uint8(real(r));
subplot(2,4,3);
imshow(r);title('维纳滤波');axis on;

%约束最小平方滤波器
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
         s2(u,v)=(H1(u,v)./(i+j));
         r2(u,v)=s2(u,v).*G(u,v);
    end
end
r2=ifft2(r2);
r2=uint8(real(r2));
subplot(2,4,4);
imshow(r2);title('约束最小平方滤波');axis on;

%仿射变换
s=0.5;T=[s 0;0 s;0 0];
tf=maketform('affine',T);
I1=imtransform(r,tf,'bicubic','FillValues',0.3);
subplot(2,4,5);imshow(I1);title('仿射变换');axis on;
 
%插值
I2=imresize(I1,1,'nearest');
I3=imresize(I1,1,'bilinear');
I4=imresize(I1,1,'bicubic');
subplot(2,4,6);imshow(I2);title('最近邻插值');axis on;
subplot(2,4,7);imshow(I2);title('双线性插值');axis on;
subplot(2,4,8);imshow(I2);title('双三次插值');axis on;
