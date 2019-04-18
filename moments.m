function moment = moments(ipl, dynPress, Alpha, AlphaDot, beta, params, controls)

    % Moment coefficient parameters
    Cm0 = params.Cm0;
    CmAlpha = params.CmAlpha;
    CmDelta_e = params.CmDelta_e;
    Cmq = params.Cmq;
    CmAlphaDot = params.CmAlphaDot;

    % Roll coefficient parameters
    Croll0 = params.Croll0;
    CrollBeta = params.CrollBeta;
    CrollP = params.CrollP;
    CrollR = params.CrollR;
    CrollDeltaA = params.CrollDeltaA;
    CrollDeltaR = params.CrollDeltaR;

    % N coefficients
    Cn0 = params.Cn0;
    CnBeta = params.CnBeta;
    CnDeltaA = params.CnDeltaA;
    CnDeltaR = params.CnDeltaR;
    CnR = params.CnR;
    CnP = params.CnP;

    % Controls
    delta_e = controls.delta_e;
    delta_a = controls.delta_a;
    delta_r = controls.delta_r;

    % Moment coefficients
    Cm = Cm0 + CmAlpha * Alpha + CmDelta_e * delta_e + Cmq * dynPress + CmAlphaDot * AlphaDot;
    Croll = Croll0 + CrollBeta * beta + CrollP * ipl(7) + CrollR * ipl(9) + CrollDeltaA * delta_a + CrollDeltaR * delta_r;
    Cn = Cn0 + CnBeta * beta + CnDeltaA * delta_a + CnDeltaR * delta_r + CnR * ipl(9) + CnP * ipl(7);

    % Moments
    L = Croll * dynPress * params.Sref * params.wingSpan;
    M = Cm * dynPress * params.Sref * params.cbar;
    N = Cn * dynPress * params.Sref * params.wingSpan;

    moment = [L; M; N];


end