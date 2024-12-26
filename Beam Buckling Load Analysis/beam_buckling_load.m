% Experimental Data Analysis
clear; clc;
close all;

%% Load in data
data1 = load("Rectangular Specimen.mat");
data2 = load("Square Specimen.mat");

Rect = data1.data;
Sq = data2.data;

L = 11; % [in]

%% Process Data
% Convert voltage to loading
Rect(:, 2) = Rect(:, 2) / 0.00237; % Convert to lb
Sq(:, 2) = Sq(:, 2) / 0.00237;

%% Plot Load vs Deflection
% Rectangular Specimen
figure(1);
hold on;
grid on;
grid minor;
plot(Rect(:, 3), Rect(:, 2), 'LineWidth', 1.5);
title("Rectangular Specimen Deflection");
xlabel("Deflection [in]");
ylabel("Applied load [lb]");
hold off;

% Square Specimen
figure(2);
hold on;
grid on;
grid minor;
plot(Sq(:, 3), Sq(:, 2), 'LineWidth', 1.5);
title("Square Specimen Deflection");
xlabel("Deflection [in]");
ylabel("Applied load [lb]");
hold off; 

%% Plot with predicted values
% Calculated critical loadings
PcrRec = 123.6;
PcrSq = 231.76;

%fRec = @(P) sqrt(((P/PcrRec)-1) * (8*L^2 / (pi^2)));
%fSq = @(P) sqrt(((P/PcrSq)-1) * (8*L^2 / (pi^2)));

% Function declaration 
fRec = @(v) PcrRec .* (((v.^2 .* pi.^2)./(8 .* L.^2)) + 1);
fSq = @(v) PcrSq .* (((v.^2 .* pi.^2)./(8 .* L.^2)) + 1);

% Set up deflection vector
defl = linspace(0, 2, 33)'; 

% Calculate associated loadings
PRec = fRec(defl);
PSq = fSq(defl);

% Plot onto respective plots
figure(1);
hold on;
plot(defl, PRec, "LineWidth", 1.5);
xline(0.7374, '--', 'Predicted Plastification', 'LabelVerticalAlignment', 'bottom');
legend("Experimental", "Theoretical", "");
hold off;

figure(2);
hold on;
plot(defl, PSq, "LineWidth", 1.5);
xline(0.3687, '--', 'Predicted Plastification', 'LabelVerticalAlignment', 'bottom');
legend("Experimental", "Theoretical", "");
hold off; 
