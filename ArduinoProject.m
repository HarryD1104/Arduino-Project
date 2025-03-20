% Harry Daniels
% efyhd1@nottingham.ac.uk


%% PRELIMINARY TASK - ARDUINO AND GIT INSTALLATION [10 MARKS]
clear
clc

a = arduino("COM3","Uno");

t = [1:10];

for i = 1:length(t)

    writeDigitalPin(a,"d7",1)
    pause(0.5)

    writeDigitalPin(a,"d7",0)
    pause(0.5)

end



%% TASK 1 - READ TEMPERATURE DATA, PLOT, AND WRITE TO A LOG FILE [20 MARKS]
clear
clc

a = arduino("COM3","Uno");

duration = 600;
V0 = 0.5;
TC = 0.01;
TA = zeros(1,duration);
A0_voltage = zeros(1,duration);
time = 1:duration;

for t = 1:duration    
    A0_voltage(t) = readVoltage(a,"A0");
    TA(t) = (A0_voltage(t) - V0) / TC;

    fprintf('The current voltage and temperature are %f and %f respectively\n',A0_voltage(t),TA(t))
    pause(1);
    
    minValue = min(TA(t));
    maxValue = max(TA(t));
    meanValue = mean(TA(t));

end

fprintf('The minimum, maximum and mean values of the calculated temperatures are %f, %f, %f\n',minValue,maxValue,meanValue)

plot(time,TA);
grid on
hold on
title('Temperature VS Time')
xlabel('Time (s)');
ylabel('Temperature (C)');

%% TASK 2 - LED TEMPERATURE MONITORING DEVICE IMPLEMENTATION [25 MARKS]
clear
clc

a = arduino("COM3","Uno");

temp_monitor(a)

%% TASK 3 - ALGORITHMS – TEMPERATURE PREDICTION [25 MARKS]

% Insert answers here


%% TASK 4 - REFLECTIVE STATEMENT [5 MARKS]

% Insert reflective statement here (400 words max)


%% TASK 5 - COMMENTING, VERSION CONTROL AND PROFESSIONAL PRACTICE [15 MARKS]

% No need to enter any answershere, but remember to:
% - Comment the code throughout.
% - Commit the changes to your git repository as you progress in your programming tasks.
% - Hand the Arduino project kit back to the lecturer with all parts and in working order.
