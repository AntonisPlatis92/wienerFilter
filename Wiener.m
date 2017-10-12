%% Antonis Platis 7512
%% Psifiaka Filtra Ergasia 1
clear all;
close all;

load('noise.mat')  %Load the d and u vectors
load('sound.mat')

n=60;   %Computation of matrix R and vector P
r = xcorr(u,u,n-1,'unbiased');
r=r(60:end);
R = toeplitz(r);
P = zeros(60,1);
P(1,1) = 0.8;
w0 = R\P; % Suntelestes Wiener-Hopf

for i=1:60  %Initial values of w
    w(i,1)=-1;
end
mu = 0.019;  %Step


y = zeros(length(d), 1); 
s = [0; u];

for i=2:length(d)
  w = w + mu*(P-R*w); % Adaptation steps
  wt(:,i) = w;
  if i>=60
      y(i) = s(i:-1:i-59)' * w;  %filter
  end
end

y=[y(2:end);0];

player = audioplayer(d-y,Fs); %Play the audio clip
play(player);
