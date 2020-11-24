% 定义read方向点数
Readout = 200;

% 生成头部模拟图
[P,~] = phantom('Modified Shepp-Logan',Readout);
Image = P;
figure;
subplot(1,3,1);imagesc(abs(Image));axis square;
title('Software head phantom')

% 生成K空间
kspace = fftshift(fft2((Image)));
%kspace = fftshift(fft2(ifftshift(Image)));
subplot(1,3,2);imagesc(abs(kspace));axis square;
title('Simulated K-space')

% 从K空间恢复到原图
I0 = (ifft2(ifftshift(kspace)));
%I0 = fftshift(ifft2(ifftshift(kspace)));
subplot(1,3,3);imagesc(abs(I0));axis square;
title('2DFFT Reconstructed image')


