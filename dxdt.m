function xDot =  dxdt(t, ipl, params, controls)
    %% Equations of motion
    % ipl(1) = x = x position in inertial frame
    % ipl(2) = y = y position in inertial frame
    % ipl(3) = z = z position in inertial frame
    % ipl(4) = u = x velocity in vehicle frame
    % ipl(5) = v = y velocity in vehicle frame
    % ipl(6) = w = z velocity in vehicle frame
    % ipl(7) = p = roll rate in vehicle frame
    % ipl(8) = q = pitch rate in vehicle frame
    % ipl(9) = r = yaw rate in vehicle frame
    % ipl(10) = phi = roll angle in inertial frame
    % ipl(11) = theta = pitch angle in inertial frame
    % ipl(12) = psi = yaw angle in inertial frame


    % Compute xDot 
    mass = params.mass; %slugs
    Ixx = params.Ixx;
    Iyy = params.Iyy;
    Izz = params.Izz;
    Ixz = params.Ixz;

    [rho, acousticSpeed] = atmosphere(-ipl(3));
    speed = norm(ipl(4:6));
    dynPress = 0.5 * rho * (speed^2);
    Alpha = atan(ipl(6) / ipl(4));
    beta = asin(ipl(5) / speed);

    vInertial = inv(transItoV(ipl(10:12))) * ipl(4:6);
    force = forces(ipl, dynPress, Alpha, beta, params, controls);
    
    uDot = ipl(9) * ipl(5) - ipl(8) * ipl(6) + force(1) / mass;
    vDot = ipl(7) * ipl(6) - ipl(9) * ipl(4) + force(2) / mass;   % v dot 
    wDot = ipl(8) * ipl(4) - ipl(7) * ipl(5) + force(3) / mass;   % w dot equation
    
    AlphaDot = (uDot * ipl(6) - wDot * ipl(4)) / (ipl(4)^2 + ipl(6)^2);
    moment = moments(ipl, dynPress, Alpha, AlphaDot, beta, params, controls);
    
    pDot = (Izz * moment(1) + Ixz * moment(3) - (Ixz * (Iyy - Ixx - Izz) * ipl(7) ...
            + (Ixz^2 + Izz * (Izz - Iyy)) * ipl(9)) * ipl(8)) / (Ixx * Izz - Ixz^2);
    
    qDot = 0; % q dot 
    rDot = 0; % r dot equation
    
    phiDot = ipl(7) + tan(ipl(11)) * (ipl(8) * sin(ipl(10)) + ipl(9) * cos(ipl(10)));
    thetaDot = ipl(8) * cos(ipl(10)) - ipl(9) * sin(ipl(10));   % theta dot equation
    psiDot = (ipl(8) * sin(ipl(10)) + ipl(9) * cos(ipl(10))) * sec(ipl(11));

    % psi dot equation
    xDot = [vInertial; uDot; vDot; wDot; pDot; qDot; rDot; phiDot; thetaDot; psiDot];
end
