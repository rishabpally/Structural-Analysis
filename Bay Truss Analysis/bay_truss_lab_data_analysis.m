% 3112: Bay Truss Lab Data Analysis - Group 8
%Housekeeping
clc;
clear all;
close all;
%Main Code
[loadcase,F0,F1,F2,F3D,LVDT] = unPack('Test 08');

%Givens
L = 0.250; %[mm] joint to joint
d = 9.525; %[mm] bar diameter
t = 1.587; %[mm] bar thickness
E = 70;    %[GPa] Elastic modulus of 6061-T6 Al


%Zero Load Case
F0_0 = [F0(1:10);F0(106:115)];
F1_0 = [F1(1:10);F1(106:115)];
F2_0 = [F2(1:10);F2(106:115)];
F3D_0 = [F3D(1:10);F3D(106:115)];
LVDT_0 = [LVDT(1:10);LVDT(106:115)];

F0_0avg = mean(F0_0);
F1_0avg = mean(F1_0);
F2_0avg = mean(F2_0);
F3D_0avg = mean(F3D_0);
LVDT_0avg = mean(LVDT_0);

%10lbs Load Case
F0_10 = [F0(11:23);F0(96:105)];
F1_10 = [F1(11:23);F1(96:105)];
F2_10 = [F2(11:23);F2(96:105)];
F3D_10 = [F3D(11:23);F3D(96:105)];
LVDT_10 = [LVDT(11:23);LVDT(96:105)];

F0_10avg = mean(F0_10);
F1_10avg = mean(F1_10);
F2_10avg = mean(F2_10);
F3D_10avg = mean(F3D_10);
LVDT_10avg = mean(LVDT_10);

%20lbs Load Case
F0_20 = [F0(24:35);F0(86:95)];
F1_20 = [F1(24:35);F1(86:95)];
F2_20 = [F2(24:35);F2(86:95)];
F3D_20 = [F3D(24:35);F3D(86:95)];
LVDT_20 = [LVDT(24:35);LVDT(86:95)];

F0_20avg = mean(F0_20);
F1_20avg = mean(F1_20);
F2_20avg = mean(F2_20);
F3D_20avg = mean(F3D_20);
LVDT_20avg = mean(LVDT_20);

%30lbs Load Case
F0_30 = [F0(36:45);F0(76:85)];
F1_30 = [F1(36:45);F1(76:85)];
F2_30 = [F2(36:45);F2(76:85)];
F3D_30 = [F3D(36:45);F3D(76:85)];
LVDT_30 = [LVDT(36:45);LVDT(76:85)];

F0_30avg = mean(F0_30);
F1_30avg = mean(F1_30);
F2_30avg = mean(F2_30);
F3D_30avg = mean(F3D_30);
LVDT_30avg = mean(LVDT_30);

%40lbs Load Case
F0_40 = [F0(46:55);F0(66:75)];
F1_40 = [F1(46:55);F1(66:75)];
F2_40 = [F2(46:55);F2(66:75)];
F3D_40 = [F3D(46:55);F3D(66:75)];
LVDT_40 = [LVDT(46:55);LVDT(66:75)];

F0_40avg = mean(F0_40);
F1_40avg = mean(F1_40);
F2_40avg = mean(F2_40);
F3D_40avg = mean(F3D_40);
LVDT_40avg = mean(LVDT_40);

%50lbs Load Case
F0_50 = F0(56:65);
F1_50 = F1(56:65);
F2_50 = F2(56:65);
F3D_50 = F3D(56:65);
LVDT_50 = LVDT(56:65);

F0_50avg = mean(F0_50);
F1_50avg = mean(F1_50);
F2_50avg = mean(F2_50);
F3D_50avg = mean(F3D_50);
LVDT_50avg = mean(LVDT_50);


%Graphical Table
Cases = {'0lbs';'10lbs';'20lbs';'30lbs';'40lbs';'50lbs'};
F0new = [F0_0avg;F0_10avg;F0_20avg;F0_30avg;F0_40avg;F0_50avg];
F1new = [F1_0avg;F1_10avg;F1_20avg;F1_30avg;F1_40avg;F1_50avg];
F2new = [F2_0avg;F2_10avg;F2_20avg;F2_30avg;F2_40avg;F2_50avg];
F3Dnew = [F3D_0avg;F3D_10avg;F3D_20avg;F3D_30avg;F3D_40avg;F3D_50avg];
LVDTnew = [LVDT_0avg;LVDT_10avg;LVDT_20avg;LVDT_30avg;LVDT_40avg;LVDT_50avg];

T = table(F0new,F1new,F2new,F3Dnew,LVDTnew,'RowNames',Cases);

uit = uitable('Data',T{:,:},'ColumnName',T.Properties.VariableNames,'RowName',T.Properties.RowNames,'Units','Normalized','Position',[0,0,1,1]);

%Question 1 Analysis
%F2 is the in-line loading cell and measures internal forces
%LVDT is the displacement
%all others are the reaction forces

%Perform Linear Regression First to Overlay Later

[coeffF0,errorF0] = polyfit(loadcase,F0,1);
F0fit = polyval(coeffF0,loadcase);

[coeffF1,errorF1] = polyfit(loadcase,F1,1);
F1fit = polyval(coeffF1,loadcase);

[coeffF2,errorF2] = polyfit(loadcase,F2,1);
F2fit = polyval(coeffF2,loadcase);

[coeffF3D,errorF3D] = polyfit(loadcase,F3D,1);
F3Dfit = polyval(coeffF3D,loadcase);

[coeffLVDT,errorLVDT] = polyfit(loadcase,LVDT,1);
LVDTfit = polyval(coeffLVDT,loadcase);


%Plotting

figure()
subplot(3,2,1);
scatter(loadcase,F0);
hold on
plot(loadcase,F0,'LineStyle','none');
plot(loadcase,F0fit,'r');
title('Reaction Forces at F_0 vs. Loading Case');
xlabel('Load Case [lbs]');
ylabel('Reaction Force [lbf]');
hold off

subplot(3,2,2);
scatter(loadcase,F1);
hold on
plot(loadcase,F1,'LineStyle','none');
plot(loadcase,F1fit,'b');
title('Reaction Forces at F_1 vs. Loading Case');
xlabel('Load Case [lbs]');
ylabel('Reaction Force [lbf]');
hold off

subplot(3,2,3);
scatter(loadcase,F2);
hold on
plot(loadcase,F2,'LineStyle','none');
plot(loadcase,F2fit,'g');
title('Internal Forces at F_2 vs. Loading Case');
xlabel('Load Case [lbs]');
ylabel('Internal Force [lbf]');
hold off

subplot(3,2,4);
scatter(loadcase,F3D);
hold on
plot(loadcase,F3D,'LineStyle','none');
plot(loadcase,F3Dfit,'m');
title('Reaction Forces at F_{3D} vs. Loading Case');
xlabel('Load Case [lbs]');
ylabel('Reaction Force [lbf]');
hold off

subplot(3,2,5);
scatter(loadcase,LVDT);
hold on
plot(loadcase,LVDT,'LineStyle','none');
plot(loadcase,LVDTfit,'c');
title('Displacement (LVDT) vs. Loading Case');
xlabel('Load Case [lbs]');
ylabel('Displacement [in]');
hold off



% Function to unpack the experimental data

function [loadcase, F0, F1, F2, F3D, LVDT] = unPack(filename)

data = readtable(filename);

loadcase = table2array(data(:,1));
F0 = table2array(data(:,2));
F1 = table2array(data(:,3));
F2 = table2array(data(:,4));
F3D = table2array(data(:,5));
LVDT = table2array(data(:,6));


end



