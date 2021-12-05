time = all_wheel_out_data(1,:);
gyrx = all_wheel_out_data(37,:);
gyry = all_wheel_out_data(38,:);
gyrz = all_wheel_out_data(39,:);

time = time(:,27000:32000);
gyrx = gyrx(:,27000:32000);
gyry = gyry(:,27000:32000);
gyrz = gyrz(:,27000:32000);

figure(1)

plot(time,gyrx)
hold on
plot(time,gyry)
plot(time,gyrz)
xlabel('time [s]')
ylabel('rotational velocity [rad/s]')
legend('g_x','g_y','g_z')
set(gca,'Fontsize',24)
axis([27 32 -0.5 0.5])