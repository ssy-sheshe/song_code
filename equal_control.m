function dX=equal_control(t,Y,delete_list,L1)
global  alpha a b c beta d
a = -1.27;
b = -0.68;
alpha = 10;
beta = 14.87;
c =6;d=255;
[row,col] = size(Y);
Y1 = Y(1:row/2);
Y2 = Y(row/2+1:end);
Y1 = reshape(Y1,[3,row/6]);
Y2=reshape(Y2,[3,row/6]); %把向量X变成3×200的矩阵
DX = zeros(3,row/3);
offset = row/6;
for i=1:row/6
    %加控制Y
    if ismember(i,delete_list)
        phi_1 = b*Y1(1,i) + 0.5*(a-b)*(abs(Y1(1,i)+1) - abs(Y1(1,i) - 1));
        DX(1,i) = alpha*(Y1(2,i) - Y1(1,i)-phi_1)+c*sum(-L1(i,:).*Y1(1,:));
        phi_2 = b*Y2(1,i) + 0.5*(a-b)*(abs(Y2(1,i)+1) - abs(Y2(1,i) - 1));
        DX(1,i+offset) = alpha*(Y2(2,i) - Y2(1,i)-phi_2)+c*sum(-L1(i,:).*Y2(1,:))-2*c*d*(Y2(1,i)-Y1(1,i));
        
        DX(2,i) = Y1(1,i) - Y1(2,i) + Y1(3,i) +c*sum(-L1(i,:).*Y1(2,:));
        DX(2,i+offset) = Y2(1,i) - Y2(2,i) + Y2(3,i) +c*sum(-L1(i,:).*Y2(2,:)) -2*c*d*(Y2(2,i)-Y1(2,i));
        
        DX(3,i) = -beta * Y1(2,i) +c*sum(-L1(i,:).*Y1(3,:));
        DX(3,i+offset) = -beta * Y2(2,i) +c*sum(-L1(i,:).*Y2(3,:))-2*c*d*(Y2(3,i)-Y1(3,i));
%         DX(1,i)=-alpha*(Y1(2,i) - Y1(1,i)-phi_1)+c*sum(L1(i,:).*Y1(1,:))-2*c*d*(Y2(1,i)-Y1(1,i));
%         DX(2,i)=Y1(2,i) - Y1(2,i) + Y1(3,i) +c*sum(L1(i,:).*X(2,:));
%         DX(1,i+200) = alpha*(Y1(2,i) - Y1(1,i)-phi_2)+c*sum(L1(i,:).*Y1(1,:))-2*c*d*(Y2(1,i)-Y1(1,i));
%         DX(3,i)=-beta * X(2,i) +c*sum(L1(i,:).*X(3,:))-2*c*d*(Y2(3,i)-Y1(3,i));
    else
        phi_1 = b*Y1(1,i) + 0.5*(a-b)*(abs(Y1(1,i)+1) - abs(Y1(1,i) - 1));
        phi_2 = b*Y2(1,i) + 0.5*(a-b)*(abs(Y2(1,i)+1) - abs(Y2(1,i) - 1));
        %未加控制X
        DX(1,i) = alpha*(Y1(2,i) - Y1(1,i)-phi_1)+c*sum(-L1(i,:).*Y1(1,:));
        DX(1,i+offset) = alpha*(Y2(2,i) - Y2(1,i)-phi_2)+c*sum(-L1(i,:).*Y2(1,:));
        
        DX(2,i) = Y1(1,i) - Y1(2,i) + Y1(3,i) +c*sum(-L1(i,:).*Y1(2,:));
        DX(2,i+offset) = Y2(1,i) - Y2(2,i) + Y2(3,i) +c*sum(-L1(i,:).*Y2(2,:));
        
        DX(3,i) = -beta * Y1(2,i) +c*sum(-L1(i,:).*Y1(3,:));
        DX(3,i+offset) = -beta * Y2(2,i) +c*sum(-L1(i,:).*Y2(3,:));
%         DX(2,i)=X(1,i) - X(2,i) + X(3,i) +c*sum(L1(i,:).*X(2,:));
%         DX(3,i)=-beta * X(2,i) +c*sum(L1(i,:).*X(3,:));
    end
end
dX=DX(:); %把3×200的矩阵变成列向量