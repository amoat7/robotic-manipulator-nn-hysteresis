function [xdot]= hyst(t,x)
tau1 = 2.5*sin(2.3*t);
dtau1 = 2.5*2.3*cos(2.3*t);
tau2 = 3.5*sin(2.3*t);
dtau2 = 3.5*2.3*cos(2.3*t);
tau3 = 4.5*sin(2.3*t);
dtau3 = 4.5*2.3*cos(2.3*t);

a= 1;
h = 3.15;
b = 0.35;

du1= (a*abs(dtau1)*(h*tau1-x(1)))+b*dtau1;
du2= (a*abs(dtau2)*(h*tau2-x(2)))+b*dtau2;
du3= (a*abs(dtau3)*(h*tau3-x(3)))+b*dtau3;
xdot=[du1;du2;du3];
