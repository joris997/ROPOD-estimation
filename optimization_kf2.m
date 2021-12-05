%% Optimization script of first Kalman filter (orientation)
% This script iteratively optimizes the measurement covariance matrix
% scaling factors for the multiplication factor for the wheels and the IMU. 
% It works by running the Simulink datarun and comparing the results of the
% localization with the results from the Jupiter sensor. It requires
% manually alligning Jupiter and Kalman filter data beforehand in the
% script "plotting_path.m"

% J.P.M. Verhagen
% BEP: Odometry and localization esitmation of a mobile robot with multiple
% swivel wheels
% Commented on: 27-01-2019

R_mult_w = [0.01 0.1 10];
R_mult_i = [0.01 0.1 10];
    
for i = 1:10
    count1 = size(R_mult_w,2);
    count2 = size(R_mult_i,2);
    P = zeros(count1,count2);
    
    for ii = 1:count1
        for iii = 1:count2
            R_w = R_mult_w(ii);
            R_i = R_mult_i(iii);
            sim('datarun_working')
            run('plotting_path')

            count3 = size(x_ju,2)-1;
            P_index = zeros(1,count3);
            dis_kf = 0;

            for k = 1:count3
                abs_diff = sqrt( (y_ju(k)-y_kf(k+(k-1)*200))^2 + (x_ju(k)-x_kf(k+(k-1)*200))^2 );
                dis_kf = dis_kf + sqrt((x_kf(k+(k)*200)-x_kf(k+(k-1)*200))^2 + (y_kf(k+(k)*200)-y_kf(k+(k-1)*200))^2);
                P_index(k) = abs_diff/dis_kf;
            end
            P(ii,iii) = mean(P_index);
        end
    end

%     [best,index] = min(P);
%     [best_row,best_col] = ind2sub(size(P),index);
    best = min(min(P));
    [best_row,best_col] = find(P==best);
    

        if best_row == 1
            R_mult_w = [R_mult_w(1)/2, R_mult_w(1), 1.5*R_mult_w(1)];
        elseif best_row == 2
            R_mult_w = [R_mult_w(2)/2, R_mult_w(2), 1.5*R_mult_w(2)];
        elseif best_row == 3
            R_mult_w = [R_mult_w(3)/2, R_mult_w(3), 1.5*R_mult_w(3)];
        end
   
        if best_col == 1
            R_mult_i = [R_mult_i(1)/2, R_mult_i(1), 1.5*R_mult_i(1)];
        elseif best_col == 2
            R_mult_i = [R_mult_i(2)/2, R_mult_i(2), 1.5*R_mult_i(2)];
        elseif best_col == 3
            R_mult_i = [R_mult_i(3)/2, R_mult_i(3), 1.5*R_mult_i(3)];
        end
        
end