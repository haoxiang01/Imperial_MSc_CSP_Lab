clc
clear all
close all

array=[-2 0 0; -1 0 0; 0 0 0; 1 0 0; 2 0 0];
load Xaudio/Xaudio.mat
load Ximage/Ximage.mat

%% WH beamformer
Rxx_au = X_au*X_au' / length(X_au(1,:));
Sd = spv(array, [90,0]);
wopt = inv(Rxx_au) * Sd;
Z = my_pattern(array, wopt);
plot2d3d(Z,[0:180],0,'gain in dB','Audio W-H array pattern(90^o)');

yt=wopt'*X_au;
soundsc(real(yt), 11025);

Rxx_im = X_im*X_im' / length(X_im(1,:));
Sd = spv(array, [90,0]);
wopt = inv(Rxx_im) * Sd;
yt=wopt'*X_im;
yt = abs(yt);
yt = (yt-min(yt)) * 255/(max(yt)-min(yt)); % normalize the image to [0,255]
displayimage(yt, image_size, 202,'The received image of W-H beamformer (90^o)');
Z = my_pattern(array, wopt);
plot2d3d(Z,[0:180],0,'gain in dB','Image W-H array pattern (90^o)');

%% superresolution techniques
array=[-2 0 0; -1 0 0; 0 0 0; 1 0 0; 2 0 0];
directions = [30, 0; 35, 0 ; 90, 0];

% DOAs - 30, 35 and 90;
S = spv(array,directions);
Sd = S(:,2); % desired signal is 35

S_J = [S(:,1) S(:,3)]; % DOA of jammer signal

P_J = S_J*inv(S_J'*S_J)*S_J';
P_J_orth = eye(size(P_J))-P_J;

wsuper = P_J_orth*Sd;
Z = my_pattern(array, wsuper);
figure();
plot2d3d(Z,[0:180],0,'gain in dB','Superresolution array pattern (desired-35^o, jammer-30^o & 90^o)');

yt=wsuper'*X_im;
yt = abs(yt);
yt = (yt-min(yt)) * 255/(max(yt)-min(yt)); % normalize the image to [0,255]
figure();
displayimage(yt, image_size, 202,'The received image of Superresolution Beamformer (35^o)');

% DOAs - 30, 35 and 90;
Sd = S(:,1); % desired signal is 30

S_J = [S(:,2) S(:,3)]; % DOA of jammer signal

P_J = S_J*inv(S_J'*S_J)*S_J';
P_J_orth = eye(size(P_J))-P_J;

wsuper = P_J_orth*Sd;
Z = my_pattern(array, wsuper);
figure();
plot2d3d(Z,[0:180],0,'gain in dB','Superresolution array pattern (desired-30^o, jammer-35^o & 90^o)');

yt=wsuper'*X_im;
yt = abs(yt);
yt = (yt-min(yt)) * 255/(max(yt)-min(yt)); % normalize the image to [0,255]
figure();
displayimage(yt, image_size, 202,'The received image of Superresolution Beamformer (30^o)');


%% DOAs - 30, 35 and 90;
Sd = S(:,3); % desired signal is 35

S_J = [S(:,1) S(:,2)]; % DOA of jammer signal

P_J = S_J*inv(S_J'*S_J)*S_J';
P_J_orth = eye(size(P_J))-P_J;

wsuper = P_J_orth*Sd;
Z = my_pattern(array, wsuper);
figure();
plot2d3d(Z,[0:180],0,'gain in dB','Superresolution array pattern (desired-90^o, jammer-30^o & 35^o)');

yt=wsuper'*X_im;
yt = abs(yt);
yt = (yt-min(yt)) * 255/(max(yt)-min(yt)); % normalize the image to [0,255]
figure();
displayimage(yt, image_size, 202,'The received image of Superresolution Beamformer (90^o)');


%% not based on DOA estimation (Theoretical Signal)
array=[-2 0 0; -1 0 0; 0 0 0; 1 0 0; 2 0 0];
directions = [30, 0; 35, 0 ; 90, 0];
S = spv(array,directions);
sigma2 = 0.1; % noise power SNR=10dB

Rmm = eye(3); 
Rxx_theoretical = S*Rmm*S' + sigma2*eye(5,5); 
Sd = S(:,3); % desired signale - 90

R_nJ = Rxx_theoretical - Sd*Sd';

[E, D] = eig(R_nJ);
D = diag(D);
[D,I] = sort(D,'descend');
E = E(:,I);
Ej = []; % eigenvectors of interference subspace
Ej = E(:,1:2);

P_nJ = Ej*inv(Ej'*Ej)*Ej';
P_nJ_orth = eye(size(P_nJ))-P_nJ;
wsuper = P_nJ_orth*Sd;
Z = my_pattern(array, wsuper);
figure();
plot2d3d(Z,[0:180],0,'gain in dB','Superresolution not based on estimation array pattern (desired-90^o)');