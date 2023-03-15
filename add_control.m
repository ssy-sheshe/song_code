clc, clear
N=62;%如果网络修改了，那么节点数也需要修改
%任意删除5%的节点
load('data_1.mat')
L = double(L_dolphin);
save('L.mat','L');
num_del = 6;
[matric_w_max,idx_max] = generate_matric_del(L, num_del, 'max');
[matric_w_min,idx_min] = generate_matric_del(L, num_del, 'min');
[matric_w_random,idx_random] = generate_matric_del(L, num_del, 'random');
idx_algorightm = [10,14,29,42,47,57];

figure('NumberTitle', 'off', 'Name', '度算法');
t0 = 0:0.01:5;
% chuzhi=rand(3,1);
initial_value = unifrnd(-1,1,N*3,1);
[t1,X1]=ode45(@(t,x)equa1(t,x,L),t0,initial_value);
subplot(4,1,1)
plot(t1,X1(:,[1:3:end])) %画出200个节点的x分量的取值
xlabel('\it t'), ylabel('\it x','rotation',0)

%[t2,X2]=ode45(@(t,x)equal_control(t,x,rand_delete,L),t0,unifrnd(-1,1,1200,1));
initial_2 = unifrnd(-1,1,N*6,1);
[t2,X2]=ode45(@(t,x)equal_control(t,x,idx_max,L),t0,initial_2);
%怎么把他们整合到一起

subplot(4,1,2)
% %%第一个分量
plot(t2,X2(:,[end/2+1:3:end])) %画出200个节点的x分量的取值
% plot(t2,X2(:,[end/2+1:end/2+N])) %画出200个节点的x分量的取值
subplot(4,1,3)
%%第一个分量
plot(t2,X2(:,[1:3:end/2])-X2(:,[end/2+1:3:end])) %画出200个节点的x分量的取值
% plot(t2,X2(:,[1:N])-X2(:,[end/2+1:end/2+N]))
xlabel('\it t'), ylabel('\it x','rotation',0)
subplot(4,1,4)
error = X2(2:length(t2),1) - X2(1:length(t2)-1,1);
plot(t2(2:length(t2)),error)

figure('NumberTitle', 'off', 'Name', '随机算法');
subplot(4,1,1)
plot(t1,X1(:,[1:3:end])) %画出200个节点的x分量的取值
xlabel('\it t'), ylabel('\it x','rotation',0)

%[t2,X2]=ode45(@(t,x)equal_control(t,x,rand_delete,L),t0,unifrnd(-1,1,1200,1));
initial_2 = unifrnd(-1,1,N*6,1);
[t3,X3]=ode45(@(t,x)equal_control(t,x, idx_random,L),t0,initial_2);
%怎么把他们整合到一起

subplot(4,1,2)
% %%第一个分量
plot(t3,X3(:,[end/2+1:3:end])) %画出200个节点的x分量的取值
% plot(t2,X3(:,[end/2+1:end/2+N]))
subplot(4,1,3)
%%第一个分量
plot(t3,X3(:,[1:3:end/2])-X3(:,[end/2+1:3:end])) %画出200个节点的x分量的取值
% plot(t2,X3(:,[1:N])-X3(:,[end/2+1:end/2+N]))
xlabel('\it t'), ylabel('\it x','rotation',0)
subplot(4,1,4)
error = X3(2:length(t3),1) - X3(1:length(t3)-1,1);
plot(t3(2:length(t3)),error)

figure('NumberTitle', 'off', 'Name', '本文算法');
subplot(4,1,1)
plot(t1,X1(:,[1:3:end])) %画出200个节点的x分量的取值
xlabel('\it t'), ylabel('\it x','rotation',0)

%[t2,X2]=ode45(@(t,x)equal_control(t,x,rand_delete,L),t0,unifrnd(-1,1,1200,1));
initial_2 = unifrnd(-1,1,N*6,1);
[t4,X4]=ode45(@(t,x)equal_control(t,x, idx_algorightm,L),t0,initial_2);
%怎么把他们整合到一起

subplot(4,1,2)
% %%第一个分量
plot(t4,X4(:,[end/2+1:3:end])) %画出200个节点的x分量的取值
%plot(t2,X3(:,[end/2+1:end/2+N]))
subplot(4,1,3)
%%第一个分量
plot(t4,X4(:,[1:3:end/2])-X4(:,[end/2+1:3:end])) %画出200个节点的x分量的取值
% plot(t2,X3(:,[1:N])-X3(:,[end/2+1:end/2+N]))
xlabel('\it t'), ylabel('\it x','rotation',0)
subplot(4,1,4)
error = X4(2:length(t3),1) - X4(1:length(t3)-1,1);
plot(t4(2:length(t4)),error)
