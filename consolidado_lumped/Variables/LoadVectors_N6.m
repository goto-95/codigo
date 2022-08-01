% tau coefficient
tau_c1 = load('tau_N6_2x2.mat'); tau_c1 = tau_c1.tau_total;
tau_c2 = load('tau_N6_4x4.mat'); tau_c2 = tau_c2.tau_total;
tau_c3 = load('tau_N6_8x8.mat'); tau_c3 = tau_c3.tau_total;
tau_c4 = load('tau_N6_12x12.mat'); tau_c4 = tau_c4.tau_total;
tau_c5 = load('tau_N6_16x16.mat'); tau_c5 = tau_c5.tau_total;
tau_c6 = load('tau_N6_20x20.mat'); tau_c6 = tau_c6.tau_total;
tau_c7 = load('tau_N6_24x24.mat'); tau_c7 = tau_c7.tau_total;

% STL
stl_c1 = -10*log10(tau_c1);
stl_c2 = -10*log10(tau_c2);
stl_c3 = -10*log10(tau_c3);
stl_c4 = -10*log10(tau_c4);
stl_c5 = -10*log10(tau_c5);
stl_c6 = -10*log10(tau_c6);
stl_c7 = -10*log10(tau_c7);

% Displacement
w_c1 = load('w_N6_2x2.mat'); w_c1 = w_c1.disp;
w_c2 = load('w_N6_4x4.mat'); w_c2 = w_c2.disp;
w_c3 = load('w_N6_8x8.mat'); w_c3 = w_c3.disp;
w_c4 = load('w_N6_12x12.mat'); w_c4 = w_c4.disp;
w_c5 = load('w_N6_16x16.mat'); w_c5 = w_c5.disp;
w_c6 = load('w_N6_20x20.mat'); w_c6 = w_c6.disp;
w_c7 = load('w_N6_24x24.mat'); w_c7 = w_c7.disp;

