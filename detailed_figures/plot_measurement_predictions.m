%% GYRO
load('gyro_estimate')
time = ans(1,:);
meas = ans(2,:);
pred = ans(3,:);

figure(1)
xlim([20 30])
plot(time,meas)
hold on
grid on
plot(time,pred)
xlabel('time [s]','Fontsize',24)
ylabel('rotational velocity [rad/s]','Fontsize',24)
legend('measured','predicted')
set(gca,'Fontsize',24)


%% WHEEL
load('wheel_estimate')
time = ans(1,:);
meas = ans(2,:);
pred = ans(3,:);

figure(2)
xlim([20 30])
plot(time,meas)
hold on
grid on
plot(time,pred)
xlabel('time [s]','Fontsize',24)
ylabel('lateral velocity [m/s]','Fontsize',24)
legend('measured','predicted')
set(gca,'Fontsize',24)

%% IMU
load('imu_estimate')
time = ans(1,:);
meas = ans(2,:);
pred = ans(3,:);

figure(3)
xlim([20 30])
plot(time,meas,'LineWidth',2)
hold on
grid on
plot(time,pred,'LineWidth',2)
xlabel('time [s]','Fontsize',24)
title('Prediction and measurement of LPF x-acceleration')
ylabel('lateral acceleration [m/s^2]','Fontsize',24)
legend('measured','predicted')
set(gca,'Fontsize',24)