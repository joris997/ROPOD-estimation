%% Optimization script of first Kalman filter (orientation)
% This script iteratively optimizes the measurement covariance matrix
% scaling factor for the relative covariance between Q and R. It works by
% running the Simulink datarun and comparing the results of the
% localization with the results from the Jupiter sensor. It requires
% manually alligning Jupiter and Kalman filter data beforehand in the
% script "plotting_path.m"

% J.P.M. Verhagen
% BEP: Odometry and localization esitmation of a mobile robot with multiple
% swivel wheels
% Commented on: 27-01-2019

R_mult = [100000 1000000 10000000];
    
for i = 1:20
    count1 = size(R_mult,2);
    P = zeros(1,count1);
    run_cnt = i
    for ii = 1:count1
            R_g = R_mult(ii);
            sim('datarun_final')
            run('plotting_path')
            count2 = size(x_ju,2)-1;
            P_index = zeros(1,count2);
            dis_kf = 0;
            count = ii
            for k = 1:count2
                abs_diff = sqrt( (y_ju(k)-y_kf(k+(k-1)*200))^2 + (x_ju(k)-x_kf(k+(k-1)*200))^2 );
                dis_kf = dis_kf + sqrt((x_kf(1+(k)*200)-x_kf(1+(k-1)*200))^2 + (y_kf(1+(k)*200)-y_kf(1+(k-1)*200))^2);
                P_index(k) = abs_diff/dis_kf;
            end
            P(1,ii) = mean(P_index);
    end

%     [best,index] = min(P);
%     [best_row,best_col] = ind2sub(size(P),index);
    best = min(P);
    best_col = find(P==best);
   
        if best_col == 1
            R_mult = [R_mult(1)/4, R_mult(1), 1.25*R_mult(1)];
        elseif best_col == 2
            R_mult = [R_mult(2)/4, R_mult(2), 1.25*R_mult(2)];
        elseif best_col == 3
            R_mult = [R_mult(3)/4, R_mult(3), 1.25*R_mult(3)];
        end
        
end