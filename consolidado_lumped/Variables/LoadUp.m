% FREQUENCY VECTOR DATA
fmin = 50; %[Hz]
df = 5; %[Hz]
fmax = 6000; %[Hz]

freq=fmin:df:fmax;

% Definig the relative and absolute difference functions
drel = @(u,v) max(abs((u-v)./u))*100;
dabs = @(u,v) max(abs(u-v));

% Choosing wich setup to load
N = 6;

% Loading the vectors
% LoadVectors_N5;
LoadVectors_N6;


% Ploting
figure; semilogx( freq, STL_2, freq, STL_4, freq, STL_8, freq, STL_12, freq, STL_16,...
    freq, STL_20, freq, STL_24);
grid on;

figure; semilogx( freq, tau_2, freq, tau_4, freq, tau_8, freq, tau_12, freq, tau_16,...
    freq, tau_20, freq, tau_24);
grid on;

