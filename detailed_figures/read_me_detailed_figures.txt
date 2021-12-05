J.P.M. Verhagen
BEP: Odometry and localization esitmation of a mobile robot with multiple
swivel wheels
Written on: 27-01-2019

This file explains the files and folders that are seen here.

FOLDERS:
figures: 			contains some of the figures that are used in the report

FILES:
all_wheel_out_data.mat: 	normal data set
all_wheel_out_data_static.mat: 	static measurements (about 5 minutes of the RoPod standing still)
glitch_dphi.mat: 		set of wheel encoder velocities to indicate occurring glitches
gyro_estimate.mat: 		set of gyroscope prediction from the 1st KF
IMU_amplitude_spec.m: 		plots the single-sided amplitude spectrum of the IMU data (change the column that you pick from the dataset to change from accelerometer to gyroscope)
imu_estimate.mat: 		set of IMU signal predictions from the 2nd KF
IMU_sensor_drift.m: 		plots the (not occurruing) drift of the IMU signal for the report
plot_glitch.m: 			plots the glitch from glitch_dphi.mat
plot_measurement_predictions.m: plots other measurements predictions
plot_raw_acc.mat: 		plot prefiltered accelerometer data 
plotting_final_results.m: 	plotting the paths of the encoder-, kf-, and jupiter data
plotting_frf.m: 		plotting the single sided amplitude spectrum of the accelerometer and the gyroscope static data
plotting_path.m: 		some other way of plotting the path for specific figures
plotting_presentation.m: 	file for some additional plots with different layout for the presentation
wheel_estimate.m: 		set of data of the wheel estimate obtained from the 2nd KF