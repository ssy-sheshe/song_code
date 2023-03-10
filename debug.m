clc, clear
N=62;%如果网络修改了，那么节点数也需要修改
%任意删除5%的节点
load('data_1.mat')
L = double(L_dolphin);

save('L.mat','L');

num_del = 6;
eig_debug = algorithm_reproduct(L, num_del);
