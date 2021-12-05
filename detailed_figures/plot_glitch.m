glitch = ans(2,:);
time = ans(1,:);

glitch = glitch(:,20000:25000);
time = time(:,20000:25000);

figure(1)
xlim([20 25])
plot(time,glitch,'LineWidth',2)
xlabel('time [s]','Fontsize',24)
ylabel('rotational velocity [rad/s]','Fontsize',24)
set(gca,'Fontsize',24)
