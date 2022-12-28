clc; close all; clear;
%Variable Declarations
maxNumberUsers = 16; % maximum number of users
max_iterations = 10000; % total number of iterations
SNR_db=0; % SNR value in decibel
SNR_linear_scale=10.^(SNR_db/10); % Converting SNR in decibel to linear scale

for user=1:1:maxNumberUsers
  for iter=1:1:max_iterations
      dev_channel_gain_complex= randn(1,user,"like",1i); % randomly select complex numbers for each user
      dev_channel_gain_abs = abs(dev_channel_gain_complex); % converts the complex numbers to absolute values
      maximum=max(dev_channel_gain_abs.^2); % calculates the square of the gains selected by the users and find the maximum gain
      sum_cap_ray=log2(1+(maximum*SNR_linear_scale)); % calculates the rayleigh fading channel's throughput for the number of users
      user_throughput_per_iter{iter}= sum_cap_ray; % stores the value of the rayleigh fading throughput for each iteration
  
  end
  throughput_rayleigh_fading(user)=sum(cell2mat(user_throughput_per_iter))/max_iterations;  %average throughput of the users in a rayleigh fading channel
  throughput_AWGN(user) = log2(1 + SNR_linear_scale); %throughput of the users in an AWGN channel
 end
% Graph to plot throughput of Rayleigh fading channel
figure(1);
plot(1:1:maxNumberUsers, throughput_rayleigh_fading,'r-','LineWidth',1);
grid on ; hold on ;
xlabel('Number of Users');
ylabel('Total Throughput in bps/H_z');
title('Sum Capacity of two channels');
% Graph to plot throughput of AWGN channel
figure(1);
plot(1:1:maxNumberUsers, throughput_AWGN,'Color','k','LineStyle','--','LineWidth',1);
legend('Rayleigh Fading','AWGN Channel','Location','northwest')