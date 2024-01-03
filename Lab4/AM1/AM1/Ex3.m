load Xaudio/Xaudio.mat
load Ximage/Ximage.mat
soundsc(real(X_au(2,:)), 11025);
displayimage(X_im(2,:),image_size, 201,'The received signal at the 2nd antenna');

% covariance matrix in practice
Rxx_au = X_au*X_au' / length(X_au(1,:));
Rxx_im = X_im*X_im' / length(X_im(1,:));