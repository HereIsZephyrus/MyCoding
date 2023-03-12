clc;clear;close all;
N=1024;
x=linspace(-10*pi,10*pi,N+1);
y=x.^2.*cos(x);
z=sin(x)./x;
Fix=2;
figure(1);clf;
subplot(3,2,1);
plot(x,y,'b');
axis([-10*pi-Fix 10*pi+Fix -100*pi^2-Fix 100*pi^2+Fix])
title('Signal Y');
subplot(3,2,2);
plot(x,z,'r');
axis([-10*pi-Fix 10*pi+Fix -0.5 1])
title('Signal Z');
subplot(3,2,3);
y_fft=fft(y,N,1);
y_fft_ifft=ifft(y_fft);
plot(x,y-real(y_fft_ifft(1:1000)),'b');
%axis([-10*pi-Fix 10*pi+Fix -100*pi^2-Fix 100*pi^2+Fix])
title('Signal Y by FFT');
subplot(3,2,4);
z_fft=fft(z,N,1);
plot(x,z_fft,'r');
%axis([-10*pi-Fix 10*pi+Fix -0.5 1])
title('Signal Z by FFT');
