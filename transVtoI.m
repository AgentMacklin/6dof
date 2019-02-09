% Austen LeBeau
% Transform from vehicle frame to inertial frame

function transform = transVtoI(phi, theta, psi)
    c_tht = cos(deg2rad(theta));
    c_phi = cos(deg2rad(phi));
    c_psi = cos(deg2rad(psi));
    s_tht = sin(deg2rad(theta));
    s_phi = sin(deg2rad(phi));
    s_psi = sin(deg2rad(psi));

    transform = [c_tht * c_psi, c_tht * s_psi, -s_tht;         % row 1
                 s_phi * s_tht * c_psi - s_psi * c_phi,...     % -----
                 c_phi * c_psi + s_phi * s_psi * s_tht,...     % row 2
                 s_phi * c_tht;                                % -----
                 s_tht * c_psi * c_phi + s_phi * s_psi,...     % -----
                 c_phi * s_tht * s_psi - c_psi * s_phi,...     % row 3
                 c_phi * c_tht];                               % -----
end