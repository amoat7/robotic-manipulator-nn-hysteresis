clear 
clc
load('state.mat')
load('output.mat')
%% tracking
figure;
subplot(3,1,1)
plot(T,Y(:,1),'b',T,Y2(:,1),'g',T,qd(:,1),'r');
title(' qd1 and q1');
legend('state feedback','output feedback','desired trajectory')
xlabel('t[s]')
ylabel('position[rad]')

subplot(3,1,2)
plot(T,Y(:,2),'b',T,Y2(:,2),'g',T,qd(:,2),'r');
title(' qd2 and q2');
legend('state feedback','output feedback','desired trajectory')
xlabel('t[s]')
ylabel('position[rad]')

subplot(3,1,3)
plot(T,Y(:,3),'b',T,Y2(:,3),'g',T,qd(:,3),'r');
title(' qd3 and q3');
legend('state feedback','output feedback','desired trajectory')
xlabel('t[s]')
ylabel('position[rad]')
 %%  error 
 figure;
subplot(3,1,1)
 plot(T,error(:,1),'b',T,error2(:,1),'g')
 legend('state feedback','output feedback')
 title('e1')
  xlabel('t[s]')
 ylabel('error[rad]')
 
 subplot(3,1,2)
 plot(T,error(:,2),'b',T,error2(:,2),'g')
 legend('state feedback','output feedback')
 title('e2')
 xlabel('t[s]')
 ylabel('error[rad]')
 
 subplot(3,1,3)
 plot(T,error(:,3),'b',T,error2(:,3),'g')
  legend('state feedback','output feedback')
 title('e3')
 xlabel('t[s]')
 ylabel('error[rad]')
 
 %% torques
figure;
subplot(3,1,1)
 plot(T,Y(:,7),'b',T,Y2(:,7),'g')
 legend('state feedback','output feedback')
 title('t1')
  xlabel('t[s]')
 ylabel('input[Nm]')
 
 subplot(3,1,2)
 plot(T,Y(:,8),'b',T,Y2(:,8),'g')
 legend('state feedback','output feedback')
 title('t2')
  xlabel('t[s]')
 ylabel('input[Nm]')
 
 subplot(3,1,3)
 plot(T,Y(:,9),'b',T,Y2(:,9),'g')
 legend('state feedback','output feedback')
 title('t3')
  xlabel('t[s]')
 ylabel('input[Nm]')
 
%% norms
figure;
Y1n=Y(:,10:25);
Y2n=Y(:,26:41);
Y3n=Y(:,42:57);
Y11n=Y2(:,10:25);
Y22n=Y2(:,26:41);
Y33n=Y2(:,42:57);
for i=1:length(T)
    Y1norm(i,:)=norm(Y1n(i,:),1);
    Y2norm(i,:)=norm(Y2n(i,:),1);
    Y3norm(i,:)=norm(Y3n(i,:),1);
   Y11norm(i,:)=norm(Y11n(i,:),1);
    Y22norm(i,:)=norm(Y22n(i,:),1);
    Y33norm(i,:)=norm(Y33n(i,:),1);
end
subplot(3,1,1)
 plot(T,Y1norm,'b',T,Y11norm,'g')
 legend('state feedback','output feedback')
  xlabel('t[s]')
 ylabel('Norm')
legend('state feedback','output feedback')
title('norm of RBF neural network(W1)')

subplot(3,1,2)
 plot(T,Y2norm,'b',T,Y22norm,'g')
 legend('state feedback','output feedback')
  xlabel('t[s]')
 ylabel('Norm')
legend('state feedback','output feedback')
title('norm of RBF neural network(W2)')

subplot(3,1,3)
 plot(T,Y3norm,'b',T,Y33norm,'g')
 legend('state feedback','output feedback')
  xlabel('t[s]')
 ylabel('Norm')
legend('state feedback','output feedback')
title('norm of RBF neural network(W3)')

%% norms of  tanh function
figure;
b1n = Y(:,58:60);
b2n = Y(:,61:63);
b3n = Y(:,64:66);
b11n = Y2(:,58:60);
b22n = Y2(:,61:63);
b33n = Y2(:,64:66);
for i=1:length(T)
    b1norm(i,:)=norm(b1n(i,:),1);
    b2norm(i,:)=norm(b2n(i,:),1);
    b3norm(i,:)=norm(b3n(i,:),1);
   b11norm(i,:)=norm(b11n(i,:),1);
    b22norm(i,:)=norm(b22n(i,:),1);
    b33norm(i,:)=norm(b33n(i,:),1);
end

subplot(3,1,1)
 plot(T,b1norm,'b',T,b11norm,'g')
 legend('state feedback','output feedback')
  xlabel('t[s]')
 ylabel('Norm')
legend('state feedback','output feedback')
title('norm of tanh neural network(B1)')

subplot(3,1,2)
 plot(T,b2norm,'b',T,b22norm,'g')
 legend('state feedback','output feedback')
xlabel('t[s]')
ylabel('Norm')
legend('state feedback','output feedback')
title('norm of tanh neural network(B2)')

subplot(3,1,3)
 plot(T,b3norm,'b',T,b33norm,'g')
 legend('state feedback','output feedback')
  xlabel('t[s]')
 ylabel('Norm')
legend('state feedback','output feedback')
title('norm of tanh neural network(B3)')





