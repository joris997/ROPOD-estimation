load('a_x_alligned.mat')
load('a_y_alligned.mat')

Fs = 1000;
T = 1/Fs;
L = 82309;

% figure(1)
% for i = 1:4
%     
%     Y = fft(a_x_alligned(i+1,:));
%     P2 = abs(Y/L);
%     P1 = P2(1:L/2+1);
%     P1(2:end-1) = 2*P1(2:end-1);
%     f = Fs*(0:(L/2))/L;
%     subplot(2,2,i)
%     semilogy(f,P1) 
%     title('Single-Sided Amplitude Spectrum of x-acceleration')
%     xlabel('f (Hz)')
%     ylabel('|P1(f)|')
% 
% end
% 
% figure(2)
% for i = 1:4
%     
%     Y = fft(a_y_alligned(i+1,:));
%     P2 = abs(Y/L);
%     P1 = P2(1:L/2+1);
%     P1(2:end-1) = 2*P1(2:end-1);
%     f = Fs*(0:(L/2))/L;
%     figure(2)
%     subplot(2,2,i)
%     plot(f,P1) 
%     title('Single-Sided Amplitude Spectrum of y-acceleration')
%     xlabel('f (Hz)')
%     ylabel('|P1(f)|')
% 
% end
% 
% %% after LP filter
% load('a_x_lp.mat')
% load('a_y_lp.mat')
% 
% Fs = 1000;
% T = 1/Fs;
% L = 82309;
% 
% figure(3)
% for i = 1:4
%     
%     Y = fft(a_x_lp(i+1,:));
%     P2 = abs(Y/L);
%     P1 = P2(1:L/2+1);
%     P1(2:end-1) = 2*P1(2:end-1);
%     f = Fs*(0:(L/2))/L;
%     subplot(2,2,i)
%     plot(f,P1) 
%     title('Single-Sided Amplitude Spectrum of x-acceleration after LP')
%     xlabel('f (Hz)')
%     ylabel('|P1(f)|')
% 
% end
% 
% figure(4)
% for i = 1:4
%     
%     Y = fft(a_y_lp(i+1,:));
%     P2 = abs(Y/L);
%     P1 = P2(1:L/2+1);
%     P1(2:end-1) = 2*P1(2:end-1);
%     f = Fs*(0:(L/2))/L;
%     figure(2)
%     subplot(2,2,i)
%     plot(f,P1) 
%     title('Single-Sided Amplitude Spectrum of y-acceleration after LP')
%     xlabel('f (Hz)')
%     ylabel('|P1(f)|')
% 
% end

%% figures report
figure(5)
Y = fft(a_y_alligned(2,:));
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;
semilogy(f,P1) 
ylim = [5*10^-7 1*10^0];
grid on
title('Single-Sided Amplitude Spectrum of y-acceleration')
xlabel('f (Hz)','Fontsize',30)
ylabel('|P1(f)|','Fontsize',30)
set(gca,'Fontsize',30)

figure(6)
Y = fft(a_y_lp(2,:));
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;
semilogy(f,P1) 
ylim = [5*10^-7 1*10^0];
grid on
title('Single-Sided Amplitude Spectrum of y-acceleration after LP')
xlabel('f (Hz)','Fontsize',30)
ylabel('|P1(f)|','Fontsize',30)
set(gca,'Fontsize',30)