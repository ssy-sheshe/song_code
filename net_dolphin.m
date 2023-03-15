clc, clear
N=62;%如果网络修改了，那么节点数也需要修改
%任意删除5%的节点
load('data_1.mat')
L = double(L_dolphin);
save('L.mat','L');
num_range = 48;
L_c = 0.285875;
store_eig_max = [];
for i=0:num_range
    num_del = i;
    [matric_w_max,~] = generate_matric_del(L, num_del, 'max');
    eig_w_max = eigs(matric_w_max,1,'sa');
    store_eig_max = [store_eig_max, eig_w_max];
end
plot(0:num_range,store_eig_max, 'Linewidth', 2);
k_max=find(abs(store_eig_max-L_c)<=0.15)%找出交
hold on;

store_eig_min = [];
for i=0:num_range
    num_del = i;
    [matric_w_min,~] = generate_matric_del(L, num_del, 'min');
    eig_w_min = eigs(matric_w_min,1,'sa');
    store_eig_min = [store_eig_min, eig_w_min];
end
plot(0:num_range,store_eig_min, 'Linewidth', 2);
k_min = find(abs(store_eig_min-L_c)<=0.015)%找出交
hold on;

store_eig_random = [];
for i=0:num_range
    num_del = i;
    [matric_w_random,~] = generate_matric_del(L, num_del, 'random');
    eig_w_random = eigs(matric_w_random,1,'sa');
    store_eig_random = [store_eig_random, eig_w_random];
end
plot(0:num_range,store_eig_random, 'Linewidth', 2);
k_random = find(abs(store_eig_random-L_c)<=0.015)%找出交

hold on;
plot([0,num_range],[L_c, L_c],'Linewidth', 2);

hold on;
plot([0,num_range],[2,2],'Linewidth', 2);
legend('max','min','random','location','best');
hold off;