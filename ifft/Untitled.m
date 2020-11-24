fo = fopen('coilim_k.dat','r');
fr = fread(fo,'float');
dr = fr(1:2:end,1);
di = fr(2:2:end,1);
d = complex(dr,di);
kspace = reshape(d,144,256,8);
kspace = kspace(:,:,1);
img = fftshift(ifft2(ifftshift(kspace)));
phase = angle(img);
imshow(rot90(phase,3),[]);
imshow(abs(kspace),[]);


a = ifft2(kspace);