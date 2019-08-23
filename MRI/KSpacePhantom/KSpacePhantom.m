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

% k空间平移
ShiftRead = 10;
Width = zeros(Readout,1);
for i=1:Readout
    Width(i,1) = complex(cos(i*ShiftRead),-sin(i*ShiftRead));
end
Width = repmat(Width,1,Readout);
kspace = kspace .* Width;

% k空间翻转
kspace = flip(kspace);

% 从K空间恢复到原图
I0 = fftshift(ifft2(ifftshift(kspace)));
subplot(1,4,4);imagesc(abs(I0));axis square;
title('2DFFT Reconstructed image')