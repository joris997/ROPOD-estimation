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

figure(1)
plot(dxr_dyr_local(1,:),dxr_dyr_local(2,:))
%% Localization (global positioning)
begin_m = 20100;
final_m = size(dxr_dyr_local,2);
begin_j = 1;
final_j = size(ju_t_y,2);

extra_x = 5;
extra_y = -5;

x_en = encoder_xyt(2,begin_m:final_m);
y_en = encoder_xyt(4,begin_m:final_m);
x_kf = kalman_xyt(2,begin_m:final_m);
y_kf = kalman_xyt(4,begin_m:final_m);
x_ju = ju_t_x(2,begin_j:final_j);
y_ju = ju_t_y(2,begin_j:final_j);


figure(2)
plot(x_en,y_en,'LineWidth',3)
hold on
grid on
plot(x_kf,y_kf,'LineWidth',3)
% plot(x_kf_lo,y_kf_lo,'LineWidth',2)
plot(x_ju,y_ju,'LineWidth',3)
xlabel('Global position x [m]','Fontsize',24)
ylabel('Global position y [m]','Fontsize',24)
legend('encoder','KF','Jupiter')
title('Global positioning for a driven square on tiling')
set(gca,'Fontsize',24)

dis_kf = 0;
dis_en = 0;
dis_ju = 0;
for k = 1:size(x_en,2)-1
    dis_kf = dis_kf + sqrt((x_kf(1+k)-x_kf(k))^2 + (y_kf(1+k)-y_kf(k))^2);
    dis_en = dis_en + sqrt((x_en(1+k)-x_en(k))^2 + (y_en(1+k)-y_en(k))^2);
end
for k = 1:size(x_ju,2)-1
    dis_ju = dis_ju + sqrt((x_ju(1+k)-x_ju(k))^2 + (y_ju(1+k)-y_ju(k))^2);
end
diff_kf = sqrt((x_kf(end)-extra_x)^2+(y_kf(end)-extra_y)^2);
diff_en = sqrt((x_en(end)-extra_x)^2+(y_en(end)-extra_y)^2);
diff_ju = sqrt((x_ju(end)-extra_x)^2+(y_ju(end)-extra_y)^2);

perf = [diff_en/dis_ju diff_kf/dis_ju diff_ju/dis_ju]*100