m0=[8]; m=m0; N=100;hold on
for i=1:length(m0)
    lambda=[];NN=[10:10:100];
    for j=1:length(NN)
        A=ones(m0(i)); A(1:m0(i)+1:m0(i)^2)=0; %对角线元素置0
        for k=m0(i)+1:NN(j)
            p=(sum(A)+1)/sum(sum(A)+1); %计算所有节点的连接概率
            pp=cumsum(p); %求累积分布
            A(k,k)=0;   %加入新的连边之前，邻接矩阵扩充维数
            ind=[]; %新节点所连节点的初始集合
            while length(ind)<m(i)
                jj=find(pp>rand); jj=jj(1); %用赌轮法选择连边节点的编号
                ind=union(ind,jj); %使用union保证选择的节点不重复
            end
            A(k,ind)=1; A(ind,k)=1; %构造加边以后新的邻接矩阵
        end
        L2=A-diag(sum(A)); val=eigs(L2,2,'la')
        lambda =[lambda,val(2)];
    end
    plot(NN,lambda),lambda 
end