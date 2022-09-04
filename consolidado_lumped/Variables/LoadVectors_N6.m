% tau coefficient
tau_c1 = load('tau_N6_2x2_log_1res.mat'); tau_c1 = tau_c1.tau_total;
tau_c2 = load('tau_N6_4x4_log_1res.mat'); tau_c2 = tau_c2.tau_total;
tau_c3 = load('tau_N6_8x8_log_1res.mat'); tau_c3 = tau_c3.tau_total;
tau_c4 = load('tau_N6_12x12_log_1res.mat'); tau_c4 = tau_c4.tau_total;
tau_c5 = load('tau_N6_16x16_log_1res.mat'); tau_c5 = tau_c5.tau_total;
tau_c6 = load('tau_N6_20x20_log_1res.mat'); tau_c6 = tau_c6.tau_total;
tau_c7 = load('tau_N6_24x24_log_1res.mat'); tau_c7 = tau_c7.tau_total;
tau_c8 = load('tau_N6_28x28_log_1res.mat'); tau_c8 = tau_c8.tau_total;
tau_c9 = load('tau_N6_32x32_log_1res.mat'); tau_c9 = tau_c9.tau_total;

% STL
stl_c1 = -10*log10(tau_c1);
stl_c2 = -10*log10(tau_c2);
stl_c3 = -10*log10(tau_c3);
stl_c4 = -10*log10(tau_c4);
stl_c5 = -10*log10(tau_c5);
stl_c6 = -10*log10(tau_c6);
stl_c7 = -10*log10(tau_c7);
stl_c8 = -10*log10(tau_c8);
stl_c9 = -10*log10(tau_c9);

% Displacement
w_c1 = load('w_N6_2x2_log_1res.mat'); w_c1 = w_c1.disp;
w_c2 = load('w_N6_4x4_log_1res.mat'); w_c2 = w_c2.disp;
w_c3 = load('w_N6_8x8_log_1res.mat'); w_c3 = w_c3.disp;
w_c4 = load('w_N6_12x12_log_1res.mat'); w_c4 = w_c4.disp;
w_c5 = load('w_N6_16x16_log_1res.mat'); w_c5 = w_c5.disp;
w_c6 = load('w_N6_20x20_log_1res.mat'); w_c6 = w_c6.disp;
w_c7 = load('w_N6_24x24_log_1res.mat'); w_c7 = w_c7.disp;
w_c8 = load('w_N6_28x28_log_1res.mat'); w_c8 = w_c8.disp;
w_c9 = load('w_N6_32x32_log_1res.mat'); w_c9 = w_c9.disp;

