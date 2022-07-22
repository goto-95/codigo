function [Df,V_store_H] = force_fluid2(GDof, numberRes,m_index,n_index,nnode,nelem,elem,nodes,...
    csi_aux,eta_aux,wcsi_aux, weta_aux, dof, Df1mn,kx_aux,ky_aux)

%V_store_H: 3D Matrix: 
% lines: nodes
% columns: harmonics in x (m_index)
% Layers: harmonics in y (n_index)
V_store_H =zeros(nnode,m_index,n_index);

%Df - fluid loading to be added at Dynamic stiffness matrix
Df=zeros(GDof+numberRes,GDof+numberRes); %start summation



% Fluid forces calculated only for displacement degrees of freedom        
Ffluid = zeros(m_index,n_index,nnode);
Ffluid_H = zeros(m_index,n_index,nnode);
          
for uu = 1:nelem
    %Identifying the nodes of the element 
    index2 = elem(uu,:);

    %Identifying coordinates of the nodes
    xcoord2 = nodes(index2,1); %column vector
    ycoord2 = nodes(index2,2);

    %numerical integration   
    no_1 = 0; no_2 = 0; no_3 = 0; no_4 = 0;
    no_1_H = 0; no_2_H = 0; no_3_H = 0; no_4_H = 0;

    for cc =1:length(csi_aux)
        for dd =1:length(eta_aux)
            %Equation 26
            csi2 = csi_aux(cc);
            eta2 = eta_aux(dd);
            [N2,detJ2]= Quad(csi2,eta2,xcoord2,ycoord2);
            x2 = N2.'*xcoord2;
            y2 = N2.'*ycoord2;

            aux_N2 = wcsi_aux(cc)*weta_aux(dd)*N2;

            % Tentando fazer que a função seja avaliada em
            % todas as harmônicas para cada nó, separadamente

            no_1 = aux_N2(1,1)*exp(-1j*((kx_aux*x2)+(ky_aux*y2)))*detJ2 + no_1;
            no_2 = aux_N2(2,1)*exp(-1j*((kx_aux*x2)+(ky_aux*y2)))*detJ2 + no_2;
            no_3 = aux_N2(3,1)*exp(-1j*((kx_aux*x2)+(ky_aux*y2)))*detJ2 + no_3;
            no_4 = aux_N2(4,1)*exp(-1j*((kx_aux*x2)+(ky_aux*y2)))*detJ2 + no_4;

            no_1_H = aux_N2(1,1)*exp(+1j*((kx_aux*x2)+(ky_aux*y2)))*detJ2 + no_1_H;
            no_2_H = aux_N2(2,1)*exp(+1j*((kx_aux*x2)+(ky_aux*y2)))*detJ2 + no_2_H;
            no_3_H = aux_N2(3,1)*exp(+1j*((kx_aux*x2)+(ky_aux*y2)))*detJ2 + no_3_H;
            no_4_H = aux_N2(4,1)*exp(+1j*((kx_aux*x2)+(ky_aux*y2)))*detJ2 + no_4_H;
        end
    end 

    Ffluid(:,:,index2(1)) = Ffluid(:,:, index2(1)) + no_1;
    Ffluid(:,:,index2(2)) = Ffluid(:,:, index2(2)) + no_2;
    Ffluid(:,:,index2(3)) = Ffluid(:,:, index2(3)) + no_3;
    Ffluid(:,:,index2(4)) = Ffluid(:,:, index2(4)) + no_4;

    Ffluid_H(:,:,index2(1)) = Ffluid_H(:,:, index2(1)) + no_1_H;
    Ffluid_H(:,:,index2(2)) = Ffluid_H(:,:, index2(2)) + no_2_H;
    Ffluid_H(:,:,index2(3)) = Ffluid_H(:,:, index2(3)) + no_3_H;
    Ffluid_H(:,:,index2(4)) = Ffluid_H(:,:, index2(4)) + no_4_H;
end
            
for kk = 1:m_index
    for ll =1:n_index
        v1_mn=zeros(GDof+numberRes,1);
        v1_mn_H = zeros(GDof+numberRes,1);
        
%         % adiantando a multiplicação 2*Df1mn*vmn
%         Ffluid = 2*Df1mn.*Ffluid;    
%             
% %         Fluid_test_aux = sum(sum(Ffluid));
% %         Fluid_test_H_aux = sum(sum(Ffluid_H));
%         
%         Ffluid(:) = Fluid_test_aux;
%         Ffluid_H(:) = Fluid_test_H_aux;
        
        %adding rotation degrees of freedom
        v1_mn(1:dof:GDof) = Ffluid(kk,ll,:);
        v1_mn_H(1:dof:GDof) = Ffluid_H(kk,ll,:);
         
          
        %Storing this vector - To be used in future calculation
        V_store_H(:,kk,ll) = Ffluid_H(kk,ll,:);
          
        %Equation 33
        %(v1_mn_H.')- transpose without the complex conjugate
        Df = Df + 2*Df1mn(kk,ll)*(v1_mn*v1_mn_H.'); %Equation 33
          
    end
end
 
end