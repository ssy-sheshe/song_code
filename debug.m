clc, clear
N=62;%��������޸��ˣ���ô�ڵ���Ҳ��Ҫ�޸�
%����ɾ��5%�Ľڵ�
load('data_1.mat')
L = double(L_dolphin);

save('L.mat','L');

num_del = 6;
eig_debug = algorithm_reproduct(L, num_del);
