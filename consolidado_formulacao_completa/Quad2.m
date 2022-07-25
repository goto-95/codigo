function [N,detJ]= Quad2(csi,eta,xcoord,ycoord)

N= [0.25*(1-csi).*(1-eta);
 0.25*(1+csi).*(1-eta);
 0.25*(1+csi).*(1+eta);
 0.25*(1-csi).*(1+eta)];

 dcsi=0.25*[-(1-eta);
           (1-eta);
           (1+eta);
           -(1+eta)];
       
 deta =0.25*[ -(1-csi);
            -(1+csi);
            (1+csi);
            (1-csi)];
        
 B= [dcsi.';deta.'];  
 
 jac= B*[ xcoord, ycoord];
         
      
%  jac = zeros(2,2);
%  N = zeros(4,length(csi)*length(eta));
% for i=1:4
%     N(:,1) = [ 0.25*(1-csi()).*(1-eta());
%                0.25*(1+csi()).*(1-eta());
%                0.25*(1+csi()).*(1+eta());
%                0.25*(1-csi()).*(1+eta())];

%     jac = jac + [dcsi(i); deta(i)]*[xcoord(i),ycoord(i)];
% end     
      
      
 detJ = det(jac);
 
end
        


