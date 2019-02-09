% Austen LeBeau
% Transform from vehicle frame to inertial frame

function transform = transVtoI(phi, theta, psi)
    c_tht = cosd(theta);
    c_phi = cosd(phi);
    c_psi = cosd(psi);
    s_tht = sind(theta);
    s_phi = sind(phi);
    s_psi = sind(psi);

    transform = [c_tht * c_psi, c_tht * s_psi, -s_tht;         % row 1
                 s_phi * s_tht * c_psi - s_psi * c_phi,...     % -----
                 c_phi * c_psi + s_phi * s_psi * s_tht,...     % row 2
                 s_phi * c_tht;                                % -----
                 s_tht * c_psi * c_phi + s_phi * s_psi,...     % -----
                 c_phi * s_tht * s_psi - c_psi * s_phi,...     % row 3
                 c_phi * c_tht];                               % -----
end