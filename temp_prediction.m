function temp_prediction(a) % responds to call in main file

% TEMP_MONITOR
% This functions records the voltage of the thermistor and calculates the
% appropriate temperature, it stores it in an array and calculates the rate
% of change in temperature from the last value and the value before that
% recorded. It then predicts what the temperature will be in 5 minutes
% according to this rate of change Whilst printing these values, a green
% light will show if it is in an appropriate comfort range (-4 to 4
% degrees) above this it will show a red light, below a yellow light.

    V0 = 0.5;
    TC = 0.01;
    t = [];
    timeElapsed = [];
    temp = [];
    startTime = tic;
    TA = [];
    A0_voltage = [];

    A0_voltage = readVoltage(a,"A0");
    fprintf('Current temperature\t Rate of change\t Temperature prediction\n');

    while true % makes the loop continue indefinitely

        pause(1); % waits a second

        A0_voltage = readVoltage(a,"A0");
        TA = (A0_voltage - V0) / TC;
        t = toc(startTime);
        timeElapsed = [timeElapsed,t];
        temp = [temp,TA];


        if length(temp) > 1 % length of temperature array greater than 1 to avoid 0
 
            dTA = abs(temp(end)) - abs(temp(end-1)); % calculates change in temperature of the last calculates value and the one prior to that one
            dt = timeElapsed(end) - timeElapsed(end-1); % same with the time
            deltaTA = dTA / dt;
            predTA = TA + (deltaTA * 5); % prediction, temperature + change * 5 minutes
            fprintf('%f\t          %9f\t          %f\n',TA, deltaTA, predTA);
            
            if deltaTA >= -4 && deltaTA <= 4; % change in temp between -4 and 4

                writeDigitalPin(a,"D7",1); % turns on green LED
                writeDigitalPin(a,"D13",0);
                writeDigitalPin(a,"D8",0);

            elseif deltaTA > 4;

                writeDigitalPin(a,"D8",1); % turns on red LED if change in temp is more than 4
                writeDigitalPin(a,"D13",0);
                writeDigitalPin(a,"D7",0);

            else deltaTA < -4; 

                writeDigitalPin(a,"D13",1); % turns on yellow LED if less than -4 
                writeDigitalPin(a,"D8",0);
                writeDigitalPin(a,"D7",0)

            end

        end
        

    end
end













