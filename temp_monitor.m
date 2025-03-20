
function temp_monitor(a)
    
% TEMP_MONITOR 


    V0 = 0.5;
    TC = 0.01;
    timeElapsed = [];
    temp = []
    startTime = tic

    while true
        pause(1)
        A0_voltage = readVoltage(a,"A0");
        TA = (A0_voltage - V0) / TC;
        t = toc(startTime)

        timeElapsed = [timeElapsed,t];
        temp = [temp,TA];
        
        plot(timeElapsed,temp);
        xlim([max(0, t-30), t+5]); % Show last 30s of data
        ylim([min(temp)-2, max(temp)+2]); % Adjust y-axis range
        hold on;
        xlabel('Time (s)');
        ylabel('Temperature (°C)');
        title('Live Temperature Monitoring');
        grid on;
        drawnow;
        

                if TA >= 18 && TA <= 24;
            
                    writeDigitalPin(a,"D7",1);
                    writeDigitalPin(a,"D13",0);
                    writeDigitalPin(a,"D8",0);
            
            
                elseif TA < 18;
            
                    writeDigitalPin(a,"D7",0);
                    writeDigitalPin(a,"D13",1);
                    writeDigitalPin(a,"D8",0);
                    
                    pause(0.5);
                    writeDigitalPin(a,"D13",0);
            
                           
                else TA > 24;
            
                    writeDigitalPin(a,"D7",0);
                    writeDigitalPin(a,"D13",0);
                    writeDigitalPin(a,"D8",1);
            
                    pause(0.25);
                    writeDigitalPin(a,"D8",0);
                    
                end



               
    end

end
