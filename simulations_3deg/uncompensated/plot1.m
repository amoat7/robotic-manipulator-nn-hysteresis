clear 
clc
load('state.mat')
load('output.mat')
%% tracking
figure;
subplot(3,1,1)
plot(T,Y(:,1),T,Y2(:,1),T,qd(:,1));
title(' qd1 and q1');
legend('state feedback','output feedback','desired trajectory')
xlabel('t[s]')
ylabel('position[rad]')

subplot(3,1,2)
plot(T,Y(:,2),T,Y2(:,2),T,qd(:,2));
title(' qd2 and q2');
legend('state feedback','output feedback','desired trajectory')
xlabel('t[s]')
ylabel('position[rad]')

subplot(3,1,3)
plot(T,Y(:,3),T,Y2(:,3),T,qd(:,3));
title(' qd3 and q3');
legend('state feedback','output feedback','desired trajectory')
xlabel('t[s]')
ylabel('position[rad]')
 %%  error 
 figure;
subplot(3,1,1)
 plot(T,error(:,1),T,error2(:,1))
 legend('state feedback','output feedback')
 title('e1')
  xlabel('t[s]')
 ylabel('error[rad]')
 
 subplot(3,1,2)
 plot(T,error(:,2),T,error2(:,2))
 legend('state feedback','output feedback')
 title('e2')
 xlabel('t[s]')
 ylabel('error[rad]')
 
 subplot(3,1,3)
 plot(T,error(:,3),T,error2(:,3))
  legend('state feedback','output feedback')
 title('e3')
 xlabel('t[s]')
 ylabel('error[rad]')
 
 %% torques
figure;
subplot(3,1,1)
 plot(T,Y(:,7),T,Y2(:,7))
 legend('state feedback','output feedback')
 title('t1')
  xlabel('t[s]')
 ylabel('input[Nm]')
 
 subplot(3,1,2)
 plot(T,Y(:,8),T,Y2(:,8))
 legend('state feedback','output feedback')
 title('t2')
  xlabel('t[s]')
 ylabel('input[Nm]')

 subplot(3,1,3)
 plot(T,Y(:,9),T,Y2(:,9))
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
 plot(T,Y1norm,T,Y11norm)
 legend('state feedback','output feedback')
  xlabel('t[s]')
 ylabel('Norm')
legend('state feedback','output feedback')
title('norm of RBF neural network(W1)')

subplot(3,1,2)
 plot(T,Y2norm,T,Y22norm)
 legend('state feedback','output feedback')
  xlabel('t[s]')
 ylabel('Norm')
legend('state feedback','output feedback')
title('norm of RBF neural network(W2)')

subplot(3,1,3)
 plot(T,Y3norm,T,Y33norm)
 legend('state feedback','output feedback')
  xlabel('t[s]')
 ylabel('Norm')
legend('state feedback','output feedback')
title('norm of RBF neural network(W3)')

