% ����read�������
Readout = 200;

% ����ͷ��ģ��ͼ
[P,~] = phantom('Modified Shepp-Logan',Readout);
Image = P;
figure;
subplot(1,3,1);imagesc(abs(Image));axis square;
title('Software head phantom')

% ����K�ռ�
kspace = fftshift(fft2((Image)));
%kspace = fftshift(fft2(ifftshift(Image)));
subplot(1,3,2);imagesc(abs(kspace));axis square;
title('Simulated K-space')

% ��K�ռ�ָ���ԭͼ
I0 = (ifft2(ifftshift(kspace)));
%I0 = fftshift(ifft2(ifftshift(kspace)));
subplot(1,3,3);imagesc(abs(I0));axis square;
title('2DFFT Reconstructed image')


