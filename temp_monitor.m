
function temp_monitor(a) % listens to the call in the main file
clc

% TEMP_MONITOR 
% This function reads the voltage from the arduino and calculates the
% according temperature. It uses the tic and toc command to plot a graph
% which plots the temperature as it is calculated and updates every second
%
% Whilst the temperature calculated is between 18-24 degrees it displays a
% constant green LED, below 18 the yellow LED flashes every 0.25 seconds,
% above 18 and the red flashes every 0.5 seconds.


    V0 = 0.5;
    TC = 0.01;
    timeElapsed = []; % creates time array
    temp = []; % temperature array
    startTime = tic; % starts a timer 
    GraphUpdate = tic;
    
    while true
        
        pause(0.1) % waits 0.1 seconds to save cpu speed and reduce the spread of data
        A0_voltage = readVoltage(a,"A0");
        TA = (A0_voltage - V0) / TC;
        t = toc(startTime); % records the time to record a value

        % stores the data without the time and temperature overlapping for dynamic plotting
        timeElapsed = [timeElapsed,t];
        temp = [temp,TA];
        
    
            if toc(GraphUpdate) >= 1 % when the timer for the graph update is >=1 this allows the graph to update, tictoc isn't accurate enough to just use >1.
                plot(timeElapsed, temp);
                xlim([max(0, t-30), t+5]); 
                ylim([min(temp)-2, max(temp)+2]); 
                hold on;
                xlabel('Time (s)');
                ylabel('Temperature (°C)');
                title('Live Temperature Monitoring');
                grid on;
                drawnow; % continuously updates graph
                GraphUpdate = tic; % restarts this timer

            end

               if TA >= 18 && TA <= 24; % temp between 18 and 24, turns on green led
                       
                        writeDigitalPin(a,"D7",1);
                        writeDigitalPin(a,"D13",0);
                        writeDigitalPin(a,"D8",0);
                       
               elseif TA < 18; % less than 18, turns on yellow LED and it flashes every 0.25 seconds
            
                        writeDigitalPin(a,"D7",0);
                        writeDigitalPin(a,"D13",1);
                        writeDigitalPin(a,"D8",0);
                        pause(0.25)
                        writeDigitalPin(a,"D13",1)
            
                                       
               else TA > 24; % more than 24, turns on red led and it flashes every 0.5 seconds
                        writeDigitalPin(a,"D7",0);
                        writeDigitalPin(a,"D13",0);
                        writeDigitalPin(a,"D8",1);
                        pause(0.5);
                        writeDigitalPin(a,"D8",0);
                end

    end

end
