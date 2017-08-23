clc;
clear all;

% Discretizacion del impulso
N=input('Introduce el valor de N=');
dt=.01;
t=(0:dt:(N-1)*dt) .';
ts=1;
tp=.1;

% Pulso de ricker
a=pi*(t-ts)/tp;
a2=a.^2;
ft=(a2-1/2).*exp(-a2); 
ft(N,N)=0;

%matriz de e^(+-iwt)
X1=zeros(N,N);
X2=zeros(N,N);

for l=0:N-1;
    for j=0:N-1;
        Wn=exp(-1i*2*pi*l*j/N); %valores de e^(-iwt)
        X1(l+1,j+1)=Wn;
    end
end
Xk=X1*ft; %Multiplicación f(t) * e^-iwt

fp=fft(ft); %Transformada rápida de fourier de f(t)

%Ploteo de imagenes para comparar
figure(1)
subplot(2,1,1)
plot(t,imag(Xk));
xlabel('k')
ylabel('|Xk|')
subplot(2,1,2)
plot(t,imag(fp));
xlabel('k')
ylabel('|angle(Xk)|')

figure(2)
subplot(2,1,1)
plot(t,real(Xk));
xlabel('k')
ylabel('|Xk|')
subplot(2,1,2)
plot(t,real(fp));
xlabel('k')
ylabel('|angle(Xk)|')

figure(3)
subplot(2,1,1)
plot(t,abs(Xk));
xlabel('k')
ylabel('|Xk|')
subplot(2,1,2)
plot(t,abs(fp));
xlabel('k')
ylabel('|angle(Xk)|')

ifp=ifft(fp); %Transformada inversa de fourier

for l=0:N-1;
    for j=0:N-1;
        Wn=exp(1i*2*pi*l*j/N);
        X2(l+1,j+1)=Wn;
    end
end
kp=1/(2*pi)*X2*Xk; %Transformada inversa discreta de fourier

