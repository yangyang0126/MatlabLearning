
% 医学图像配准
% Step1. 下载图片
% Step2. 初始配准（粗配准）
% Step3. 提高配准精度
% Step4. 利用初始条件提高配准精度配准

fixed = dicomread('knee1.dcm');      % 读参考图像fixed
moving = dicomread('knee2.dcm'); %  读浮动图像moving

% 配置优化器和度量准则
[optimizer, metric] = imregconfig('multimodal');

% 配准代码
movingRegisteredDefault = imregister(moving,fixed,'affine',optimizer,metric);

% 提高配准精度
disp('optimizer');
disp('metric');

% 改变优化器的步长已达到对更加精细的变换
optimizer.InitialRadius=optimizer.InitialRadius/3.5;
movingRegisteredAdjustedInitialRadius=imregister(moving,fixed,'affine',optimizer,metric);

% 改变最大迭代次数
optimizer.MaximumIterations = 300;
movingRegisteredAdjustedInitialRadius300 = imregister(moving, fixed, 'affine', optimizer, metric);

% 改变初始条件提高精度
tformSimilarity = imregtform(moving,fixed,'similarity',optimizer,metric);
Rfixed = imref2d(size(fixed));
movingRegisteredRigid = imwarp(moving,tformSimilarity,'OutputView',Rfixed);

movingRegisteredAffineWithIC = imregister(moving,fixed,'affine',optimizer,metric,'InitialTransformation',tformSimilarity);
%%
moving_new=[fixed,...
    moving,movingRegisteredDefault,...
    movingRegisteredAdjustedInitialRadius,...
    movingRegisteredAdjustedInitialRadius300,...
    movingRegisteredRigid,...
    movingRegisteredAffineWithIC    ];
fixed_new=[fixed,fixed,fixed,fixed,fixed,fixed,fixed,];
subplot(2,1,1);imshowpair(moving_new, fixed_new, 'falsecolor');
subplot(2,1,2);imshow(moving_new,[]);
%%
figure;
imshowpair(movingRegisteredDefault, fixed);
title('A?-?Default?settings.');

figure;
imshowpair(movingRegisteredAdjustedInitialRadius, fixed);
title('B?-?Adjusted?InitialRadius,?100?Iterations.');

figure
imshowpair(movingRegisteredAdjustedInitialRadius300, fixed);
title('C?-?Adjusted?InitialRadius,?300?Iterations.');

figure
imshowpair(movingRegisteredAffineWithIC, fixed);
title('D?-?Registration?from?affine?model?based?on?similarity?initial?condition.');

