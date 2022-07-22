function [N,detJ]= Quad_matricial(csi,eta,xcoord,ycoord)

%Entradas
% csi e eta sao escalares (dependem do ponto de integracao)
% xcoord e ycoord sao matrizes
%Saidas
%N - funcao de forma para um ponto de Gauss especifico
%detJ - vetor com os determinates de um ponto de gauss especifico para
%todos os elementos

N= [0.25*(1-csi)*(1-eta);
 0.25*(1+csi)*(1-eta);
 0.25*(1+csi)*(1+eta);
 0.25*(1-csi)*(1+eta)];

 dcsi=0.25*[-(1-eta),(1-eta),...
      (1+eta),-(1+eta)];
 deta =0.25*[ -(1-csi), -(1+csi),...
            (1+csi),(1-csi)];
        
 %B= [dcsi;deta];  
 
%  jac= B*[ xi yi;
%           xj yj;
%           xk yk;
%           xl yl];
      
%  jac = zeros(2,2);
% 
% for i=1:4
%     jac = jac + [dcsi(i); deta(i)]*[xcoord(i),ycoord(i)];
% end     
%       

%Ajustado para matricial

J11= dcsi*xcoord;
J12 = dcsi*ycoord; 
J21 = deta*xcoord;
J22 = deta*ycoord;

%operacao do determinante
detJ = J11.*J22-J12.*J21;
 
end
        


