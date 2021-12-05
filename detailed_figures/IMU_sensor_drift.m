clear; close; clc
load('all_wheel_out_data_static.mat')
all_wheel_out_data = all_wheel_out_data(:,35000:end);

time = all_wheel_out_data(1,:);
temp = all_wheel_out_data(40,:);

a_x = all_wheel_out_data(34,:)--0.0561;
a_y = all_wheel_out_data(35,:);
a_z = all_wheel_out_data(36,:);

g_x = all_wheel_out_data(37,:);
g_y = all_wheel_out_data(38,:);
g_z = all_wheel_out_data(39,:);

figure(1)
plot(time,g_x,'.')
hold on
sum_g_x = zeros(1,length(g_x)+1);
mean_g_x = zeros(1,length(g_x));
for i = 1:length(g_x)
    sum_g_x(i+1) = sum_g_x(i) + g_x(i);
    mean_g_x(i) = sum_g_x(i)/i;
end
plot([time],mean_g_x,'LineWidth',4)
grid on
xlabel('time [s]','Fontsize',24)
ylabel('rate of turn [rad/s]','Fontsize',24)
legend('measured rate of turn','interative mean')
set(gca,'Fontsize',24)

figure(2)
plot(time,a_x,'.')
hold on
sum_a_x = zeros(1,length(a_x)+1);
mean_a_x = zeros(1,length(a_x));
for i = 1:length(a_x)
    sum_a_x(i+1) = sum_a_x(i) + a_x(i);
    mean_a_x(i) = sum_a_x(i)/i;
end
plot([time],mean_a_x,'LineWidth',4)
grid on
xlabel('time [s]','Fontsize',24)
ylabel('acceleration [m/s^2]','Fontsize',24)
legend('measured accelerations','interative mean')
set(gca,'Fontsize',24)

figure(3)
histfit(a_x)
grid on
xlabel('measured acceleration [m/s^2]','Fontsize',24)
ylabel('pdf [-]','Fontsize',24)
legend('measurement','Gaussian')
set(gca,'Fontsize',24)

figure(4)
histfit(g_x)
grid on
xlabel('measured rate of turn [rad/s]','Fontsize',24)
ylabel('pdf [-]','Fontsize',24)
legend('measurement','Gaussian')
set(gca,'Fontsize',24)