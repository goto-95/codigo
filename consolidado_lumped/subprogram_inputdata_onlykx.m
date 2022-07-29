%DATA SUBSTRATE
E = 7e10; % [Pa]
rho = 2700; %  density[kg/m^3]
h = 1e-3; % thickness [m]
nu = 0.3;
%Damp 0
% eta = 0;
% %Damp1
% eta = 0.001;
% %Damp2
 eta = 0.01;

E = E*(1+1j*eta); % structural damping added


% DATA FOR FLUID LAYERS
rho0 = 1.21; % air density[kg/m^3]
c0 = 340; % speed of sound  [m/s]

% DATA FOR INCIDENCE  WAVE 
theta = deg2rad(50);
%phi=0, so tem contribuicao em kx
phi = deg2rad(0);
%phi=0;
P_inc=1; % Ampltude of incidence wave

% DATA FOR RESONATORS
kr = 9.593e4; %[N/m]
mr = 0.027; %[kg]

%fr = 300 Hz


% FINITE ELEMENT MODEL OF THE PERIODIC CELL
% type of finite element: plate with 4 nodes and 3 dofs per node
dof=3;
nnos_el=4;

%Length of structure
Lx = 0.1; %[m]
Ly = 0.1; %[m]


% Length of one finite element
el_side_x = Lx/nel_x;
el_side_y = Ly/nel_y;

% SPACE HARMONICS

%index of harmonics
N = 6;
m = -N:1:N;
n = -N:1:N;
[MM,NN]=meshgrid(m,n);

nm = length(m);
nn = length(n);
