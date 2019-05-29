% 定义read方向点数
Readout = 150;

% 生成头部模拟图
[P,~] = phantom('Modified Shepp-Logan',Readout);
figure;
subplot(1,4,1);imagesc(abs(P));axis square;
title('Software head phantom')

% 生成K空间
kspace =fftshift(fft2(ifftshift(P)));
subplot(1,4,2);imagesc(abs(kspace));axis square;
title('Simulated K-space')
subplot(1,4,3);plot(abs(kspace));axis square;
title('Simulated K-space')

% 从K空间恢复到原图
I0 = fftshift(ifft2(ifftshift(kspace)));
subplot(1,4,4);imagesc(abs(I0));axis square;
title('2DFFT Reconstructed image')