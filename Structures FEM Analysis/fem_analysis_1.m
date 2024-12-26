function plotFrequencyLab3(name,titleOf,ResonanceVec,ResonanceNames)
%Loading in Data
data_Full = load(name);
accel = data_Full(:,3:5);
shaker = data_Full(:,2);

%sampling data
sample_vec = 1:350:length(accel);

%Matrix setup
sampledAccel = [];
sampledShaker = [];


for i = 1:3  %"i" loop varies accelerometer
    for j = 1:length(sample_vec)-1  %"j" loop varies through rows

        %Takes 500 points at a time and takes the maximum value for the
        %data
        sampledAccel(j,i) = max(accel(sample_vec(j):sample_vec(j+1),i)); 
        sampledShaker(j) = max(shaker(sample_vec(j):sample_vec(j+1)));
    end

end
sampledShaker = sampledShaker';

%Frequency vector, rising linearly from 2 Hz to 50 Hz
frequencyVec = linspace(2,50,length(sample_vec)-1);

%Making a "magnification factor" based on the ratio of driven acceleration
%divided by the shakers acceleration
Ratio_Accel_1 = sampledAccel(:,1)./sampledShaker;
Ratio_Accel_2 = sampledAccel(:,2)./sampledShaker;
Ratio_Accel_3 = sampledAccel(:,3)./sampledShaker;

Names = ["Accelerometer 1" "Accelerometer 2" "Accelerometer 3" ResonanceNames];
colors = ["g","m","c","k"];
%Plotting
figure

loglog(frequencyVec,Ratio_Accel_1,frequencyVec,Ratio_Accel_2,frequencyVec,Ratio_Accel_3,"b")
hold on
for i = 1:length(ResonanceVec)
    xline(ResonanceVec(i),colors(i))
end
xlabel("Frequency (Hz)")
ylabel("Magnified Amplitude")
title("Acceleration Response vs Frequency for " + titleOf )
legend(Names,Location="best")
xlim([2 51])


%Preset function calls used to make plots for write up

%plotFrequencyLab3('test_2min_all_1','Test, 2min, All, 1',[12.52 23.87 40.04 48.05],["Resonance at 12.53 Hz" "Resonance at 23.87 Hz" "Resonance at 40.04 Hz" "Resonance at 48.05 Hz"])

%plotFrequencyLab3('test_2min_nose_1','Test, 2min, Nose, 1',[23.77 40.33 48.05],["Resonance at 23.77 Hz" "Resonance at 40.33 Hz" "Resonance at 48.05 Hz"])

%plotFrequencyLab3('test_2min_tail_1','Test, 2min, Tail, 1',[12.51 44.63 49.31],["Resonance at 12.51 Hz" "Resonance at 44.63 Hz" "Resonance at 49.31 Hz"])

%plotFrequencyLab3('test_2min_wing_1','Test, 2min, Wing, 1',[24.13 41.48 48.95],["Resonance at 24.13 Hz" "Resonance at 41.48 Hz" "Resonance at 48.95 Hz"])

%plotFrequencyLab3('test_5min_all_1','Test, 5min, All, 1',[12.34 24.42 41.28],["Resonance at 12.34 Hz" "Resonance at 24.42 Hz" "Resonance at 41.28 Hz"])
end