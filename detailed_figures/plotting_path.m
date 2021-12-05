close; clc;

ju_structx = load('p_p_p_x.mat');
ju_t_x = ju_structx.ans;
ju_structy = load('p_p_p_y.mat');
ju_t_y = ju_structy.ans;
kf_struct = load('kalman_filter.mat');
kalman_filter = kf_struct.ans;
en_struct = load('encoder.mat');
encoder = en_struct.ans;

x_kf = kalman_filter(2,:);
y_kf = kalman_filter(3,:);
th_kf = kalman_filter(4,:);

x_en = encoder(2,:);
y_en = encoder(3,:);
th_en = encoder(4,:);

x_ju = ju_t_x(2,:);
y_ju = ju_t_y(2,:);

%% Usefull data
begin_alg = 1;
end_alg = 62464;
begin_jup = 1;
end_jup = 249;

x_kf = x_kf(begin_alg:end_alg);
y_kf = y_kf(begin_alg:end_alg);
x_en = x_en(begin_alg:end_alg);
y_en = y_en(begin_alg:end_alg);
x_ju = x_ju(begin_jup:end_jup);
y_ju = y_ju(begin_jup:end_jup);

%% Plotting
figure(1)
plot(x_kf,y_kf,'LineWidth',2)
hold on
grid on
plot(x_en,y_en,'LineWidth',2) 
plot(x_ju,y_ju,'LineWidth',2)
xlabel('Global position x [m]')
ylabel('Global position y [m]')
legend('Kalman filter','Encoder data','Jupiter sensor')
set(gca,'Fontsize',24)

%% Local velocity from global
dxrdyren_struct = load('dxr_dyr_en.mat');
dxrdyr_en = dxrdyren_struct.dxr_dyr_en;
dxrdyrkf_struct = load('dxr_dyr_kf.mat');
dxrdyr_kf = dxrdyrkf_struct.dxr_dyr_kf;
dxrdyrtrue_struct = load('kalman_filter_local.mat');
dxrdyr_local = dxrdyrtrue_struct.kalman_filter_local;

dxrju_struct = load('t_t_l_x.mat');
dxr_ju = dxrju_struct.ans;
dyrju_struct = load('t_t_l_y.mat');
dyr_ju = dyrju_struct.ans;

figure(2)
subplot(2,1,1)
time = dxrdyr_en(1,:);
plot(time,dxrdyr_en(2,:))
hold on
grid on
%plot(time,dxrdyr_local(2,:))
plot(dxr_ju(1,:)+16.63,dxr_ju(2,:))
plot(time,dxrdyr_kf(2,:))
legend('encoder','jupiter','global KF')

subplot(2,1,2)
plot(time,dxrdyr_en(3,:))
hold on
grid on
%plot(time,dxrdyr_local(4,:))
plot(dyr_ju(1,:)+16.63,dyr_ju(2,:))
plot(time,dxrdyr_kf(3,:))
legend('encoder','jupiter','global KF')

%% Local velocity true
% figure(3)
% subplot(2,1,1)
% time = dxrdyr_local(1,:);
% plot(time,dxrdyr_en(2,:))
% hold on
% grid on
% plot(time,dxrdyr_local(2,:))
% 
% subplot(2,1,2)
% plot(time,dxrdyr_en(3,:))
% hold on
% grid on
% plot(time,dxrdyr_local(4,:))

% figure(1)
% plot(x_kf,y_kf,'Linewidth',3)
% grid on
% xlabel('x-location [m]','Fontsize',24)
% ylabel('y-location [m]','Fontsize',24)
% set(gca,'Fontsize',24)

% figure(2)
% for i = 1:size(x_ju,2)
%     plot(x_kf(i+(i-1)*200),y_kf(i+(i-1)*200))
%     plot(x_ju(i),y_ju(i))
%     hold on
% end
%% Performance mark
% dis_kf = 0;
% dis_en = 0;
% dis_ju = 0;
% for i = 1:size(x_kf,2)-1
%     dis_kf = dis_kf + sqrt((x_kf(i+1)-x_kf(i))^2+(y_kf(i+1)-y_kf(i))^2);
%     dis_en = dis_en + sqrt((x_en(i+1)-x_en(i))^2+(y_en(i+1)-y_en(i))^2);
% end
% 
% for i = 1:size(x_ju,2)-1
%     dis_ju = dis_ju + sqrt((x_ju(i+1)-x_ju(i))^2+(y_ju(i+1)-y_ju(i))^2);
% end

% % dis_kf = trapz(x_kf) + trapz(y_kf);
% % dis_en = trapz(x_en) + trapz(y_en);
% % dis_ju = trapz(x_ju) + trapz(y_ju);
% 
% % diff_kf = sqrt((x_kf(end))^2+(y_kf(end))^2);
% % diff_en = sqrt((x_en(end))^2+(y_en(end))^2);
% % diff_ju = sqrt((x_ju(end))^2+(y_ju(end))^2);
% 
% rating_kf = diff_kf/dis_kf*100;
% rating_en = diff_en/dis_en*100;
% rating_ju = diff_ju/dis_ju*100;



%% Rest
% figure(2)
% hold on
% xlim([min([min(x_en(:));min(x_kf(:));min(-x_ju(:))]) max([max(x_en(:));max(x_kf(:));max(-x_ju(:))])])
% ylim([min([min(y_en(:));min(y_kf(:));min(-y_ju(:))]) max([max(y_en(:));max(y_kf(:));max(-y_ju(:))])])
% 
% 
% for k = 1:numel(x_kf)
%     if rem(k,10) == 0
%         plot(x_kf(k),y_kf(k),'Marker','.','Color','r')
%         plot(x_en(k),y_en(k),'Marker','.','Color','b')
%     end
%     if rem(k,200) == 0
%         plot(-x_ju(k/200),-y_ju(k/200),'Marker','*','Color','g')
%         pause(0.2)
%     end
% end