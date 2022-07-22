function [Df,V_store] = force_fluid(GDof, numberRes,m,n,nm,nn,nnode,nelem,elem,nodes,...
    csi_aux,eta_aux,mu_x,mu_y, Lx, Ly , node_res_first, dof,w, kr,mr, Df1mn)


n_gauss = length(length(csi_aux)*length(eta_aux)); %number of gauss points
n_node_elem = 4; %number of nodes per element
%Matrix for the storage of v1 vectors
V_store =zeros(nm,nn,GDof+numberRes);

Df=zeros(GDof+numberRes,GDof+numberRes); % Matrix to start summation

 for kk = 1:nm
  for ll =1:nn
          
              v1_mn=zeros(GDof+numberRes,1);
              %Alterar - sera uma matriz
              %Ffluid = zeros(nnode,1);
          
%Loop for each element was removed
%           for uu = 1:nelem
              
              %Identifying the nodes of the element 
              index2 = elem(:,:);
              %%Identifying coordinates of the nodes
%               xcoord2 = nodes(index2,1);
              % Ate aqui ta ok :)
              xcoord2 = reshape(nodes(index2',1),4,nelem); %matrix where each column are the x coordinates of the nodes in each element 
              %matriz onde cada coluna são as coordenadas x de cada elemento
              ycoord2 = reshape(nodes(index2',2),4,nelem);%matrix where each column are the y coordinates of the nodes in each element 

              
              %numerical integration
              %
              f_fluid_elems= zeros(n_node_elem,nelem,n_gauss); % matrix to store the force fluid calculated for each gauss point
              
              ng =0;
              
              for cc =1:2
                  for dd =1:2
              
                  %counting for iterations
                  ng = ng+1;

                  %Equation 26
                  csi2 = csi_aux(cc);
                  eta2 = eta_aux(dd);

                  % Desafio 01: Adaptar a função Quad para aceitar o as matrizes de coordenadas de todos os elementos 
                  [N2,detJ2]= Quad_matricial(csi2,eta2,xcoord2,ycoord2);
                  x2 = N2'*xcoord2;
                  y2 = N2'*ycoord2;
                  % point to point multiplication 
                  e_aux = exp(-1j*((mu_x+2*m(kk)*x2/Lx)+(mu_y+2*n(ll)*y2/Ly))).*detJ2;
                  
                  force_fluid_el = N2*e_aux;
                  f_fluid_elems(:,:,ng) = force_fluid_el;
              
                      
                  end
              end 
              
              %Summing the contributions of each gauss point to the forces
              %in each element
              
              F_fluid_elems = zeros(n_node_elem,nelem);
              for g =1:ng
              F_fluid_elems = f_fluid_elems(:,:,g) + F_fluid_elems;
              
              end
              
              
              % Desafio 02: Adaptar os índices corretamente para vetor de
              % força de fluido (antes recebia somente um escalar para cada elemento
              % Dica: tenta com a transposta do index2 
              
              %Ffluid(index2) = Ffluid(index2)+f_fluid;  
              %F_aux = F_fluid(index2')
              
%           end - end loop for number of elements

%             G_aux = zeros(nnode, nelem);
%             It = eye(nnode,nnode);
%             for cont=1:nelem
%                 ind = index2(cont,:);
%                 a = It(ind,:);
%                 G_aux = G_aux + a'*F_fluid_elems; 
%             end
            
            G_aux = zeros(nnode,nelem);
            
             for cont = 1:nelem
                 ind = elem(cont,:);
                 G_aux(ind,cont)=F_fluid_elems(:,cont);
                
             end
            
            
            Ffluid = sum(G_aux,2); %sum of the elements of the rows
%             


          





%%%%%%%%%%%%%%%%%%%%%%%%%manter
%%%%%%%%%%%%%%%%%%%%%%%%%igual%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          %adding rotation degrees of freedom
          v1_mn(1:3:GDof) = Ffluid;
          %expression for the displacement at the resonator mass
          v1_mn(GDof+numberRes)=v1_mn(node_res_first*dof-2)/(1-(w/sqrt(kr/mr))); 
          
          %Storing this vector 
          V_store(kk,ll,:) = v1_mn;
          
          %Equation 33
          Df = Df + 2*Df1mn(kk,ll)*(v1_mn*v1_mn'); %Equation 33
          
          
  end
 end