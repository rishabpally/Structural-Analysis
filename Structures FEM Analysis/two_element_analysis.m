clc; clear; close all;

L = 12; %cantilever span S'B' [in]
L_E = 4.5; %elevator san [in]
L_R = 5; %rudder span [in]
w = 1; %width of all members [in]
h = 1/8; %thickness of fuselage memeber [in]
h_E = 1/4; %thickness of elevator [in]
h_R = 0.040; %thickness of rudder member [in]
E = 10175000; %material elastic modulus [lb/in^2]
rho = 0.0002505; %material mass density [lb-sec^2/in^4]
M_T = 1.131*rho; %mass of tail assembly
S_T = 0.5655*rho; %first mass-moment of tail assembly wrt B'
I_T = 23.124*rho; %second mass-moment of tail assembly wrt B'

A = w*h;
Izz = (w*h^3)/12;

cM2 = rho*A*L/100800;
cK2 = 4*E*Izz/L^3; 

M2 = cM2*[19272 1458*L 5928 -642*L 0 0;...
           1458*L 172*L^2 642*L -73*L^2 0 0;...
           5928 642*L 38544 0 5928 -642*L;...
           -642*L -73*L^2 0 344*L^2 642*L -73*L^2;...
           0 0 5928 642*L 19272 -1458*L;...
           0 0 -642*L -73*L^2 -1458*L 172*L^2]...
         +[0 0 0 0 0 0;...
           0 0 0 0 0 0;...
           0 0 0 0 0 0;...
           0 0 0 0 0 0;...
           0 0 0 0 M_T S_T;...
           0 0 0 0 S_T I_T];
       
 K2 = cK2*[24 6*L -24 6*L 0 0;...
            6*L 2*L^2 -6*L L^2 0 0;...
            -24 -6*L 48 0 -24 6*L;...
            6*L L^2 0 4*L^2 -6*L L^2;...
            0 0 -24 -6*L 24 -6*L;...
            0 0 6*L L^2 -6*L 2*L^2];
        
 M2(1,:) = [];
 M2(1,:) = [];
 M2(:,1) = [];
 M2(:,1) = [];
 K2(:,1) = [];
 K2(:,1) = [];
 K2(1,:) = [];
 K2(1,:) = [];
 
 M2_hat = M2;
 K2_hat = K2;

[eigen_values, eigen_vectors, w_n, f_n] = Eigen_values(M2_hat, K2_hat);


%plotting
plot_Eigen_vectors(1, f_n(4,4), L, [0; 0; eigen_vectors(:, 4)], 2, 10, 1, 1)
plot_Eigen_vectors(2, f_n(3,3), L, [0; 0; eigen_vectors(:, 3)], 2, 10, 1, 2)
plot_Eigen_vectors(3, f_n(2,2), L, [0; 0; eigen_vectors(:, 2)], 2, 10, 1, 3)


mat_2_1 = K2_hat - (12.51*2*pi)^2.*M2_hat; %omega is the frequencey that is closest to the first predicited resonant frequecny (convert to rad)
mat_2_2 = K2_hat - (49.31*2*pi)^2.*M2_hat;

[eigen_vector_e1,eigen_values_e1] = eig(mat_2_1); 
[eigen_vector_e2,eigen_values_e2] = eig(mat_2_2);

plot_Eigen_vectors(4, 12.51, L, [0; 0; eigen_vector_e1(:, 1)], 2, 10, 1, 1)
plot_Eigen_vectors(5, 49.31, L, [0; 0; eigen_vector_e2(:, 2)], 2, 10, 1, 2)

%plotting
plot_Eigen_vectors(1, f_n(4,4), L, [0; 0; eigen_vectors(:, 4)], 2, 10, 1, 1)
plot_Eigen_vectors(2, f_n(3,3), L, [0; 0; eigen_vectors(:, 3)], 2, 10, 1, 2)
plot_Eigen_vectors(1, 12.51, L, [0; 0; eigen_vector_e1(:, 1)], 2, 10, 1, 1)
plot_Eigen_vectors(2, 49.31, L, [0; 0; eigen_vector_e2(:, 2)], 2, 10, 1, 2)


function plot_Eigen_vectors(fig, freq, L, ev, ne, nsub, scale, responseNum)
    nv=ne*nsub+1; Le=L/ne; dx=Le/nsub; k=1;
    x=zeros(1,nv); % declare and set to zero plot arrays
    v=zeros(1,nv); % declare and set to zero plot arrays
    for e = 1:ne
        xi=Le*(e-1); vi=ev(2*e-1); qi=ev(2*e); vj=ev(2*e+1); qj=ev(2*e+2);
        for n = 1:nsub
            xk=xi+dx*n; X=(2*n-nsub)/nsub;
            vk=scale*(0.125*(4*(vi+vj)+2*(vi-vj)*(X^2-3)*X+Le*(X^2-1)*(qj-qi+(qi+qj)*X)));
            k = k+1; x(k)=xk; v(k)=vk;
        end
    end
    

    %plots
    f = figure(fig);
    hold on;
    plot(x, v,'--o', 'LineWidth', 1);
    hold on
    xlabel('Horizontal Position [in]');
    ylabel('Vertical Position [in]');
    title("Modal Response: Frequency " + string(responseNum) + " with Experimental Data");
end


function [eigen_values, eigen_vectors, w_n, f_n] = Eigen_values(M2, K2)
[eigen_vectors, eigen_values] = eig(M2\K2);
w_n = abs(eigen_values).^(1/2);
f_n = w_n./(2*pi);

end