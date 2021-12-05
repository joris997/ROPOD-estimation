clear; close; clc

load('all_wheel_out_data.mat')
gz_est_meas_struct = load('gz_est_small_meas.mat');
gz_est_small = gz_est_meas_struct.ans;
time = all_wheel_out_data(1,:);
%% Scaling for pivot point 1
figure(1)
grid on; hold on;
plot(time,all_wheel_out_data(31,:))
plot(time,gz_est_small(3,2:end))
legend('ddelta','gyro')
% rotation of 1/2*pi occuring between 
t1=1000*[16.95 18.5];
t2=1000*[22.42 23.16];
t3=1000*[28.18 29.06];

angle_ddelta1 = rad2deg(trapz(time(1,t1(1):t1(2)),all_wheel_out_data(31,t1(1):t1(2))));
angle_gyro1   = rad2deg(trapz(time(1,t1(1):t1(2)),gz_est_small(3,t1(1):t1(2))));

angle_ddelta2 = rad2deg(trapz(time(1,t2(1):t2(2)),all_wheel_out_data(31,t2(1):t2(2))));
angle_gyro2   = rad2deg(trapz(time(1,t2(1):t2(2)),gz_est_small(3,t2(1):t2(2))));

angle_ddelta3 = rad2deg(trapz(time(1,t3(1):t3(2)),all_wheel_out_data(31,t3(1):t3(2))));
angle_gyro3   = rad2deg(trapz(time(1,t3(1):t3(2)),gz_est_small(3,t3(1):t3(2))));

gain_matrix = [angle_ddelta1/angle_gyro1 angle_ddelta2/angle_gyro2 angle_ddelta3/angle_gyro3]
K_ddelta = 1/mean(gain_matrix)