function value = algorithm_reproduct(matric_src, L)

Matri_A= matric_src;
[row, ~]= size(Matri_A);
%���ݽڵ�ȵĴ�С���У�����ɸѡ
Matri_diag = diag(Matri_A);
[val_A, idx_A] = sort(Matri_diag,'descend');
max_val = val_A(1:L);
max_dim = idx_A(1:L);
Matri_A1 = Matri_A;
Matri_A1(max_dim,:) = [];
Matri_A1(:,max_dim) = [];
lambda1 = eigs(Matri_A1,1,'sa');
%ɾ��������С����ֵ
%����ѭ�������
num = 1;
eig_end =0;
delete_ = -1;
while lambda1 >eig_end
      eig_end = lambda1;
      k = (row - L)*lambda1 - sum(max_val(1:(L-1)));%�õ���һ��ɸѡֵ����Ӧ��ʽ��6��
      [~, idx_2, value_1] = find(Matri_diag>=k);
      %�޳�L�����ȵ�����
      ismax_dim = ismember(idx_2, max_dim);
      idx_2 = idx_2(~ismax_dim);
      value_1 = value_1(~ismax_dim);
      %ɸѡ����С�ȣ������޳�
      min_value_1 = min(value_1);
      ismin_value_1 = ismember(value_1, min_value_1);
      idx_2 = idx_2(~ismin_value_1);
      value_1 = value_1(~ismin_value_1);

      if isempty(value_1)
          fprintf('ɾ��%d���ڵ��Ӧ����С����ֵ�����ֵ��%6.5f\n',L,eig_end)
          if delete_==-1
              fprintf('ɾ��%d���ڵ��Ӧ���ܿؽڵ�%s\n',L,num2str(max_dim))
          else
              fprintf('ɾ��%d���ڵ��Ӧ���ܿؽڵ�%s\n',L,num2str(delete_))
          end
          break
      end
      comb = nchoosek(idx_2,L);%������ڶȵ���Щ�ڵ�
      [comb_row, comb_col] = size(comb);
      comb_new = zeros(comb_row, comb_col);
      for j = 1:length(comb)
          comb_value = Matri_diag(1,comb(j,:));
          if sum(comb_value)/(row-L)>eig_end%��Ӧ��ʽ��11��
              comb_new(j,:) = comb(j, :);
          end
      end
      max_value_in = 0;
        for i=1:comb_row
            if comb_new(i,1)==0
                continue;
            end
            A_in = Matri_A;
            dim = comb_new(i,:);
            A_in(dim(1:L),:) = [];
            A_in(:,dim(1:L)) = [];
            min_eig_in = eigs(A_in,1,'sa');
            if i==1
                max_value_in = min_eig_in;
                delete_ = comb_new(1,:);
            end
            if max_value_in<min_eig_in
                max_value_in = min_eig_in;
                delete_ = comb_new(i,:);
            end
            %count=count+1;
        end
        lambda1 = max_value_in;
end
if delete_~=-1
    fprintf('ɾ��%d���ڵ��Ӧ����С����ֵ�����ֵ��%6.5f\n',L,eig_end)
    fprintf('ɾ��%d���ڵ��Ӧ���ܿؽڵ�%s\n',L,num2str(delete_))
end
end

