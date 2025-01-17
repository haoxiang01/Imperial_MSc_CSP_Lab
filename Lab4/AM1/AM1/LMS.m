clc
clear
close

array=[-2 0 0; -1 0 0; 0 0 0; 1 0 0; 2 0 0];
directions = [30, 0; 35, 0 ; 90, 0];

% random source signal from 3 directions
L = 250;
N = size(array, 1);
M = size(directions,1);
m_t = (randn(M,L) + 1i*randn(M,L)) / sqrt(2);

% random noise
sigma2 = 0.0001;
noise = sqrt(sigma2) * (randn(N,L) + 1i*randn(N,L)) / sqrt(2);
S = spv(array,directions);

% received signal
X = S * m_t + noise;

% covariance matrix
Rxx = X*X' / length(X(1,:));

Sd = spv(array,[90,0]);

% LMS 
di = m_t(3,:);
u = 0.0005;
w = zeros(N,1);  

for k = 1:size(X,2)
    y(k) = w'*X(:,k);
    e(k) = di(k) - y(k);
    w = w + u * X(:,k) * conj(e(k));
end

Z = my_pattern(array, w);
plot2d3d(Z,[0:180],0,'gain in dB','250 Snapshots LMS Array Pattern');