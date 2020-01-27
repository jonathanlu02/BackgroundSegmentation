% Jonathan Lu
% AMATH 482
% HW3 - Identifying Music
% 2/16/17
close all; clc

vidFrames = processVid('test1.mov');
X = vid2Data(vidFrames);

t=1:121; %298 frames
dt = 1; %1 frame 

X1 = X(:, 1:end-1);
X2 = X(:, 2:end);
[U2,S2,V2] = svd(X1, 'econ');

figure(1)
plot(100*diag(S2)/sum(diag(S2)), 'ko')
xlabel('\sigma_x')
ylabel('Percentage (%)')
title('Dominance of \sigma_x')

r = 50; %rank
U=U2(:,1:r);
S=S2(1:r,1:r);
V=V2(:,1:r);

%% DMD J-Tu Algorithm %%
Atilde = U'*X2*V/S; % embed into low rank space
[W,D] = eig(Atilde);
Phi = X2*V/S*W; %U*W, DMD modes

mu = diag(D); % eigenvalues
omega = log(mu)/dt; % linear scale of eigenvalues.

u0 = X(:,1); %project onto b, take first snapshot
b = Phi\u0; %pseudo-inv initial conditions

[M,I] = min(abs(omega));
A1 = Phi(:,I)*b(I);

d = zeros(1,121);
for j = 1:121
   d(j) = exp(M*j);
end

xLow = A1*d; %calculate low rank matrix
xSparse = X1-abs(xLow);
R = xSparse; %construct residuals
R(xSparse>0)=0;  %set all pos values of resid to 0
xSparse(xSparse<0) = 0; %remove residuals from xsparse
xLow = abs(xLow) + R; %low rank foreground info
x_f = reshape(xLow, 480, 270, 121);
x_b = reshape(xSparse, 480, 270, 121);
implay(x_f)
implay(x_b)






