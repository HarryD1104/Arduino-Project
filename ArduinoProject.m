% Harry Daniels
% efyhd1@nottingham.ac.uk


%% PRELIMINARY TASK - ARDUINO AND GIT INSTALLATION [10 MARKS]
clear
clc

a = arduino("COM3","Uno"); % assigns variable "a" to the arduino

t = 1:10; % creates vector 1-10

for i = 1:length(t)

    writeDigitalPin(a,"d7",1) % LED assigned to port D7, 1 sets the voltage high
    pause(0.5) % waits half a second

    writeDigitalPin(a,"d7",0) % sets voltage to low (turns off led)
    pause(0.5)

end



%% TASK 1 - READ TEMPERATURE DATA, PLOT, AND WRITE TO A LOG FILE [20 MARKS]
clear
clc

a = arduino("COM3","Uno");

duration = 600; % sets time to 600 seconds
V0 = 0.5;
TC = 0.01;
TA = zeros(1,duration); % preallocates the array for temperature
A0_voltage = zeros(1,duration); % preallocates array for voltage readings
time = zeros(1,duration); % preallocates time array

file_id = fopen('cabin_temperature.txt','w'); % opens cabin temperature file
d = datestr(now, 'dd-mm-yyyy'); % reads current date
fprintf(file_id,'Data logging initiated - %s\nLocation: Nottingham\n',d); % prints the date and location to the file


for t = 1:duration; % loop from 1 - 600
    
        A0_voltage(t) = readVoltage(a,"A0"); % reads voltage from circuit
        TA(t) = (A0_voltage(t) - V0) / TC; % calculates temperature at each value of t 
        time(t) = t; % stores t in an array
        %pause(1);

       if t == 1; % when t is equal to 1 prints initial temperature to file

           fprintf(file_id,'\nMinute 0\nTemperature %.2f°C\n',TA(t));

       end

       if mod(t,60) == 0; % divides the current t value by 60, if this value doesn't have a reminder then it prints the current temp and corresponding minute

           minutes = t / 60;
           fprintf(file_id,'\nMinute %d\nTemperature %.2f°C\n',minutes,TA(t));

       end

        % finds, min,max and mean value of the temperature data set
        minValue = min(TA); 
        maxValue = max(TA);
        meanValue = mean(TA);  

end

% prints the statisical values
fprintf(file_id,'\nThe minimum, maximum and mean values of the calculated temperatures are %f, %f, %f\n',minValue,maxValue,meanValue);

fclose(file_id); % closes the file

% plots the data set
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
 
temp_monitor(a) % calls the corresponding function

%% TASK 3 - ALGORITHMS – TEMPERATURE PREDICTION [25 MARKS]

clear
clc

a = arduino("COM3","Uno");

temp_prediction(a) % calls the corresponding function


%% TASK 4 - REFLECTIVE STATEMENT [5 MARKS]



% For some of the tasks, I had to do some research on how to approach them.
% I had to google how to use some different commands in order to achieve
% the objective and goal of the project. For example, using mod() to make
% the code display the temperature at certain times. I tried to create an
% array and another for/while loop however this didn't seem to work.
% Researching different commands allows me to have more tools in my
% arsenal.

% Strength wise, I've had experience with dynamic/live updating graphs in
% matlab before when using it at school so this didn't prove to be as much
% of a challenge as I thought it would. Furthermore, the electronics part
% of the module definitely allowed the creation of the different circuits
% to be a lot easier.

% Limitations of the code would be to preallocate the time and temperature
% arrays in temp_monitor.m however since this program continues
% indefinitely i could not figure a way to do this. Preallocating the
% arrays would save a lot of CPU space and allow the program to run more
% smoothly. Another issue which would need improving for next time would be
% a way to decrease the noise distruption within the circuit which leads to
% varied and inaccurate results.


%% TASK 5 - COMMENTING, VERSION CONTROL AND PROFESSIONAL PRACTICE [15 MARKS]

% No need to enter any answershere, but remember to:
% - Comment the code throughout.
% - Commit the changes to your git repository as you progress in your programming tasks.
% - Hand the Arduino project kit back to the lecturer with all parts and in working order.
