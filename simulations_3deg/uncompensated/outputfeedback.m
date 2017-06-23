function [xdot]= outputfeedback(t,x)
%% desired trajectory
a1=0.1; a2=0.1; a3=0.1; per=2; freq=pi/per; %amplitudes and period
qd(1)=a1*cos(freq*t);  
qd(2)=a1*sin(freq*t);
qd(3)=a3*cos(freq*t)+a1;
dqd(1)=-a1*freq*sin(freq*t); 
dqd(3)=-a3*freq*sin(freq*t);
dqd(2)=a1*freq*cos(freq*t); 
ddqd(1)=-a1*(freq^2)*cos(freq*t);
ddqd(2)=-a1*(freq^2)*sin(freq*t);
ddqd(3)=-a3*(freq^2)*cos(freq*t);
%%
%% 
W1=(x(10:25));
W2=(x(26:41)); 
W3=(x(42:57));
W=[W1 W2 W3];
B1=(x(58:60));
B2=(x(61:63));
B3=x(64:66);
B=[B1 B2 B3];

%%
ep=0.005;
lamd1=5;
pi1=[x(67) x(68) x(69)];
pi2=[x(70) x(71) x(72)];
phit=x(73:75);
dpi1=pi2/ep;
dpi2=(-lamd1*pi2-pi1+[x(1) x(2) x(3)])/ep;
%% 
m1=1; m2=0.85; m3=1; l1=0.3; l2=0.4; l3=0.5; %mass of robot arms and length of links
k2=diag([20 20 20]); %controller gains
k1=diag([5 5 5]);
%% computation of the tracking errors
%% computation of the tracking errors
e=[x(1) x(2) x(3)]-qd; 
alp1=-k1*e'+dqd'; 
e2=[x(4) x(5) x(6)]-alp1';  e=e'; e2=e2';
dalp1=-k1*([x(4) x(5) x(6)]'-dqd')+ddqd';
%% computation of mass inertia matrix
i1=0.25*m1*l1^2;
i2=0.25*m2*l2^2;
m11= m3*x(3)^2*(sin(x(2)))^2+m3*l1^2+m2*l1^2+i1;
m12= m3*x(3)*l1*cos(x(2));
m13= m3*l1*sin(x(2));
m21= m3*x(3)*l1*cos(x(2));
m22= m3*x(3)^2+i2;
m23= 0;
m31= m3*l1*sin(x(2));
m32= 0;
m33 = m3;
M = [m11 m12 m13; m21 m22 m23; m31 m32 m33];   
%% computation of C matrix
c11=m3*x(3)^2*sin(x(2))*cos(x(2))*x(5)+m3*x(3)*sin(x(2))^2*x(5);
c12= m3*x(3)^2*sin(x(2))*cos(x(2))*x(4)-m3*l1*x(3)*sin(x(2))*(x(5)+x(6));
c13= m3*x(3)*sin(x(2))^2*x(4)-m3*l1*x(3)*sin(x(2))*x(5);
c21= -m3*x(3)^2*sin(x(2))*cos(x(2))*x(4);
c22= m3*x(3)*x(6);
c23= m3*l1*cos(x(2))*x(4)-m3*x(3)*x(5);
c31= -m3*x(3)*sin(x(2))^2*x(4)+m3*l1*cos(x(2))*x(5);
c32= m3*x(3)*x(5)+m3*l1*cos(x(2))*x(5);
c33= 0;
C=[c11 c12 c13; c21 c22 c23; c31 c32 c33]*[x(4);x(5); x(6)];
 %% computation of G matrix
g1=0;
g2=-m3*9.8*x(3)*cos(x(2));
g3= -m3*9.8*sin(x(2));
G = [g1;g2;g3];
%%  nn parameters
b=0.1;
sigma_w = 0.01;
sigma_b = 0.01;
gam_w = 50*eye(16);
gam_b = 50*eye(3);
% 
variance = 50;
 Node = 2^4;
k = 1;
Mu=zeros(4,16);
for i1 = 1*(-1:2:1)
    for i2 = 1*(-1:2:1)
        for i3 = 1*(-1:2:1)
            for i4 = 1*(-1:2:1)
                Mu(:,k) = [i1,i2,i3,i4];
                k = k+1;
            end
        end
    end
end
 Z=[pi1' pi2' alp1 dalp1]';
Zin=Z(:,1)+Z(:,2)+Z(:,3);
for i =1:Node
    S(i,1)=exp(-(Zin-Mu(:,i))'*(Zin-Mu(:,i))/variance);
end

torque=-e-(k2*e2)-(W'*S);
%% updating laws
 dW = gam_w*( S*e2' - sigma_w*W );
 dB = gam_b*( tanh(e2/b)*e2' -sigma_b*B );
if norm([x(1) x(2) x(3)])>=0
    sgn = 1;
else
    sgn=-1;
end
F=diag([2 2 2])*[x(1) x(2) x(3)]'+1.5*sgn;
%% robot arm dynamics
dphit(1)=1*abs(torque(1)-x(7))*(3.15*torque(1)-phit(1))+0.35*(torque(1)-x(7)); 
dphit(2)=1*abs(torque(2)-x(8))*(3.15*torque(2)-phit(2))+0.35*(torque(2)-x(8)); 
dphit(3)=1*abs(torque(3)-x(9))*(3.15*torque(3)-phit(3))+0.35*(torque(3)-x(9)); 
qdotdot= (M)\(phit-G-C-F);
xdot=[x(4);x(5);x(6);qdotdot(1);qdotdot(2);qdotdot(3)
    (torque(1)-x(7));%%ode will not integrate this, output only
    (torque(2)-x(8));%%ode will not integrate this, ouput only
     (torque(3)-x(9));
    dW(:,1);dW(:,2);dW(:,3); dB(:,1);dB(:,2); dB(:,3);dpi1(1);dpi1(2);dpi1(3);dpi2(1);dpi2(2);dpi2(3);dphit(1);dphit(2);dphit(3)
    ];
