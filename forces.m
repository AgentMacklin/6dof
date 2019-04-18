function forceVector = forces(ipl, dynPress, Alpha, beta, params, controls)

    q = dynPress;
    
    CL = params.CL0 + params.CLAlpha * Alpha + params.CLdelta_e * controls.delta_e;
    CD = params.CD0 + (CL^2 / (pi * params.AR * params.OSE));

    L_stab = q * params.Sref * CL;
    D_stab = q * params.Sref * CD;

    Cy = params.CyBeta * beta + params.CydeltaR * controls.delta_r;
    Y = Cy * q * params.Sref;

    t_matrix = transItoV(ipl(10:12));

    weight = params.mass * t_matrix * params.g;
    params.Thrust = params.Thrust * [cos(params.phi_T); 0; sin(params.phi_T)];

    Fx = L_stab * sin(Alpha) - D_stab * cos(Alpha);
    Fz = -L_stab * cos(Alpha) - D_stab * sin(Alpha);

    forceVector = [Fx; Y; Fz] + weight + params.Thrust;   

end