asdf = open('wheel_velocities_slip.mat');
wheel_velocities_slip = asdf.wheel_velocities_slip;
fdsa = open('residual_left.mat');
residual_left = fdsa.residual_left;
time = residual_left(1,:);

figure(1)
plot(time,wheel_velocities_slip(2,:),'LineWidth',2)
hold on 
grid on
plot(time,wheel_velocities_slip(3,:),'LineWidth',2)
plot(time,wheel_velocities_slip(4,:),'LineWidth',2)
plot(time,wheel_velocities_slip(5,:),'LineWidth',2)
xlabel('time [s]','Fontsize',24)
ylabel('lateral wheel velocity [m/s]','Fontsize',24)
legend('left wheel pivot 1','lw p2','lw p3','lw p4')
title('Lateral wheel velocities of left wheels')
set(gca,'Fontsize',24)

figure(2)
plot(time,residual_left(2,:),'LineWidth',2)
hold on 
grid on
plot(time,residual_left(3,:),'LineWidth',2)
plot(time,residual_left(4,:),'LineWidth',2)
plot(time,residual_left(5,:),'LineWidth',2)
xlabel('time [s]','Fontsize',24)
ylabel('residual (measured - predicted) [m/s]','Fontsize',24)
legend('left wheel pivot 1','lw p2','lw p3','lw p4')
title('Residual of lateral wheel velocity measurement and prediction')
set(gca,'Fontsize',24)