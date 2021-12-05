clear; close; clc;

load("all_wheel_out_data.mat");
wheel_data = struct2array(load('all_wheel_out_data.mat'));

%% Bias of gyro IMU sensors
begin = 13000;
final = 22000;

b_length = size(all_wheel_out_data(:,begin:final),2);
b_g_x = zeros(4,b_length);b_g_y = zeros(4,b_length);b_g_z = zeros(4,b_length);
b_g_mean_x = zeros(4,1); b_g_mean_y = zeros(4,1); b_g_mean_z = zeros(4,1);
for i = 1:4
    b_g_x(i,:) = all_wheel_out_data(37+(i-1)*40,begin:final);     % sliced static measurement data
    b_g_y(i,:) = all_wheel_out_data(38+(i-1)*40,begin:final);
    b_g_z(i,:) = all_wheel_out_data(39+(i-1)*40,begin:final);

    b_g_mean_x(i) = mean(b_g_x(i,:));                             % mean value of static measurements
    b_g_mean_y(i) = mean(b_g_y(i,:));
    b_g_mean_z(i) = mean(b_g_z(i,:));
end

%% Realignment load data
r_length = size(wheel_data(:,begin:final),2);
r_g_x = zeros(4,r_length); r_g_y = zeros(4,r_length); r_g_z = zeros(4,r_length);
for i = 1:4
    r_g_x(i,:) = wheel_data(37+(i-1)*40,begin:final)-b_g_mean_x(i);
    r_g_y(i,:) = wheel_data(38+(i-1)*40,begin:final)-b_g_mean_y(i);
    r_g_z(i,:) = wheel_data(39+(i-1)*40,begin:final)-b_g_mean_z(i);
end

%% Rough realignment (may change depending on IMU readings)
rr_g_x = r_g_x;
rr_g_y = r_g_z;
rr_g_z = r_g_y;

theta = zeros(4,r_length);
theta_mean = zeros(4,1);
for i = 1:4
    for ii = 1:r_length
        theta(i,ii) = atan(rr_g_y(i,ii)/rr_g_z(i,ii));
    end
    theta_mean(i,:) = mean(theta(i,:));
end
%% Fine realignment
fr_g_z = sqrt(rr_g_x.^2 + rr_g_y.^2 + rr_g_z.^2).*sign(rr_g_z);

%% Bias of accel IMU sensors
phi = 51.436596;
g = 9.806 - 1/2*(9.832 - 9.780)*cos(2*phi*(pi/180));

b_a_x = zeros(4,b_length); b_a_y = zeros(4,b_length); b_a_z = zeros(4,b_length);
for i = 1:4
    b_a_x(i,:) = all_wheel_out_data(34+(i-1)*40,begin:final);
    b_a_y(i,:) = all_wheel_out_data(35+(i-1)*40,begin:final);
    b_a_z(i,:) = all_wheel_out_data(36+(i-1)*40,begin:final);
end

%% Rough realignment (may change depending on IMU readings)
rb_a_x = b_a_x;
rb_a_y = b_a_z;
rb_a_z = b_a_y;

%% Fine realignment
rr_a_x = zeros(4,b_length);rr_a_y = zeros(4,b_length);rr_a_z = zeros(4,b_length);
b_a_mean_x = zeros(4,1);b_a_mean_y = zeros(4,1);b_a_mean_z = zeros(4,1);
for i = 1:4
    rr_a_x(i,:) = rb_a_x(i,:);
    rr_a_y(i,:) = rb_a_y(i,:)/cos(theta_mean(i));
    rr_a_z(i,:) = rb_a_z(i,:)/cos(theta_mean(i));
    
    b_a_mean_x(i,:) = mean(rr_a_x(i,:));
    b_a_mean_y(i,:) = mean(rr_a_y(i,:));
    b_a_mean_z(i,:) = mean(rr_a_z(i,:)) - g;
end

% figure(1)
% plot(rr_a_y(1,:))
% hold on
% plot(rb_a_y(1,:))
% plot(rr_a_z(1,:))
% plot(rb_a_z(1,:))

biasGbiasAtheta = [b_g_mean_x';b_g_mean_y';b_g_mean_z';
                   b_a_mean_x';b_a_mean_y';b_a_mean_z';
                   theta_mean'];

save("bGbAtheta.mat",'biasGbiasAtheta')



%% Low Pass filters
