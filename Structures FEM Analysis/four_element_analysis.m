
clear;
close all;



%4 modes
E = 10175000; 
rho = 0.0002505; 
L = 12; %in
w = 1; %in
h_fw = 0.125; 
%h_e = .25; 
%h_r = 0.04;
A = w*h_fw;
c_M4 = rho*A*L/806400;
I_zz = w*(h_fw^3)/12;
c_K4 = 8*E*I_zz/(L^3);
M_T = rho*1.131;
S_T = rho*0.5655;
I_T = rho*23.124;




M4 = c_M4*[77088 2916*L 23712 -1284*L 0 0 0 0 0 0; 2916*L 172*L^2 1284*L -73*L^2 0 0 0 0 0 0; 23712 1284*L 154176 0 23712 -1284*L 0 0 0 0;-1284*L -73*L^2 0 344*L^2 1284*L -73*L^2 0 0 0 0;0 0 23712 1284*L 154176 0 23712 -1284*L 0 0;0 0 -1284*L -73*L^2 0 344*L^2 1284*L -73*L^2 0 0;0 0 0 0 23712 1284*L 154176 0 23712 -1284*L;0 0 0 0 -1284*L -73*L^2 0 344*L^2 1284*L -73*L^2;0 0 0 0 0 0 23712 1284*L (77088+(M_T/c_M4)) (-2916*L+(S_T/c_M4));0 0 0 0 0 0 -1284*L -73*L^2 (-2916*L+(S_T/c_M4)) (172*L^2+(I_T/c_M4));]; 

K4 = c_K4*[96 12*L -96 12*L 0 0 0 0 0 0;12*L 2*L^2 -12*L L^2 0 0 0 0 0 0;-96 -12*L 192 0 -96 12*L 0 0 0 0;12*L L^2 0 4*L^2 -12*L L^2 0 0 0 0;0 0 -96 -12*L 192 0 -96 12*L 0 0;0 0 12*L L^2 0 4*L^2 -12*L L^2 0 0;0 0 0 0 -96 -12*L 192 0 -96 12*L;0 0 0 0 12*L L^2 0 4*L^2 -12*L L^2;0 0 0 0 0 0 -96 -12*L 96 -12*L; 0 0 0 0 0 0 12*L L^2 -12*L 2*L^2];


M4_reduced = M4(3:end,3:end);
K4_reduced = K4(3:end,3:end);



[eigen_values, eigen_vectors, w_n, f_n] = Eigen_values(M4_reduced, K4_reduced);





%mode shapes for expiriment
mat_4_1 = K4_reduced - (12.51*2*pi)^2.*M4_reduced; %omega is the frequencey that is closest to the first predicited resonant frequecny (convert to rad)
mat_4_2 = K4_reduced - (49.31*2*pi)^2.*M4_reduced;

[eigen_vector_e1,eigen_values_e1] = eig(mat_4_1); 
[eigen_vector_e2,eigen_values_e2] = eig(mat_4_2);

plot_Eigen_vectors(1, 12.51, L, [0; 0; eigen_vector_e1(:, 1)], 4, 10, 1, 1)
plot_Eigen_vectors(5, 49.31, L, [0; 0; eigen_vector_e2(:, 2)], 4, 10, 1, 2)

%plotting
plot_Eigen_vectors(1, f_n(8,8), L, [0; 0; eigen_vectors(:, 8)], 4, 10, 1, 1)
plot_Eigen_vectors(1, 12.51, L, [0; 0; eigen_vector_e1(:, 1)], 4, 10, 1, 1)

plot_Eigen_vectors(2, f_n(7,7), L, [0; 0; eigen_vectors(:, 7)], 4, 10, 1, 2)
plot_Eigen_vectors(2, 49.31, L, [0; 0; eigen_vector_e2(:, 2)], 4, 10, 1, 2)



plot_Eigen_vectors(3, f_n(6,6), L, [0; 0; eigen_vectors(:, 6)], 4, 10, 1, 3)


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
    plot(x, v, '--o',  'LineWidth', 1);
    xlabel('Horizontal Position [in]');
    hold on
    ylabel('Vertical Position [in]');
    title("Modal Response: Frequency " + string(responseNum) + " with Experimental Data");
    
end


function [eigen_values, eigen_vectors, w_n, f_n] = Eigen_values(M4, K4)
[eigen_vectors, eigen_values] = eig(M4\K4);
w_n = abs(eigen_values).^(1/2);
f_n = w_n./(2*pi);

end



function [eigen_values, eigen_vectors, w_n, f_n] = Eigen_values(M4, K4)
[eigen_vectors, eigen_values] = eig(M4\K4);
w_n = abs(eigen_values).^(1/2);
f_n = w_n./(2*pi);

end