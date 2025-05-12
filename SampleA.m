function SampleA(serPort)

    Camera = CameraSensorCreate(serPort);

    while (isempty(Camera))


        frontDistance = ReadSonar(serPort, 2); % Front sonar
        leftDistance  = ReadSonar(serPort, 3); % Left sonar
        rightDistance = ReadSonar(serPort, 1); % Right sonar

        
        if isempty(frontDistance), frontDistance = 0; end
        if isempty(leftDistance),  leftDistance  = 0; end
        if isempty(rightDistance), rightDistance = 0; end

        
        if (frontDistance >= 0.3 || frontDistance == 0)
            % Move forward
            SetDriveWheelsCreate(serPort, 0.1, 0.1);
        elseif (frontDistance <= 0.3 && leftDistance == 0)
            % Turn left
            turnAngle(serPort, 0.2, 88);
        elseif (frontDistance <= 0.3 && rightDistance == 0)
            % Turn left
            turnAngle(serPort, 0.2, -88);
        end

       
        pause(0.1);

        
        Camera = CameraSensorCreate(serPort);
    end

    SetFwdVelAngVelCreate(serPort, 0, 0);
    disp('Beacon detected! Stopping.');
end
