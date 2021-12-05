a_y = all_wheel_out_data(35,:) - mean(all_wheel_out_data(35,:));

Fs = 1000;            % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = length(a_y);      % Length of signal
t = (0:L-1)*T;        % Time vector

Y = fft(a_y);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;
plot(f,P1) 
title('Single-Sided Amplitude Spectrum of a_y(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')
uint16_t = all_wheel_out_data(1,:);
IMU_acc_X = all_wheel_out_data(35,:);