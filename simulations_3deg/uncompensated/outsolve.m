clear
clc
tic;
t0=0; tf=20;
x0=zeros(75,1); t=linspace(t0,tf,300);
[T,Y]=ode15s('outputfeedback',t,x0);
%% desired trajectory
a1=0.1; a2=0.1; per=2; freq=pi/per; a3=0.1; %amplitudes and period
qd(:,1)=a1*cos(freq*T);  
qd(:,3)=a3*cos(freq*T)+a2;
qd(:,2)=a2*sin(freq*T);
%% plot of torques;
figure
plot(T,Y(:,7),'r',T,Y(:,8),'b',T,Y(:,9),'g');
title('torque')
legend('t1','t2','t3');
%% plot error
figure; 
error(:,1)=-Y(:,1)+qd(:,1);
error(:,2)=-Y(:,2)+qd(:,2);
error(:,3)=-Y(:,3)+qd(:,3);
plot(T,error);
title('error');
%% plot of actual trajectory and desired trajectory
figure;
subplot(3,1,1)
plot(T,Y(:,1),'r',T,qd(:,1),'b');
title('desired trajectory qd1 and actual trajectory q1');
subplot(3,1,2)
plot(T,Y(:,2),'r',T,qd(:,2),'b');
title('desired trajectory qd1 and actual trajectory q2');
subplot(3,1,3)
plot(T,Y(:,3),'r',T,qd(:,3),'b');
title('desired trajectory qd1 and actual trajectory q2');
toc;