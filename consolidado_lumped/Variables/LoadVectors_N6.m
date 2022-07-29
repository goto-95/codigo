% tau coefficient
tau_2 = load('tau_N6_2x2.mat'); tau_2 = tau_2.tau_total;
tau_4 = load('tau_N6_4x4.mat'); tau_4 = tau_4.tau_total;
tau_8 = load('tau_N6_8x8.mat'); tau_8 = tau_8.tau_total;
tau_12 = load('tau_N6_12x12.mat'); tau_12 = tau_12.tau_total;
tau_16 = load('tau_N6_16x16.mat'); tau_16 = tau_16.tau_total;
tau_20 = load('tau_N6_20x20.mat'); tau_20 = tau_20.tau_total;
tau_24 = load('tau_N6_24x24.mat'); tau_24 = tau_24.tau_total;

% Displacement
w_2 = load('w_N6_2x2.mat'); w_2 = w_2.disp;
w_4 = load('w_N6_4x4.mat'); w_4 = w_4.disp;
w_8 = load('w_N6_8x8.mat'); w_8 = w_8.disp;
w_12 = load('w_N6_12x12.mat'); w_12 = w_12.disp;
w_16 = load('w_N6_16x16.mat'); w_16 = w_16.disp;
w_20 = load('w_N6_20x20.mat'); w_20 = w_20.disp;
w_24 = load('w_N6_24x24.mat'); w_24 = w_24.disp;

% STL
STL_2 = load('STL_N6_2x2.mat'); STL_2 = STL_2.STL;
STL_4 = load('STL_N6_4x4.mat'); STL_4 = STL_4.STL;
STL_8 = load('STL_N6_8x8.mat'); STL_8 = STL_8.STL;
STL_12 = load('STL_N6_12x12.mat'); STL_12 = STL_12.STL;
STL_16 = load('STL_N6_16x16.mat'); STL_16 = STL_16.STL;
STL_20 = load('STL_N6_20x20.mat'); STL_20 = STL_20.STL;
STL_24 = load('STL_N6_24x24.mat'); STL_24 = STL_24.STL;