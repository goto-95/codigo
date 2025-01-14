%% FRFs for a 2D plate structure
%
format long
clear; close all; clc

load input_data

%% Grid generation

dx = L/nel_lat; % 10 cm
Nel_side = L/dx; 

Nx = Nel_side + 1; 

Lgrid = -L/2:L/Nel_side:L/2;
Ngrid = length(Lgrid);
nnode = Ngrid^2; % number of nodes
nodes = zeros(nnode,2);

for iry=1:Ngrid
    y = Lgrid(iry);
    for irx=1:Ngrid
        x = Lgrid(irx);
        nodes( (iry-1)*Ngrid + irx, : ) = [ x y ];
    end
end

%% Nodal connectivity or Incidence Matrix 

elem = zeros((Ngrid-1)^2,4);
iel=1;

for iy=1:Ngrid-1
    for ix=1:Ngrid-1
        
        % [ 4 3 ]
        % [ 1 2 ]
        
        n1 = (iy-1)*Ngrid + ix;
        n2 = (iy-1)*Ngrid + ix+1;
        n3 = iy*Ngrid + ix+1;
        n4 = iy*Ngrid + ix;
        
        elem(iel,:) = [ n1 n2 n3 n4 ]; % material 1
       
        iel = iel+1;
        
    end
    
end

numberNodes = size(nodes,1)
numberElements = size(elem,1)

inci_aux = 1:1:numberElements;
inci = [inci_aux', elem];

%% Drawing Mesh
figure, hold on

% element
for iel=1:size(elem,1)
    nodes_el = elem(iel,1:4);
    coord_nodes = nodes(nodes_el,:);
    fill(coord_nodes(:,1),coord_nodes(:,2), [1 1 1]);
    text(mean(coord_nodes(:,1)),mean(coord_nodes(:,2)),num2str(iel),'Color',[1 0 0])
end

% nodes
for in=1:size(nodes,1)
    scatter(nodes(in,1),nodes(in,2),'k')
    text(nodes(in,1),nodes(in,2),num2str(in))
end

%% Structure:
% K: stiffness matrix
% M: mass matrix
% dof: degrees of freedom per node
% GDof: global number of degrees of freedom
% nnos_el: Number of nodes per element
dof = 3; 
GDof = dof*numberNodes;
nnos_el = 4;

%% Szilard Model
% % Stiffness and mass matrices
% [Ke,Me]= K_M_plate_kirclove_2(E,h,nu,rho,dx,dx);

% % Assembly of global M andK matrices
% [KG,MG]= assembly_K_M_2(Ke,Me,dof,numberElements,nnos_el,GDof,inci);


%% Kirchoff Model 2020
% [KG,MG] = feKirchhoffPlateMatrix(nodes,elem,dof,E,nu,rho,h);

%% Kirchoff Model 2022

kircchoff_model

%% Mass- spring system
kr = 4*(pi^2)*(fr^2)*mr; % [N/m] Stiffness based on nat. freq. and resonator mass

%% Updating K and M
numberRes = numberElements/4;
prescribedNodes = [1:2*Ngrid:421,3,5,7,15,17,19,21:2*Ngrid:441,423:2:439 ]; % simply supported - no translation

lr = length(node_res);

for g=1:lr-1
    
    l_aux = Ngrid*2*ones(1,lr)+node_res(g,:);
    node_res =[node_res; l_aux];
    
end

node_res = sort(reshape(node_res,[1,numberRes]));
z_dof_res = (node_res-ones(1,numberRes))*dof+ones(1,numberRes);
dof_res = GDof+1:GDof+numberRes;


% increasing matrix size
K_new= zeros(GDof+numberRes);
M_new= zeros(GDof+numberRes);

K_new(1:GDof, 1: GDof) = KG;
M_new(1:GDof, 1: GDof) = MG;

% inserting data from spring-mass system
for rr=1:numberRes
K_new(z_dof_res(rr),z_dof_res(rr)) = K_new(z_dof_res(rr),z_dof_res(rr))+kr;

K_new(z_dof_res(rr),dof_res(rr)) = K_new(z_dof_res(rr),dof_res(rr)) - kr;

K_new(dof_res(rr),z_dof_res(rr)) = K_new(dof_res(rr),z_dof_res(rr))-kr;

K_new(dof_res(rr),dof_res(rr)) = K_new(dof_res(rr),dof_res(rr))+kr;


M_new(dof_res(rr),dof_res(rr)) = M_new(dof_res(rr),dof_res(rr))+mr;


end

%% Boundary conditions 
%Pescribed Dofs based on prescribed nodes
%Simpply supported - Translation is removed
prescribedDofs = prescribedNodes*dof - 2*ones(1,length(prescribedNodes));

activeDofs =setdiff(1:1:GDof+numberRes, prescribedDofs);

%% Natural frequencies

[V,D] = eig(K_new(activeDofs, activeDofs), M_new(activeDofs,activeDofs));
aux = diag(D);
[aux2,index] = sort(aux);
omega_n = sqrt(abs(aux));
freq_n = omega_n/(2*pi);

%% Frequency range
freq = fmin:df:fmax;
omega = 2*pi*freq;
nfreq = length(freq);

% Verifying discretization
lmin = minlfem(E,h,rho, nu,fmax);

if lmin < lx 
    %Warning for innapropriate mesh discretization
   display(lmin,'Innapropriate mesh discretization - lx should be smaller')
end


%% Force vector 

F = zeros(GDof+numberRes,1);
input = (node_force-1)*dof+1;
F(input)= F0; % force in z direction 
%F((node_force-1)*dof+2)= 1;% moment around x   
%F((node_force-1)*dof+3) = 1; %  moment around y 

%% Initializating variables
%Displacements - 
u_z = zeros(1,nfreq);  % Dispalcement at the observed node
u_f = zeros(GDof +numberRes,nfreq); %Displacements for all frequencies
output = (node_obs-1)*dof+1;

for i=1:nfreq
   w =omega(i);
   D = K_new(activeDofs, activeDofs)-(w^2)*M_new(activeDofs, activeDofs);
   
   U = linsolve(D,F(activeDofs,1));

   u = zeros(GDof+numberRes,1);
   u(activeDofs) = U; % inserting zero displacements/rotations caused by BC
   
   u_f(:,i)=u;
   u_z(i) = u(output);
   
end

%% Calculating FRFs 

%Receptance
alfa = u_z/F0;
%Mobility
mob = 1j*alfa.*omega;
%Inertance
inert = -alfa.*(omega.^2);

% figure
% plot(freq,20*log10(abs(alfa)),'LineWidth',2)

% save('inert','inert')
%% Graphs
% figure
% plot(freq,20*log10(abs(alfa)))
% title(['Receptance Plot - Output on node', int2str(node_obs),'intput on node'...
%     ,int2str(node_force)])
% xlabel('Frequency [Hz]')
% ylabel('Receptance [dB - Ref 1m/N]')
% hold on
% stem(freq_n(1:100), ones(100,1)*min(20*log10(abs(alfa))))
% grid on
% 
% figure
% plot(freq,20*log10(abs(alfa)))
% title(['Receptance Plot Zoom  - Output on node', int2str(node_obs),'intput on node'...
%     ,int2str(node_force)])
% xlabel('Frequency [Hz]')
% ylabel('Receptance [dB]')
% xlim([100,400])
% grid on
% saveas(gcf,'recep_zoom_graph.png')
% 
% figure
% plot(freq,20*log10(abs(mob)))
% title(['Mobility Plot -  Output on node', int2str(node_obs),'intput on node'...
%     ,int2str(node_force)])
% xlabel('Frequency [Hz]')
% ylabel('Mobility [dB - Ref 1m/s*N]')
% hold on
% stem(freq_n(1:100), ones(100,1)*min(20*log10(abs(mob))))
% grid on
% 
% figure
% plot(freq,20*log10(abs(mob)))
% title(['Zoom Mobility Plot-  Output on node', int2str(node_obs),'intput on node'...
%     ,int2str(node_force)])
% xlabel('Frequency [Hz]')
% ylabel('Mobility [dB - Ref 1m/s*N]')
% xlim([100,400])
% grid on
% saveas(gcf,'mob_zoom_graph.png')
% 
% figure
% plot(freq,20*log10(abs(inert)))
% title(['Inertance Plot -  Output on node', int2str(node_obs),'intput on node'...
%     ,int2str(node_force)])
% xlabel('Frequency [Hz]')
% ylabel('Inertance [dB - Ref 1m/s^2*N]')
% hold on
% stem(freq_n(1:100), ones(100,1)*min(20*log10(abs(inert))))
% grid on

% figure
% plot(freq,20*log10(abs(inert)))
% title(['Zoom Inertance Plot-  Output on node ', int2str(node_obs),'intput on node '...
%     ,int2str(node_force)])
% xlabel('Frequency [Hz]')
% ylabel('Inertance [dB - Ref 1m/s^2*N]')
% xlim([100,400])
% grid on
% saveas(gcf,'inert_zoom_graph.png')

%configuration of the size of the figure and initial position
figure('Units','inches',...
'Position',[2 2 5.04 3.78],...
'PaperPositionMode','auto');
plot(freq,20*log10(abs(inert)),'LineWidth',2)
% axis label configuration
xlabel({'Frequency [Hz]'},'FontUnits','points',...
'interpreter','latex',...
'FontSize',12,...
'FontName','Times')
ylabel({'Inertance dB ref $1 m/s^2 N$'},'FontUnits','points',...
'interpreter','latex',...
'FontSize',12,...
'FontName','Times')
set(gca,...
'Units','normalized',...
'FontUnits','points',...
'FontWeight','normal',...
'FontSize',12, 'FontName','Times')
xlim([100,1000])
grid on
print -depsc2 inert_1res_mr05.eps



% %% Zoom Frequency range - More discretized in frequency
% fmin2 = 190;
% df2 = 0.01;
% fmax2 = 210;
% 
% freq2 = fmin2:df2:fmax2;
% omega2 = 2*pi*freq2;
% nfreq2 = length(freq2);
% 
% %Displacements - 
% u_z = zeros(1,nfreq2); 
% u_f = zeros(GDof +numberRes,nfreq2);
% 
% for i=1:nfreq2
%    w =omega2(i);
%    D = K_new(activeDofs, activeDofs)-(w^2)*M_new(activeDofs, activeDofs);
%    
%    U = linsolve(D,F(activeDofs,1));
% 
%    u = zeros(GDof+numberRes,1);
%    u(activeDofs) = U; % inserting zero displacements/rotations caused by BC
%    
%    u_f(:,i)=u;
%    u_z(i) = u(output);
%    
% end
% 
% %Receptance
% alfa = u_z/F0;
% %inertance
% inert = -alfa.*(omega.^2);
% 
% figure
% plot(freq2,20*log10(abs(alfa)))
% title('z displacement - node ')
% xlabel('Frequency [Hz]')
% ylabel('Receptance [dB]')
% grid on
% hold on
% stem(freq_n(1:200), ones(200,1)*min(20*log10(abs(alfa))))
% grid on
% xlim([fmin2,fmax2])
% saveas(gcf,'zoom_graph2.png')