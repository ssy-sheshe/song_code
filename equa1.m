function dX=equa1(t,X,L1);
global  alpha a b c beta count
a = -1.27;
b = -0.68;
alpha = 10;       %蔡氏系统的参数一定是对应的吗？
beta = 14.87;
c = 6;
[row,col] = size(X);
X=reshape(X,[3,row/3]); %把向量X变成3×200的矩阵
for i=1:row/3
    phi = b*X(1,i) + 0.5*(a-b)*(abs(X(1,i)+1) - abs(X(1,i) - 1)); 
    DX(1,i)=alpha*(X(2,i) - X(1,i)-phi)+c*sum(-L1(i,:).*X(1,:));
    DX(2,i)=X(1,i) - X(2,i) + X(3,i) +c*sum(-L1(i,:).*X(2,:));
    DX(3,i)=-beta * X(2,i) +c*sum(-L1(i,:).*X(3,:));
end
count = count + 1;
dX=DX(:); %把3×200的矩阵变成列向量