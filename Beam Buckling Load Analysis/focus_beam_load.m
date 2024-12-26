clear; clc; close all;

%Critical Load Predictions

E = 10000000; %psi
Irec = 1.6276*10^-4;
Isq = 3.051*10^-4;
L = linspace(0,20,1000);
Arec = 0.125; %in^2
Asq = 0.046875; %in^2

%Pcrit Pinned Pinned

P_critPPRec = pi^2*E*Irec./(L.^2);
P_critPPSq = pi^2*E*Isq./(L.^2);
YieldRec = 35000*Arec;
YieldSq = 35000*Asq;

figure(1)
a = semilogy(L,P_critPPRec,'k');
hold on
b = semilogy(L, YieldRec*ones(length(L)),'--','Color','k');
hold on
c = semilogy(L,P_critPPSq,'-','Color','b');
hold on
d = semilogy(L, YieldSq*ones(length(L)),'--','Color','b');
title('Buckling Load For Simply Supported - Simply Supported')
legend([a(1) b(1) c(1) d(1)], 'Buckling Load Rectangle','Yield Load Rectangle','Buckling Load Square','Yield Load Square')
ylabel('Force (lbs)')
xlabel('Length (in)')


%Pcrit Fixed Fixed

P_critFFRec = pi^2 * E * Irec ./ ((1/2.*L).^2);
P_critFFSq = pi^2 * E * Isq ./ ((1/2.*L).^2);

figure(2)
e = semilogy(L,P_critFFRec,'k');
hold on
f = semilogy(L, YieldRec*ones(length(L)),'--','Color','k');
hold on
g = semilogy(L,P_critFFSq,'b');
hold on
h = semilogy(L, YieldSq*ones(length(L)),'--','Color','b');
title('Buckling Load For Fixed - Fixed')
legend([e(1) f(1) g(1) h(1)], 'Buckling Load Rectangle','Yield Load Rectangle','Buckling Load Square','Yield Load Square')
ylabel('Load (lbs)')
xlabel('Length (in)')
