close; clc;

load('kalman_xyt.mat')
load('encoder_xyt.mat')
load('dxr_dyr_kf.mat')
load('dxr_dyr_en.mat')
ju_structx = load('p_p_p_x.mat');
ju_t_x = ju_structx.ans;
ju_structy = load('p_p_p_y.mat');
ju_t_y = ju_structy.ans;
dxrju_struct = load('t_t_l_x.mat');
dxr_ju = dxrju_struct.ans;
dyrju_struct = load('t_t_l_y.mat');
dyr_ju = dyrju_struct.ans;
thju_struct = load('p_p_o_w.mat');
th_ju = thju_struct.ans;
dthju_struct = load('t_t_a_z.mat');
dth_ju = dthju_struct.ans;
dxr_dyr_local_struct = load('dxr_dyr_local.mat');
dxr_dyr_local = dxr_dyr_local_struct.dxr_dyr_local;
dxr_dyr_globalfromlocal = load('dxdy_global_from_local.mat');
dxr_dyr_global_from_local = dxr_dyr_globalfromlocal.dxdy_global_from_local;

%% Theta (orientation)
th_en = encoder_xyt(6,:);
th_kf = kalman_xyt(6,:);

figure(1)
plot(encoder_xyt(1,:),-th_en,'LineWidth',2)
hold on
grid on
plot(kalman_xyt(1,:),th_kf,'LineWidth',2)
plot(th_ju(1,:)+19.93,cumtrapz(dth_ju(2,:))/5,'LineWidth',2)
% y = -2*pi;
% x = 1:max(kalman_xyt(1,:));
% plot(x,y*ones(size(x)),'LineWidth',2)
xlabel('time [s]','Fontsize',24)
ylabel('orientation [rad]','Fontsize',24)
legend('encoder','KF','Jupiter')
set(gca,'Fontsize',24)

%% Localization (global positioning)
x_en = encoder_xyt(2,:);
y_en = encoder_xyt(4,:);
x_kf = kalman_xyt(2,:);
y_kf = kalman_xyt(4,:);
x_ju = ju_t_x(2,:);
y_ju = ju_t_y(2,:);
x_kf_lo = dxr_dyr_global_from_local(2,:);
y_kf_lo = dxr_dyr_global_from_local(5,:);


figure(2)
plot(x_en,y_en,'LineWidth',2)
hold on
grid on
plot(x_kf,y_kf,'LineWidth',2)
% plot(x_kf_lo,y_kf_lo,'LineWidth',2)
plot(x_ju,y_ju,'LineWidth',2)
xlabel('Global position x [m]','Fontsize',24)
ylabel('Global position y [m]','Fontsize',24)
legend('encoder','KF','Jupiter')
set(gca,'Fontsize',24)

%% Odometry (local velocity in x)
dx_en = dxr_dyr_en(2,:);
dx_kf = dxr_dyr_kf(2,:);
dx_ju = dxr_ju(2,:);
dx_local = dxr_dyr_local(2,:);
figure(3)
plot(dxr_dyr_en(1,:),dx_en,'LineWidth',3)
hold on
grid on
%plot(dxr_dyr_kf(1,:),dx_kf,'LineWidth',2)
plot(dxr_dyr_local(1,:),dx_local,'LineWidth',3)
plot(dxr_ju(1,:)+20-0.16,dx_ju,'LineWidth',3)
xlabel('time [s]','Fontsize',24)
ylabel('local velocity [m/s]','Fontsize',24)
legend('encoder','KF','Jupiter')
set(gca,'Fontsize',24)