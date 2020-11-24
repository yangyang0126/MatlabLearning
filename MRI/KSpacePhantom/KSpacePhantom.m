% 定义read方向点数
Readout = 300;

% 生成头部模拟图
[P,~] = phantom('Modified Shepp-Logan',200);
<<<<<<< HEAD
Image = zeros(Readout,Readout);
Image(1:200,1:200) = P;
=======
% Image = zeros(300,300);
% Image(1:200,1:200) = P;
Image = P;
>>>>>>> 41d48a6eb1324f8ac0a7fadfd984dd4703829b1d
figure;
subplot(1,4,1);imagesc(abs(Image));axis square;
title('Software head phantom')

% 生成K空间
kspace =fftshift(fft2(ifftshift(Image)));
subplot(1,4,2);imagesc(abs(kspace));axis square;
title('Simulated K-space')
subplot(1,4,3);plot(abs(kspace));axis square;
title('Simulated K-space')

% % k空间平移
<<<<<<< HEAD
ShiftRead = 7.3;
ShiftPhase = 5.3;
=======
ShiftRead = 0;
ShiftPhase = 0;
>>>>>>> 41d48a6eb1324f8ac0a7fadfd984dd4703829b1d
Width = zeros(Readout,1);
for i=1:Readout
    Width(i,1) = complex(cos(i*ShiftRead),-sin(i*ShiftRead));
end
Width = repmat(Width,1,Readout);
Height = zeros(1,Readout);
for i=1:Readout
    Height(1,i) = complex(cos(i*ShiftPhase),sin(i*ShiftPhase));
end
Height = repmat(Height,Readout,1);
kspace = kspace .* Width.*Height;

% % k空间翻转
% kspace = flip(kspace);

% 从K空间恢复到原图
I0 = fftshift(ifft2(ifftshift(kspace)));
subplot(1,4,4);imagesc(abs(I0));axis square;
title('2DFFT Reconstructed image')