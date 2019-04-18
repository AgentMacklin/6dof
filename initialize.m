function [Alpha, T, ipl, delta_e0] = initialize(ipl, params)
    
    %% Initialize   
    Sref = params.Sref;
    CLAlpha = params.CLAlpha; %per radian
    CL0 = params.CL0;
    CD0 = params.CD0;
    CmAlpha = params.CmAlpha;
    Cm0 = params.Cm0;
    CmDelta_e = params.CmDelta_e;
    CLdelta_e = params.CLdelta_e;

    weight = params.weight;
    speed = params.SpdCmd;

    [rho, acousticSpeed] = atmosphere(-ipl(3));
    dynPress = 0.5 * rho * speed^2;

    Alpha1 = weight / (dynPress * Sref * CLAlpha) - CL0 / CLAlpha;
    Alpha = 0;

    % Iterate to find Alpha and delta_e0
    for i = 1:100
        delta_e1 = (-Cm0 - CmAlpha*Alpha1)/CmDelta_e;
        C_lift = CL0 + CLAlpha*Alpha1 + CLdelta_e*delta_e1;
        CD = params.CD0 + C_lift^2/(pi*params.AR*params.OSE);
        Alpha = (weight/(dynPress*Sref)-CL0-CLdelta_e*delta_e1)/(CLAlpha+CD);
        if abs(Alpha-Alpha1)<1e-10
            break
        end
        Alpha1 = Alpha;
    end

    Alpha = Alpha1;
    delta_e0 = delta_e1;

    ipl(4) = speed * cos(Alpha);
    ipl(6) = speed * sin(Alpha);
    ipl(11) = Alpha; % Initial theta = Alpha

    CL = CL0 + CLAlpha * Alpha + CLdelta_e * delta_e0;
    CD = CD0 + CL^2 / (pi * params.AR * params.OSE);

    Drag = CD * dynPress * Sref;
    T = Drag / cos(Alpha);
end

