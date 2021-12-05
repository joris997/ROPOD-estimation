J.P.M. Verhagen
BEP: Odometry and localization esitmation of a mobile robot with multiple
swivel wheels
Written on: 27-01-2019

This file explains the files and folders that are seen here.


FOLDERS:

detailed_figures:           Includes images, plotting script, and measurement data
measurement_data:           Includes measurement data on different floor types of both the LKF framework, the encoder mapping, and the Jupiter sensor
models_and_calculations:    includes all the calculations that are made for this framework. Includes measurement mapping computation for
                            imu and wheel encoders, analysis of IMU noise, drift, and covariance.
real_time_running:          Includes files and folders which are used to run code on the RoPod and to run the Jupiter in a real-time Simulink environment.
                            Opening "run_jupiter_real_time.slx" in "running_jupiter" provides this Simulink environment. This folder is also accompanied with measurement
                            data of only the Jupiter sensor used in Chapter 6 of the report.


FILES:

all_wheel_out_data.mat:         data from all smart wheels
bGbAtheta.mat:                  realignment of gyroscope, accelerometer in format: Bias gyro, Bias acc, offset angle theta (see Chapter 5 of the report)
bias_complex.m:                 computes bias of gyroscope and accelerometer and the offset angle of the IMU
bias_simple.m:                  computes just the bias of the gyroscope and accelerometer
datarun_final.slx:              final LKF framework 
ec_structdata.txt:              file explaining layout of all_wheel_out_data.mat
global_positioning_results.m:   plots results of estimation of all three methods
measurement_data.xlsx:          results of all experiments in Excel table
new_bias.m:                     simple way of calculating the bias of the gyro and the IMU
odom_robot_pose.mat:            computed pose by the encoder mapping
odom_robot_twist.mat:           computed twist/velocities by the encoder mapping
optimization_kf1.mat:           optimizes scaling factor R_mult for 1st LKF
optimization_kf2.mat:           optimizes scaling factors R_wheel and R_imu for 2nd LKF