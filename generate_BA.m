function Matric_BA = generate_BA(m0, NN)
lambda=[];
A=ones(m0); A(1:m0+1:m0^2)=0; %�Խ���Ԫ����0
for k=m0+1:NN
    p=(sum(A)+1)/sum(sum(A)+1); %�������нڵ�����Ӹ���
    pp=cumsum(p); %���ۻ��ֲ�
    A(k,k)=0;   %�����µ�����֮ǰ���ڽӾ�������ά��
    ind=[]; %�½ڵ������ڵ�ĳ�ʼ����
    while length(ind)<m0
        jj=find(pp>rand); jj=jj(1); %�ö��ַ�ѡ�����߽ڵ�ı��
        ind=union(ind,jj); %ʹ��union��֤ѡ��Ľڵ㲻�ظ�
    end
    A(k,ind)=1; A(ind,k)=1; %����ӱ��Ժ��µ��ڽӾ���
end
L2=A-diag(sum(A)); val=eigs(L2,2,'la');
lambda =[lambda,val(2)];
Matric_BA = L2;
end
