%clear; 
close; clc
%% Symbolics
syms theta dtheta ddtheta delta ddelta dddelta x dx ddx y dy ddy xr yr sw dw dxr dyr ddxr ddyr r
%%%%%%%%%% WHEEL LEFT %%%%%%%%%
%% Translation matrices and others
Hp_w1 = [1 0 -sw; 0 1 -dw/2; 0 0 1]; % translation matrix for i in p frame (Hi^p)
Hr_p = [1 0 xr; 0 1 yr; 0 0 1]*[cos(delta) -sin(delta) 0; sin(delta) cos(delta) 0; 0 0 1];
Hg_r = [1 0 x; 0 1 y; 0 0 1]*[cos(theta) -sin(theta) 0; sin(theta) cos(theta) 0; 0 0 1];

Hg_w1 = simplify(Hg_r*Hr_p*Hp_w1);

Rg_w1 = simplify([cos(delta) -sin(delta) ; sin(delta) cos(delta)]*[cos(theta) -sin(theta) ; sin(theta) cos(theta)]);
Ri_g = simplify(inv(Rg_w1));
Rr_i = [cos(theta) -sin(theta); sin(theta) cos(theta)];

Sd_td = [0 -(dtheta+ddelta); (dtheta+ddelta) 0];
 
Sd_t = [0 -dtheta; dtheta 0];

%% Calculations
Lg_w1 = [x; y] + Rg_w1*[-sw; dw/2] + Rr_i*[xr; yr];

dLg_w1 = [dx; dy] + Sd_td*Rg_w1*[-sw; dw/2] + Sd_t*Rr_i*[xr; yr];

velW_W = simplify(Ri_g*dLg_w1);

%% %%%%%%%% WHEEL RIGHT %%%%%%%%%
Hp_w1 = [1 0 -sw; 0 1 -dw/2; 0 0 1]; % translation matrix for i in p frame (Hi^p)
Hr_p = [1 0 xr; 0 1 yr; 0 0 1]*[cos(delta) -sin(delta) 0; sin(delta) cos(delta) 0; 0 0 1];
Hg_r = [1 0 x; 0 1 y; 0 0 1]*[cos(theta) -sin(theta) 0; sin(theta) cos(theta) 0; 0 0 1];

Hg_w1 = simplify(Hg_r*Hr_p*Hp_w1);

Rg_w1 = simplify([cos(delta) -sin(delta) ; sin(delta) cos(delta)]*[cos(theta) -sin(theta) ; sin(theta) cos(theta)]);
Ri_g = simplify(inv(Rg_w1));
Rr_i = [cos(theta) -sin(theta); sin(theta) cos(theta)];

Sd_td = [0 -(dtheta+ddelta); (dtheta+ddelta) 0];
 
Sd_t = [0 -dtheta; dtheta 0];

%% Calculations
Lg_w1 = [x; y] + Rg_w1*[-sw; -dw/2] + Rr_i*[xr; yr];

dLg_w1 = [dx; dy] + Sd_td*Rg_w1*[-sw; -dw/2] + Sd_t*Rr_i*[xr; yr];

velW_W = simplify(Ri_g*dLg_w1);




%% Robot velocity
Hp_wl = [1 0 -sw; 0 1 -dw/2; 0 0 1]; % translation matrix for i in p frame (Hi^p)
Hi_p = [cos(delta) -sin(delta) 0; sin(delta) cos(delta) 0; 0 0 1];
Hr_i = [1 0 xr; 0 1 yr; 0 0 1];
Hs_r = [cos(theta) -sin(theta) 0; sin(theta) cos(theta) 0; 0 0 1];

Hr_wl = simplify(Hr_i*Hi_p*Hp_wl);
Hs_wl = simplify(Hs_r*Hr_i*Hi_p*Hp_wl);

Rr_wl = [cos(delta) -sin(delta); sin(delta) cos(delta)];
Rwl_r = simplify(inv(Rr_wl));

Sd_d = [0 -ddelta; ddelta 0];
Sdd_d = [0 -dddelta; dddelta 0];

Lr_wl = [xr; yr] + Rr_wl*[-sw; -dw/2];

dLr_wl = [dxr; dyr] + [- dtheta*r*sin(pi/4); dtheta*r*sin(pi/4)]+ Sd_d*Rr_wl*[-sw; -dw/2];

ddLr_wl = [ddxr;ddyr] + (Sdd_d*Rr_wl + Sd_d*Sd_d*Rr_wl)*[-sw; -dw/2];

velwl_wl_l = simplify(Rwl_r*dLr_wl)