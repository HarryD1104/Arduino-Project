
function temp_monitor(a)
    
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
    timeElapsed = [];
    temp = [];
    startTime = tic;
    GraphUpdate = tic;
    
    while true
        
        pause(0.1)
        A0_voltage = readVoltage(a,"A0")
        TA = (A0_voltage - V0) / TC
        t = toc(startTime);

        timeElapsed = [timeElapsed,t];
        temp = [temp,TA];
        
    
            if toc(GraphUpdate) >= 1;
                plot(timeElapsed, temp);
                xlim([max(0, t-30), t+5]); % Show last 30s of data
                ylim([min(temp)-2, max(temp)+2]); % Adjust y-axis range
                hold on;
                xlabel('Time (s)');
                ylabel('Temperature (°C)');
                title('Live Temperature Monitoring');
                grid on;
                drawnow;
                GraphUpdate = tic;

            end

               if TA >= 18 && TA <= 24;
                       
                        writeDigitalPin(a,"D7",1);
                        writeDigitalPin(a,"D13",0);
                        writeDigitalPin(a,"D8",0);
                       
                elseif TA < 18;
            
                        writeDigitalPin(a,"D7",0);
                        writeDigitalPin(a,"D13",1);
                        writeDigitalPin(a,"D8",0);
                        pause(0.5)
                        writeDigitalPin(a,"D13",1)
            
                                       
                else TA > 24;
                        writeDigitalPin(a,"D7",0);
                        writeDigitalPin(a,"D13",0);
                        writeDigitalPin(a,"D8",1);
                        pause(0.25);
                        writeDigitalPin(a,"D8",0);
                end

    end

end
