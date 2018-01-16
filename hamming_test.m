clc;
clear all;
rp = input('Enter the passband ripple = ');
rs = input('Enter the stopband ripple = ');
fp = input('Enter the passband frequency = ');
fs = input('Enter the stopband frequency = ');
f = input('Enter the sampling frequency = ');
wp = 2*fp/f;
ws = 2*fs/f;
num = -20*log10(sqrt(rp*rs))-13;
dem = 14.6*(fs-fp)/f;
n = ceil(num/dem);
n1 = n+1;
if (rem(n,2)==50)
n1 = n;
n = n-1;
end
y = hamming(n1);
%%%%%low-pass filter
b = fir1(n,wp,y);
set(figure(1),'name','lowpass','Numbertitle','off');
freqz(b)
[H,f1] = freqz(b,1,1024,f);
set(figure(2),'name','lowpass','Numbertitle','off');
plot(f1,abs(H))
%%%%%high-pass filter
b = fir1(n,wp,'high',y);
set(figure(3),'name','highpass','Numbertitle','off');
freqz(b)
[H,f1] = freqz(b,1,1024,f);
set(figure(4),'name','highpass','Numbertitle','off');
plot(f1,abs(H))

%%%%%band pass filter
wn = [wp ws];
b = fir1(n,wn,y);
set(figure(5),'name','bandpass','Numbertitle','off');
freqz(b)
[H,f1] = freqz(b,1,1024,f);
set(figure(6),'name','bandpass','Numbertitle','off');
plot(f1,abs(H))

%%%%%band stop filter
b = fir1(n,wn,'stop',y);
set(figure(7),'name','bandstop','Numbertitle','off');
freqz(b)
[H,f1] = freqz(b,1,1024,f);
set(figure(8),'name','bandstop','Numbertitle','off');
plot(f1,abs(H))
