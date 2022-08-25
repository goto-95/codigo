clear
clc

% FREQUENCY VECTOR DATA
fmin = 50; %[Hz]
df = 5; %[Hz]
fmax = 6000; %[Hz]

freq=fmin:df:fmax;

% Definig the relative and absolute difference functions
drel = @(u,v) max(abs((u-v)./u))*100;
dabs = @(u,v) max(abs(u-v));
rmse = @(u,v) ( abs( rms(v) - rms(u))/rms(u) )*100;

% Loading the vectors
% LoadVectors_N5;
% LoadVectors_N6;
% LoadVectors_16x16_4res;
LoadVectors_N5_4res;


% Computing the differences
fprintf('-------------------------------------------------------\n')
fprintf('delta_tau \n');
disp( drel(tau_c1, tau_c2) );
disp( drel(tau_c2, tau_c3) );
disp( drel(tau_c3, tau_c4) );
disp( drel(tau_c4, tau_c5) );
disp( drel(tau_c5, tau_c6) );
% disp( drel(tau_c6, tau_c7) );
fprintf('-------------------------------------------------------\n')
fprintf('delta_w \n');
disp( drel(w_c1, w_c2) );
disp( drel(w_c2, w_c3) );
disp( drel(w_c3, w_c4) );
disp( drel(w_c4, w_c5) );
disp( drel(w_c5, w_c6) );
% disp( drel(w_c6, w_c7) );
fprintf('-------------------------------------------------------\n')
fprintf('delta_STL \n');
disp( dabs(stl_c1, stl_c2) );
disp( dabs(stl_c2, stl_c3) );
disp( dabs(stl_c3, stl_c4) );
disp( dabs(stl_c4, stl_c5) );
disp( dabs(stl_c5, stl_c6) );
% disp( dabs(stl_c6, stl_c7) );
fprintf('-------------------------------------------------------\n')
fprintf('RMSE tau \n');
disp( rmse(tau_c1, tau_c2) );
disp( rmse(tau_c2, tau_c3) );
disp( rmse(tau_c3, tau_c4) );
disp( rmse(tau_c4, tau_c5) );
disp( rmse(tau_c5, tau_c6) );
% disp( rmse(tau_c6, tau_c7) );
fprintf('-------------------------------------------------------\n')



% Ploting
% figure; semilogx( freq, STL_2, freq, STL_4, freq, STL_8, freq, STL_12, freq, STL_16,...
%     freq, STL_20, freq, STL_24);
% grid on;

% figure; semilogx( freq, tau_2, freq, tau_4, freq, tau_8, freq, tau_12, freq, tau_16,...
%     freq, tau_20, freq, tau_24);
% grid on;

