m0=[8]; m=m0; N=100;hold on
for i=1:length(m0)
    lambda=[];NN=[10:10:100];
    for j=1:length(NN)
        A=ones(m0(i)); A(1:m0(i)+1:m0(i)^2)=0; %�Խ���Ԫ����0
        for k=m0(i)+1:NN(j)
            p=(sum(A)+1)/sum(sum(A)+1); %�������нڵ�����Ӹ���
            pp=cumsum(p); %���ۻ��ֲ�
            A(k,k)=0;   %�����µ�����֮ǰ���ڽӾ�������ά��
            ind=[]; %�½ڵ������ڵ�ĳ�ʼ����
            while length(ind)<m(i)
                jj=find(pp>rand); jj=jj(1); %�ö��ַ�ѡ�����߽ڵ�ı��
                ind=union(ind,jj); %ʹ��union��֤ѡ��Ľڵ㲻�ظ�
            end
            A(k,ind)=1; A(ind,k)=1; %����ӱ��Ժ��µ��ڽӾ���
        end
        L2=A-diag(sum(A)); val=eigs(L2,2,'la')
        lambda =[lambda,val(2)];
    end
    plot(NN,lambda),lambda 
end