clear; close; %clc
%% Symbolics
syms theta dtheta ddtheta delta ddelta dddelta x dx ddx y dy ddy xr yr sw dw six siy dxr dyr ddxr ddyr

%% Translation matrices and others
Hp_i = [1 0 -six; 0 1 0; 0 0 1]; % translation matrix for i in p frame (Hi^p)
Hr_p = [1 0 xr; 0 1 yr; 0 0 1]*[cos(delta) -sin(delta) 0; sin(delta) cos(delta) 0; 0 0 1];
Hg_r = [1 0 x; 0 1 y; 0 0 1]*[cos(theta) -sin(theta) 0; sin(theta) cos(theta) 0; 0 0 1];

Hg_i = simplify(Hg_r*Hr_p*Hp_i);

Rg_i = simplify([cos(delta) -sin(delta); sin(delta) cos(delta)]*[cos(theta) -sin(theta); sin(theta) cos(theta)]);
Ri_g = simplify(inv(Rg_i));
Rr_i = [cos(theta) -sin(theta); sin(theta) cos(theta)];

Sd_td = [0 -(dtheta+ddelta); (dtheta+ddelta) 0];
Sdd_td = [0 -(ddtheta+dddelta); (ddtheta+dddelta) 0 ];

Sd_t = [0 -dtheta; dtheta 0];
Sdd_t = [0 -ddtheta; ddtheta 0];

%% Calculations
Lg_i = [x;y] + Rg_i*[-(six);0] + Rr_i*[xr;yr];

dLg_i = [dx;dy] + Sd_td*Rg_i*[-six;0] + Sd_t*Rr_i*[xr;yr];

ddLg_i = [ddx;ddy] + (Sdd_td*Rg_i + Sd_td*Sd_td*Rg_i)*[-six;0] + (Sdd_t*Rr_i + Sd_t*Sd_t*Rr_i)*[xr;yr];

velIMU_IMU = simplify(Ri_g*dLg_i);
accIMU_IMU = simplify(Ri_g*ddLg_i);


%% Local robot accelerations
Hp_i = [1 0 -six; 0 1 0; 0 0 1]; % translation matrix for i in p frame (Hi^p)
Hr_p = [1 0 xr; 0 1 yr; 0 0 1]*[cos(delta) -sin(delta) 0; sin(delta) cos(delta) 0; 0 0 1];

Hr_i = simplify(Hr_p*Hp_i);

Rr_i = [cos(delta) -sin(delta); sin(delta) cos(delta)];
Ri_r = simplify(inv(Rr_i));

Sd_d = [0 -ddelta; ddelta 0];
Sdd_d = [0 -dddelta; dddelta 0];

Lr_i = [xr;yr] + Rr_i*[-(six);0];

dLr_i = [dxr;dyr] + Sd_d*Rr_i*[-(six);0];

ddLr_i = [ddxr;ddyr] + (Sdd_d*Rr_i + Sd_d*Sd_d*Rr_i)*[-six;0];

velIMU_IMU_l = simplify(Ri_r*dLr_i);
accIMU_IMU_l = simplify(Ri_r*ddLr_i)