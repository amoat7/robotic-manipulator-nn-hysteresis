clear
clc
t0=0; tf=100;
x0=[0;0;0]; t=linspace(t0,tf,100000);
tau1 = 2.5*sin(2.3*t);
tau2 = 3.5*sin(2.3*t);
tau3 = 4.5*sin(2.3*t);
[T,Y]=ode45('hyst',t,x0);
plot(tau1,Y(:,1),tau2,Y(:,2),tau3,Y(:,3));
xlabel('\tau_{(t)}')
ylabel('\phi_{(t)}')
%%

