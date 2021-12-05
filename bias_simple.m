bias_x = zeros(1,4);
bias_y = zeros(1,4);
bias_gx = zeros(1,4);
bias_gy = zeros(1,4);
bias_gz = zeros(1,4);

begin = 10370;
final = 18690;

for i = 1:4
    
a_x_un = all_wheel_out_data(34+(i-1)*40,:);
a_y_un = all_wheel_out_data(35+(i-1)*40,:);
a_z_un = all_wheel_out_data(36+(i-1)*40,:);

a_x_1 = -a_z_un;
a_y_1 = a_x_un;

bias_x(i) = mean(a_x_1(begin:final));
bias_y(i) = mean(a_y_1(begin:final));




gx_un = all_wheel_out_data(37+(i-1)*40,:);
gy_un = all_wheel_out_data(38+(i-1)*40,:);
gz_un = all_wheel_out_data(39+(i-1)*40,:);

bias_gx(i) = mean(gx_un(begin:final));
bias_gy(i) = mean(gy_un(begin:final));
bias_gz(i) = mean(gz_un(begin:final));
end

simple_bias_imu = [bias_x; bias_y];
save('simple_bias_imu.mat','simple_bias_imu')

simple_bias_gyro = [bias_gx; bias_gy; bias_gz];
save('simple_bias_gyro.mat','simple_bias_gyro')