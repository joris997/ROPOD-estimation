clc
load('all_data_2_square.mat')

%% load data
time = all_wheel_out_data(1,:);
a_y = all_wheel_out_data([34 74 114 154],:);
a_x = -all_wheel_out_data([36 76 116 156],:);
w_l = all_wheel_out_data([7 47 87 127],:);
w_r = all_wheel_out_data([19 59 99 139],:);

%% determine where to look at the variance of the sensor data a_y and a_x
figure(1)
hold on; grid on
for i = 1:4
    plot(time,w_l(i,:))
end
% results in analyzing t = [20.8 - 23.65] since this is where the wheels
% have a continuous velocity therefore allowing me to look at the
% covariance with the vibrations taken into account
start = 20800;
finish = 23650;
%% determine covariance
time = time(:,start:finish);
a_y = a_y(:,start:finish);
a_x = a_x(:,start:finish);

covx1x2 = cov(a_x(1,:),a_x(2,:));
covx1x3 = cov(a_x(1,:),a_x(3,:));
covx1x4 = cov(a_x(1,:),a_x(4,:));
covx2x3 = cov(a_x(2,:),a_x(3,:));
covx2x4 = cov(a_x(2,:),a_x(4,:));
covx3x4 = cov(a_x(3,:),a_x(4,:));

covy1y2 = cov(a_y(1,:),a_y(2,:));
covy1y3 = cov(a_y(1,:),a_y(3,:));
covy1y4 = cov(a_y(1,:),a_y(4,:));
covy2y3 = cov(a_y(2,:),a_y(3,:));
covy2y4 = cov(a_y(2,:),a_y(4,:));
covy3y4 = cov(a_y(3,:),a_y(4,:));

covx1y1 = cov(a_x(1,:),a_y(1,:));
covx1y2 = cov(a_x(1,:),a_y(2,:));
covx1y3 = cov(a_x(1,:),a_y(3,:));
covx1y4 = cov(a_x(1,:),a_y(4,:));
covx2y1 = cov(a_x(2,:),a_y(1,:));
covx2y2 = cov(a_x(2,:),a_y(2,:));
covx2y3 = cov(a_x(2,:),a_y(3,:));
covx2y4 = cov(a_x(2,:),a_y(4,:));
covx3y1 = cov(a_x(3,:),a_y(1,:));
covx3y2 = cov(a_x(3,:),a_y(2,:));
covx3y3 = cov(a_x(3,:),a_y(3,:));
covx3y4 = cov(a_x(3,:),a_y(4,:));
covx4y1 = cov(a_x(4,:),a_y(1,:));
covx4y2 = cov(a_x(4,:),a_y(2,:));
covx4y3 = cov(a_x(4,:),a_y(3,:));
covx4y4 = cov(a_x(4,:),a_y(4,:));

R_a = [cov(a_x(1,:))  0               0               0               0               0               0               0;
       covx1x2(1,2)   cov(a_x(2,:))   0               0               0               0               0               0;
       covx1x3(1,2)   covx2x3(1,2)    cov(a_x(3,:))   0               0               0               0               0;
       covx1x4(1,2)   covx2x4(1,2)    covx3x4(1,2)    cov(a_x(4,:))   0               0               0               0;
       covx1y1(1,2)   covx2y1(1,2)    covx3y1(1,2)    covx4y1(1,2)    cov(a_y(1,:))   0               0               0;
       covx1y2(1,2)   covx2y2(1,2)    covx3y2(1,2)    covx4y2(1,2)    covy1y2(1,2)    cov(a_y(2,:))   0               0;
       covx1y3(1,2)   covx2y3(1,2)    covx3y3(1,2)    covx4y3(1,2)    covy1y3(1,2)    covy2y3(1,2)    cov(a_y(3,:))   0;
       covx1y4(1,2)   covx2y4(1,2)    covx3y4(1,2)    covx4y4(1,2)    covy1y4(1,2)    covy2y4(1,2)    covy3y4(1,2)    cov(a_y(4,:))];

R_dia = R_a;
for i = 1:size(R_a,2)
    R_dia(i,i) = 0;
end
R_a = R_a + R_dia';

%  R = [cov(a_x(1,:)) 0               0               0               0               0               0               0;
%      0              cov(a_x(2,:))   0               0               0               0               0               0;
%      0              0               cov(a_x(3,:))   0               0               0               0               0;
%      0              0               0               cov(a_x(4,:))   0               0               0               0;
%      0              0               0               0               cov(a_y(1,:))   0               0               0;
%      0              0               0               0               0               cov(a_y(2,:))   0               0;
%      0              0               0               0               0               0               cov(a_y(3,:))   0;
%      0              0               0               0               0               0               0               cov(a_y(4,:))];
% 

%% Wheel encoder velocities
dphi_l = w_l(:,start:finish)*ropod_kinmodel_pv(1);
dphi_r = w_r(:,start:finish)*ropod_kinmodel_pv(1);

covl1l2 = cov(dphi_l(1,:),dphi_l(2,:));
covl1l3 = cov(dphi_l(1,:),dphi_l(3,:));
covl1l4 = cov(dphi_l(1,:),dphi_l(4,:));
covl2l3 = cov(dphi_l(2,:),dphi_l(3,:));
covl2l4 = cov(dphi_l(2,:),dphi_l(4,:));
covl3l4 = cov(dphi_l(3,:),dphi_l(4,:));

covr1r2 = cov(dphi_r(1,:),dphi_r(2,:));
covr1r3 = cov(dphi_r(1,:),dphi_r(3,:));
covr1r4 = cov(dphi_r(1,:),dphi_r(4,:));
covr2r3 = cov(dphi_r(2,:),dphi_r(3,:));
covr2r4 = cov(dphi_r(2,:),dphi_r(4,:));
covr3r4 = cov(dphi_r(3,:),dphi_r(4,:));

covl1r1 = cov(dphi_l(1,:),dphi_r(1,:));
covl1r2 = cov(dphi_l(1,:),dphi_r(2,:));
covl1r3 = cov(dphi_l(1,:),dphi_r(3,:));
covl1r4 = cov(dphi_l(1,:),dphi_r(4,:));
covl2r1 = cov(dphi_l(2,:),dphi_r(1,:));
covl2r2 = cov(dphi_l(2,:),dphi_r(2,:));
covl2r3 = cov(dphi_l(2,:),dphi_r(3,:));
covl2r4 = cov(dphi_l(2,:),dphi_r(4,:));
covl3r1 = cov(dphi_l(3,:),dphi_r(1,:));
covl3r2 = cov(dphi_l(3,:),dphi_r(2,:));
covl3r3 = cov(dphi_l(3,:),dphi_r(3,:));
covl3r4 = cov(dphi_l(3,:),dphi_r(4,:));
covl4r1 = cov(dphi_l(4,:),dphi_r(1,:));
covl4r2 = cov(dphi_l(4,:),dphi_r(2,:));
covl4r3 = cov(dphi_l(4,:),dphi_r(3,:));
covl4r4 = cov(dphi_l(4,:),dphi_r(4,:));

R_w = [cov(dphi_l(1,:)) 0                   0                   0                   0                   0                   0                   0;
       covl1l2(1,2)     cov(dphi_l(2,:))    0                   0                   0                   0                   0                   0;
       covl1l3(1,2)     covl2l3(1,2)        cov(dphi_l(3,:))    0                   0                   0                   0                   0;
       covl1l4(1,2)     covl2l4(1,2)        covl3l4(1,2)        cov(dphi_l(4,:))    0                   0                   0                   0;
       covl1r1(1,2)     covl2r1(1,2)        covl3r1(1,2)        covl4r1(1,2)        cov(dphi_r(1,:))    0                   0                   0;
       covl1r2(1,2)     covl2r2(1,2)        covl3r2(1,2)        covl4r2(1,2)        covr1r2(1,2)        cov(dphi_r(2,:))    0                   0;
       covl1r3(1,2)     covl2r3(1,2)        covl3r3(1,2)        covl4r3(1,2)        covr1r3(1,2)        covr2r3(1,2)        cov(dphi_r(3,:))    0;
       covl1r4(1,2)     covl2r4(1,2)        covl3r4(1,2)        covl4r4(1,2)        covr1r4(1,2)        covr2r4(1,2)        covr3r4(1,2)        cov(dphi_r(4,:))];

R_dia = R_w;
for i = 1:size(R_w,2)
    R_dia(i,i) = 0;
end
R_w = R_w + R_dia';
