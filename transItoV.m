% Austen LeBeau
% Transform from vehicle frame to inertial frame

function transform = transItoV(ipl)
    c_tht = cosd(ipl(1));
    c_phi = cosd(ipl(1));
    c_psi = cosd(ipl(3));
    s_tht = sind(ipl(1));
    s_phi = sind(ipl(1));
    s_psi = sind(ipl(3));

    transform = [c_tht * c_psi, c_tht * s_psi, -s_tht;         % row 1
                 s_phi * s_tht * c_psi - s_psi * c_phi,...     % -----
                 c_phi * c_psi + s_phi * s_psi * s_tht,...     % row 2
                 s_phi * c_tht;                                % -----
                 s_tht * c_psi * c_phi + s_phi * s_psi,...     % -----
                 c_phi * s_tht * s_psi - c_psi * s_phi,...     % row 3
                 c_phi * c_tht];                               % -----
end