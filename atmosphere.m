% Austen LeBeau
% Aero 3220
% Function that returns atmospheric data in imperial units.

function [P, T, rho, acoustic_speed] = atmosphere(x)

% Constants
    z0 = 0;                     % ground altitude (MSL) where P0 and T0 are measured
    T0 = 518.67;                % degrees K
    P0 = 2116.23;               % Pascals
    g = 32.174;                 % acceleration due to gravity m/sec^2
    R = 1716.49;                % specific gas constant for air 
    lapse_rate = -0.003566;     % lapse rate rankine/ft
    gamma = 1.4;                % adiabatic constant


% Atmosphere Model
    z = x(3);
    T = T0 + lapse_rate * (z - z0);                 % Temperature at altitude z, degree K
    P = P0 * (T / T0) ^ (-g / (lapse_rate * R)) ;   % Pressure at altitude z, Pascals
    rho = P / (R * T);                              % Density at altitude z, kg/m^3
    acoustic_speed = sqrt(gamma * R * T);            % Acoustic speed, m/sec

end