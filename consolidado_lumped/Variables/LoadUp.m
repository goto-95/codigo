% FREQUENCY VECTOR DATA
fmin = 50; %[Hz]
df = 5; %[Hz]
fmax = 6000; %[Hz]

freq=fmin:df:fmax;

% Definig the relative and absolute difference functions
drel = @(u,v) max(abs((u-v)./u))*100;
dabs = @(u,v) max(abs(u-v));

% Loading the vectors
% tau coefficient
tau_2 = load('tau_2x2.mat'); tau_2 = tau_2.tau_total;
tau_4 = load('tau_4x4.mat'); tau_4 = tau_4.tau_total;
tau_8 = load('tau_8x8.mat'); tau_8 = tau_8.tau_total;
tau_12 = load('tau_12x12.mat'); tau_12 = tau_12.tau_total;
tau_16 = load('tau_16x16.mat'); tau_16 = tau_16.tau_total;
tau_20 = load('tau_20x20.mat'); tau_20 = tau_20.tau_total;
tau_24 = load('tau_24x24.mat'); tau_24 = tau_24.tau_total;

% Displacement
w_2 = load('w_2x2.mat'); w_2 = w_2.disp;
w_4 = load('w_4x4.mat'); w_4 = w_4.disp;
w_8 = load('w_8x8.mat'); w_8 = w_8.disp;
w_12 = load('w_12x12.mat'); w_12 = w_12.disp;
w_16 = load('w_16x16.mat'); w_16 = w_16.disp;
w_20 = load('w_20x20.mat'); w_20 = w_20.disp;
w_24 = load('w_24x24.mat'); w_24 = w_24.disp;

% STL
STL_2 = load('STL_2x2.mat'); STL_2 = STL_2.disp;
STL_4 = load('STL_4x4.mat'); STL_4 = STL_4.STL;
STL_8 = load('STL_8x8.mat'); STL_8 = STL_8.STL;
STL_12 = load('STL_12x12.mat'); STL_12 = STL_12.STL;
STL_16 = load('STL_16x16.mat'); STL_16 = STL_16.STL;
STL_20 = load('STL_20x20.mat'); STL_20 = STL_20.STL;
STL_24 = load('STL_24x24.mat'); STL_24 = STL_24.STL;


% Ploting
figure; semilogx( freq, STL_2, freq, STL_4, freq, STL_8, freq, STL_12, freq, STL_16,...
    freq, STL_20, freq, STL_24);
grid on;

figure; semilogx( freq, tau_2, freq, tau_4, freq, tau_8, freq, tau_12, freq, tau_16,...
    freq, tau_20, freq, tau_24);
grid on;

