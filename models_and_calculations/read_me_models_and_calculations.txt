J.P.M. Verhagen
BEP: Odometry and localization esitmation of a mobile robot with multiple
swivel wheels
Written on: 27-01-2019

This file explains the files that are seen here.

all_data_2_square.mat: data set of driving in a square
all_wheel_out_data.mat: other data set
bGbAtheta.mat: bias gyroscope, bias accelerometer and offset angle theta (gamma in report) in a .mat file
gyro_pivotencoder_gain.m: turned out I had to divide the prediction of the gyroscope by two. The calculated velocity of the pivot encoder was determined incorrectly. This script calculates that 'gain'
kf2_measurement_covariance.m: attempt to completely compute the measurement covariance matrix of the second Kalman filter. Not used in the end.
measurement_model_imu.m: computes the equation to go from state to expected measurement of the IMU
measurement_model_wheelencoders.m: same but for the wheel encoders
