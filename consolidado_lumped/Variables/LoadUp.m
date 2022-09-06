clear
clc

% FREQUENCY VECTOR DATA
fmin = 20; %[Hz]
df = 5; %[Hz]
fmax = 6000; %[Hz]

freq = logspace( log10(fmin), log10(fmax), 2e3  );

% Definig the relative and absolute difference functions
drel = @(u,v) max(abs((u-v)./u))*100;
dabs = @(u,v) max(abs(u-v));
rmse = @(u,v) ( abs( rms(v) - rms(u))/rms(u) )*100;

% Loading the vectors
% LoadVectors_N5;
LoadVectors_N6;
% LoadVectors_16x16_4res;
% LoadVectors_N5_4res;


% Computing the differences
fprintf('-------------------------------------------------------\n')
fprintf('delta_tau \n');
disp( drel(tau_c1, tau_c2) );
disp( drel(tau_c2, tau_c3) );
disp( drel(tau_c3, tau_c4) );
disp( drel(tau_c4, tau_c5) );
disp( drel(tau_c5, tau_c6) );
disp( drel(tau_c6, tau_c7) );
disp( drel(tau_c7, tau_c8) );
disp( drel(tau_c8, tau_c9) );
fprintf('-------------------------------------------------------\n')
fprintf('delta_w \n');
disp( drel(w_c1, w_c2) );
disp( drel(w_c2, w_c3) );
disp( drel(w_c3, w_c4) );
disp( drel(w_c4, w_c5) );
disp( drel(w_c5, w_c6) );
disp( drel(w_c6, w_c7) );
disp( drel(w_c7, w_c8) );
disp( drel(w_c8, w_c9) );
fprintf('-------------------------------------------------------\n')
fprintf('delta_STL \n');
disp( dabs(stl_c1, stl_c2) );
disp( dabs(stl_c2, stl_c3) );
disp( dabs(stl_c3, stl_c4) );
disp( dabs(stl_c4, stl_c5) );
disp( dabs(stl_c5, stl_c6) );
disp( dabs(stl_c6, stl_c7) );
disp( dabs(stl_c7, stl_c8) );
disp( dabs(stl_c8, stl_c9) );
fprintf('-------------------------------------------------------\n')
fprintf('RMSE tau \n');
disp( rmse(tau_c1, tau_c2) );
disp( rmse(tau_c2, tau_c3) );
disp( rmse(tau_c3, tau_c4) );
disp( rmse(tau_c4, tau_c5) );
disp( rmse(tau_c5, tau_c6) );
disp( rmse(tau_c6, tau_c7) );
disp( rmse(tau_c7, tau_c8) );
disp( rmse(tau_c8, tau_c9) );
fprintf('-------------------------------------------------------\n')



%% Ploting
figure; semilogx( freq, stl_c1, freq, stl_c2, freq, stl_c3, freq, stl_c4, freq, stl_c5,...
    freq, stl_c6, freq, stl_c7, freq, stl_c8, freq, stl_c9);
grid on;
legend('Mesh - 2x2', 'Mesh - 4x4', 'Mesh - 8x8', 'Mesh - 12x12', 'Mesh - 16x16', ...
    'Mesh - 20x20', 'Mesh - 24x24', 'Mesh - 28x28', 'Mesh - 32x32')
xlim([0 6e3])

% figure; semilogx( freq, tau_2, freq, tau_4, freq, tau_8, freq, tau_12, freq, tau_16,...
%     freq, tau_20, freq, tau_24);
% grid on;

